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

server.mount_proc("/init") { |req, res|
  p req.query
  # @dbhを作成し、hanabi.dbに接続する
  @dbh = DBI.connect('DBI:SQLite3:hanabi.db')

  @dbh.do("drop table if exists hanabi")
  @dbh.do("create table hanabi(
    id       varchar(50)  not null,
    cast     varchar(100)  not null,
    role     varchar(100)  not null,
    primary  key(id)
  );")

  # 処理の結果を表示する
  template = ERB.new(File.read('inited.erb'))
  res.body << template.result( binding )
}

server.mount_proc('/list') { |req, res|

  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    p req.query
    target_id = $1
    operation = $2

    template = ERB.new(File.read('delete.erb')) if operation == 'delete'
    template = ERB.new(File.read('edit.erb')) if operation == 'edit'
    res.body << template.result(binding)
  else
    template = ERB.new(File.read('no_selected.erb'))
    res.body << template.result(binding)
  end
}

server.mount_proc('/entry') { |req, res|
  p req.query

  @dbh = DBI.connect ('DBI:SQLite3:hanabi.db')
  @rows = @dbh.select_one("select * from hanabi where id='#{req.query['id']}';")

  unless @rows
    @dbh.do("insert into hanabi values(
      '#{req.query['id']}',
      '#{req.query['cast']}',
      '#{req.query['role']}'
    );")
    @dbh.disconnect
    template = ERB.new( File.read('entried.erb'))
    res.body << template.result(binding)
  else
    @dbh.disconnect
    template = ERB.new( File.read('no_entried.erb'))
    res.body << template.result(binding)
  end
}

server.mount_proc('/search') { |req, res|
  p req.query

  search_title = ['id', 'cast', 'role']

  search_title.delete_if { |name|
    req.query[name] == ''
  }

  if search_title.empty?
    where_data = " "
  else
    search_title.map! {|name| "#{name}='#{req.query[name]}'"}
    where_data = "where " + search_title.join(' or ')
  end
  # if文の中に入れるとnear=syntax errorが表示される
  template = ERB.new( File.read('searched.erb'))
  res.body << template.result(binding)
}

# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start