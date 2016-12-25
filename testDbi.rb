# -*- coding: utf-8 -*-
require 'date'
require 'dbi'

class Hanabi
  def initialize(actor, character)
    @actor = actor
    @character = character
  end
  attr_accessor :actor, :character
  def to_s
    "#{@actor}, #{@character}"
  end
end

class HanabiCasting
  def initialize(sqlite)
    @db = sqlite
    @dbh = DBI.connect("DBI:SQLite3:#{@db}")
    @player = {}
  end
  def init
    print "\n 0.データの初期化"
    print "初期化しますか？（Y/yなら初期化を実行します）"

    answer = gets.chomp.upcase
    if /^Y$/ =~ answer
      @dbh.do("drop table if exists hanabi")
      @dbh.do("create table hanabi(
        id         varchar(50)  not null,
        actor      varchar(100) not null,
        character  varchar(100) not null,
        primary    key(id)
      );")
      puts "\n初期化しました"
    end
  end
  def add
    hanabi = Hanabi.new(" ", " ")
    print "\n 1.データの登録"
    print "データを登録します"

    print "\n"
    print "キー:"
    key = gets.chomp

    print "名前:"
    hanabi.actor = gets.chomp
    print "どんな役:"
    hanabi.character = gets.chomp

    if hanabi.actor != '' && hanabi.character != ''
      @dbh.do("insert into hanabi values(
        \'#{key}\',
        \'#{hanabi.actor}\',
        \'#{hanabi.character}\'
      )")
      puts "入力しました"
    else
      puts "入力してください"
    end
  end
  def list
    counts = 0
    # テーブルの項目を日本語に変えるハッシュ。シンボルだと上手く変換できないので、文字列のhashを使用している。
    # 参考URL: http://qiita.com/QUANON/items/169c73425a6bc50dee51
    @item = {'id' => 'キー', 'actor' => '名前', 'character' => 'どんな役'}
    puts "\n データの表示"
    #テーブルからデータを読み込んで表示
    sth = @dbh.execute("select * from hanabi")
    #rowに1件分の情報が入ってる
    sth.each do |row|
      puts "\n-----------------------------"
      #rowに1件分の情報があるので、そこからeach_with_actorメソッドで値と項目名を取り出す
      row.each_with_name do |value, index|
        print "#{@item[index]}: #{value.to_s}\n"
      end
      puts "\n-----------------------------"
      counts += 1
    end
    #実行結果の解放
    sth.finish
    # 0件ならエラー文言、それ以外なら件数表示
    displayCount = (counts == 0) ? "\n登録されていません" : "\n#{counts}件のデータを表示します"
    puts displayCount
  end
  def modify
    print "\n3. データの修正"
    print "データを修正します"

    hanabi = Hanabi.new(" ", " ")
    print "\n"

    print "キー:"
    key = gets.chomp

    print "名前:"
    hanabi.actor = gets.chomp
    print "どんな役:"
    hanabi.character = gets.chomp

    if hanabi.actor != '' && hanabi.character != ''
      # レコードのデータを修正する
      @dbh.do("update hanabi
        set id = \'#{key}\',
            actor = \'#{hanabi.actor}\',
            character = \'#{hanabi.character}\'
      where id = \'#{key}\';
      ")
      puts "\n修正しますた"
    else
      puts "\n内容がないので修正できません"
    end

  end
  def delete
    print "\n8. データの削除"
    print "キー:"
    key = gets.chomp
    print "このレコードを削除しますか？（Y/yなら削除を実行します):"

    answer = gets.chomp.upcase
    if /^Y$/ =~ answer
      # keyと照合して合致すればそのレコードを削除する
      @dbh.do("delete from hanabi where id = \'#{key}\';")
      puts "\n削除しますた"
    end
  end
  def run
    while true
      print "
        0. データの初期化
        1. データの登録
        2. データの表示
        3. データの修正
        8. データの削除
        9. 終了
      "
      num = gets.chomp
      case
        when "0" == num
          init
        when "1" == num
          add
        when "2" == num
          list
        when "3" == num
          modify
        when "8" == num
          delete
        when "9" == num
          break;
        else
      end
    end
  end
end


hanabiCasting = HanabiCasting.new('hanabi.db')

puts hanabiCasting.run