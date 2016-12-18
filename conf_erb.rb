# -*- coding:utf-8 -*-
require 'webrick'               # WEBrickを使うときには記述する
require 'erb'
require 'dbi'

# これがないと日本語入力したときエラーになる
# 修正パッチ
class String
  alias_method(:orig_concat, :concat)
  def concat(value)
    if RUBY_VERSION > "1.9"
      orig_concat value.force_encoding('UTF-8')
    else
      orig_concat value
    end
  end
end

config = {
  :Port => 8088,
  :DocumentRoot => '.',
  }

# 拡張子erbのファイルをERBを呼び出して処理するERBHandlerと関連付ける
WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)

# WEBrickのHTTP Serverクラスのサーバーインスタンスを作成する
server = WEBrick::HTTPServer.new( config )

# erbのMIMEタイプを設定
server.config[:MimeTypes]["erb"] = "text/html"


server.mount_proc("/init") { |req, res|
  p req.query
  # @dbhを作成し、toinDarta.dbに接続する
  @dbh = DBI.connect('DBI:SQLite3:toinData.db')

  @dbh.do("drop table if exists toinData")
  @dbh.do("create table toinData(
    id        varchar(50)  not null,
    name      varchar(100) not null,
    position  varchar(100) not null,
    grade     varchar(50)  not null,
    primary   key(id)
  );")

  # 処理の結果を表示する
  template = ERB.new(File.read('inited.erb'))
  res.body << template.result( binding )
}

# 一覧表示からの処理
# "http://localhost:8088/list" で呼び出される
server.mount_proc("/list") { |req, res|
  p req.query
  # 'operation'の値の後の（.delete, .edit）で処理を分岐する
  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    target_id = $1
    operation = $2
    # 選択された処理を実行する画面に移行する
    # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
    template = ERB.new(File.read('delete.erb')) if operation == 'delete'
    template = ERB.new(File.read('edit.erb')) if operation == 'edit'
    res.body << template.result(binding)
  else #データが選択されていないなど
    template = ERB.new( File.read('no_selected.erb') )
    res.body << template.result(binding)
  end
}

# 登録からの処理
# "http://localhost:8088/entry" で呼び出される
server.mount_proc("/entry") { |req, res|
  p req.query
  # @dbhを作成し、toinDarta.dbに接続する
  @dbh = DBI.connect('DBI:SQLite3:toinData.db')
  # idが使われていたら登録できない
  rows = @dbh.select_one("select * from toinData where id='#{req.query['id']}';")
  if rows
    # データーベースとの接続終了
    @dbh.disconnect
    # 処理の結果を表示する
    template = ERB.new(File.read('no_entried.erb'))
    res.body << template.result( binding )
  else
    # テーブルにデータを追加する
    @dbh.do("insert into toinData \
      values(
        '#{req.query['id']}',
        '#{req.query['name']}',
        '#{req.query['position']}',
        '#{req.query['grade']}'
      );
    ")
    @dbh.disconnect

    # 処理の結果を表示する
    template = ERB.new(File.read('entried.erb'))
    res.body << template.result( binding )
  end
}

# 検索の処理
# "http://localhost:8088/entry" で呼び出される
server.mount_proc("/search") { |req, res|
  p req.query

  # 検索条件の処理
  condition = ['id', 'name', 'position', 'grade']
  # 問い合わせ以外の条件を削除
  condition.delete_if { |name| req.query[name] == ''}

  if condition.empty?
    where_data = ''
  else
    condition.map! { |name| "#{name}='#{req.query[name]}'"}
    # 要素があるときは、where句に直す
    #（現状、項目ごとの完全一致のorだけ）
    where_data = "where " + condition.join(' or ')
  end

  # 処理の結果を表示する
  # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
  template = ERB.new( File.read('searched.erb') )
  res.body << template.result( binding )
}
# 修正の処理
# "http://localhost:8088/entry" で呼び出される
server.mount_proc("/edit") { |req, res|
  p req.query
  # dbhを作成し、データベース'toinData.db'に接続する
  @dbh = DBI.connect('DBI:SQlite3:toinData.db')
  @dbh.do("update toinData set \
    name='#{req.query['name']}',\
    position='#{req.query['position']}',\
    grade ='#{req.query['grade']}'
    where id='#{req.query['id']}';
  ")
  # データーベースとの接続を終了する
  @dbh.disconnect
  #処理を表示する
  # ERBを、ERBHandlerを軽種せずに直接呼び出して利用している
  template = ERB.new( File.read('edited.erb'))
  res.body << template.result(binding)
}

# 削除の処理
# "http://localhost:8099/delete" で呼び出される
server.mount_proc("/delete") { |req, res|
  p req.query
  # dbhを作成し、データベース'toinData.db'に接続する
  @dbh = DBI.connect('DBI:SQlite3:toinData.db')
  # テーブルからデータを削除する
  @dbh.do("delete from toinData where id='#{req.query['id']}';")
  # データベースの接続を終了する
  @dbh.disconnect

  # 処理の結果を表示する
  # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
  template = ERB.new( File.read('deleted.erb') )
  res.body << template.result(binding)

}


# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start
