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

# -------------------------------------------------------------------------------------
# ブランチが複雑なので一旦説明します

# ●feature/ruby_production_application 選手データの完成品が入っている。今実装には関係ないのでいじらない
# ●feature/ruby_production_application_dev 打ち上げ花火の完成品が入っている。基本的にはここをいじらない
# ●feature/ruby_production_application_dev_mounting 練習用の何も入っていないdefaultのブランチ。ここにいろいろ入れていく
# ●feature/ruby_production_application_dev_mounting_list listページを作るブランチ。作り終えたら、ruby_production_application_dev_mounting
#  にmergeする

# 基本的には1ページずつブランチを作って、feature/ruby_production_application_dev_mountingにmergeしていく
# -------------------------------------------------------------------------------------

# 一覧表示の処理(list.erb)
server.mount_proc("/list") { |req, res|
  p "一覧の処理#{req.query}"
  # 'operation'値の後の（.delete, .edit）で処理を分岐する
  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    template = ERB.new(File.read('delete.erb')) if operation == 'delete'
    template = ERB.new(File.read('edit.erb')) if operation == 'edit'
    res.body << template.result(binding)
  else
    #削除と修正が選択されなかった時ここに入ってくる
    template = ERB.new(File.read('no_selected.erb'))
    res.body << template.result(binding)
  end
}

# データ登録の処理(entry.erb)
server.mount_proc("/entry") { |req, res|

  p "データの登録#{req.query}"

  # dbhを作成する
  @dbh = DBI.connect("DBI:SQLite3:toinTest.db")

  #idが使われていたら登録させない
  @rows = @dbh.select_one("select * from toinTest where id = '#{req.query['id']}';")

  if @rows
    @dbh.disconnect
    template = ERB.new(File.read('no_entried.erb'))
    res.body << template.result(binding)
  else
    @dbh.do("insert into toinTest values(
      '#{req.query['id']}',
      '#{req.query['casts']}',
      '#{req.query['desc']}'
    );")
    @dbh.disconnect
    template = ERB.new(File.read('entried.erb'))
    res.body << template.result(binding)
  end
}

# データ登録の処理(search.erb)
server.mount_proc("/search") { |req, res|

  p "データの検索#{req.query}"

  search_label = ['id', 'casts', 'desc']
  #条件以外を削除
  search_label.delete_if { |name| req.query[name] == ' '}

  if search_label.empty?
    where_data = ' '
  else
    #要素を検索条件文字列に変換
    search_label.map! { |name|
      "#{name}='#{req.query[name]}'"
    }
    where_data = "where " + search_label.join(' or ')
  end
  template = ERB.new(File.read('searched.erb'))
  res.body << template.result(binding)
}

# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start
