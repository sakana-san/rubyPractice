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

# erbを呼び出してerbHandlerと関連付ける
WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)

# WEBrickのHTTP Serverクラスのサーバーインスタンスを作成する
server = WEBrick::HTTPServer.new(config)

# erbのMIMEタイプを設定
server.config[:MimeTypes]["erb"] = " text/html"

server.mount_proc("/list") { |req, res|
  p req.query
  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    target_id = $1
    operation = $2

    template = ERB.new(File.read('delete.erb')) if operation == 'delete'
    template = ERB.new(File.read('edit.erb')) if operation == 'edit'
    res.body << template.result(binding)
  else
    template = ERB.new(File.read('noselected.erb'))
    res.body << template.result(binding)
  end
}

server.mount_proc("/entry") { |req, res|
  p req.query
  # @dbhを作成し、toinDarta.dbに接続する
  @dbh = DBI.connect('DBI:SQLite3:hanabi.db')
  # idが使われていたら登録できない
  rows = @dbh.select_one("select * from hanabi where id='#{req.query['id']}';")
  if rows
    # データーベースとの接続終了
    @dbh.disconnect
    # 処理の結果を表示する
    template = ERB.new(File.read('noentried.erb'))
    res.body << template.result( binding )
  else
    # テーブルにデータを追加する
    @dbh.do("insert into hanabi \
      values(
        '#{req.query['id']}',
        '#{req.query['cast']}',
        '#{req.query['role']}'
      );
    ")
    @dbh.disconnect
    binding.pry
    # 処理の結果を表示する
    template = ERB.new(File.read('entried.erb'))
    res.body << template.result( binding )
  end
}

# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start