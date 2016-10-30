# -*- coding: utf-8 -*-
require 'webrick'               # WEBrickを使うときには記述する
require 'erb'
require 'dbi'

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

# 一覧表示からの処理
# "http://localhost:8099/list" で呼び出される
server.mount_proc("/list") { |req, res|
  p req.query
  # 'operation'の値の後の（.delete, .edit）で処理を分岐する
  if /(.*)\.(delete|edit)$/ =~ req.query['operation']
    target_id = $1
    oparation = $2
    # 選択された処理を実行する画面に移行する
    # ERBを、ERBHandlerを経由せずに直接呼び出して利用している
    template = ERB.new(File.read('delete.erb')) if operation == 'delete'
    template = ERB.new(File.read('edit.erb')) if operation == 'edit'
    res.body << template.result(building)
  else #データが選択されていないなど
    template = ERB.new( File.read('no_selected.erb') )
    res.body << template.result( binding )
  end
}

# Ctrl-C割り込みがあった場合にサーバーを停止する処理を登録しておく
trap(:INT) do
  server.shutdown
end

# 上記記述の処理をこなすサーバーを開始する
server.start
