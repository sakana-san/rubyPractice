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


# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start
