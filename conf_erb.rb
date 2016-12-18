# -*- coding:utf-8 -*-
require 'webrick'               # WEBrickを使うときには記述する
require 'erb'
require 'dbi'

# これがないと日本語入力したときエラーになる
# 修正パッチ
class String
  alias_method(:orig_concat, :concat)
  def concat(value)
    if RUBY_VERSION > "2.3"
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

server.mount_proc('/list') { |req, res|

  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    p req.query
    target_id = $1
    operation = $2

    if operation == 'delete'
      template = ERB.new( File.read('delete.erb'))
    elsif operation == 'edit'
      template = ERB.new(File.read('edit.erb'))
    end
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
    @dbh.do("insert into hanabi \ values(
      '#{req.query['id']}',\
      '#{req.query['cast']}',\
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

  unless search_title.empty?
    search_title.map! { |name| "#{name}='#{req.query[name]}'" }
    where_data = "where " + search_title.join('or')

    template = ERB.new( File.read('searched.erb'))
    res.body << template.result(binding)
  else
    where_data = ""
  end
}

# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start