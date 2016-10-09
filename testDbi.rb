# -*- coding: utf-8 -*-
require 'date'
require 'dbi'

class Hanabi
	def initialize(name, desc)
		@name = name
		@desc = desc
	end
	attr_accessor :name, :desc
	def to_s
		"#{@name},#{@desc}"
	end
	def toFormatString(sep= "\n")
		"名前:#{@name}#{sep}役柄:#{@desc}#{sep}"
	end
end

class HanabiCasting
	def initialize(sqlite)
		@db = sqlite
		@dbh = DBI.connect("DBI:SQLite3:#{@db}")
		@item = {}
	end
	def init
		puts "\n0. データの初期化"
		print "初期化しますか？（Y/yなら初期化を実行します）"
		answer = gets.chomp.upcase
		if /^Y$/ =~ answer
			#hanabiInfoがある場合は削除する
			@dbh.do("drop table if exists hanabiInfo")
			#hanabiInfoがない場合はテーブル作成
			@dbh.do("create table hanabiInfo (
				id    varchar(50)   not null,
				name  varchar(100)  not null,
				desc  varchar(100)  not null
			);")
			puts "\n初期化しました"
		end
	end
	def add
		puts "\n1. データの登録"
		print "データを登録します"
		hanabi = Hanabi.new("", "")
		print "\n"

		print "キー:"
		key = gets.chomp

		print "名前："
		hanabi.name = gets.chomp
		print "役柄："
		hanabi.desc = gets.chomp

		flag = 0
		#もし名前か役柄が入力されていたらflagに1を代入
		flag = 1 if hanabi.name != '' || hanabi.desc != ''
		#flagが1なら
		if flag == 1
			p flag
			#hanabiInfoにターブルの項目を入力する
			@dbh.do("insert into hanabiInfo values(
				\'#{key}\',
				\'#{hanabi.name}\',
				\'#{hanabi.desc}\'
			);")
			puts "\n登録しました"
		else
			print "入力してください"
		end
	end
	def list
		counts = 0
		#テーブルの項目を日本語に変えるハッシュ
		@item = {id: 'キー', name: '名前:', desc: '役柄'}
		puts "\n2. データの表示"

		#テーブルからデータを読み込んで表示
		sth = @dbh.execute("select * from hanabiInfo")
		#select分を1件ずつrowに取り出し繰り返し処理
		sth.each do |row|
			puts "\n-----------------------------"
			#each_with_nameメソッドで値と項目名を取り出す
			row.each_with_name do |value, name|
				#@itemで項目名を日本語に変換
				puts "#{@item[name]}#{value.to_s}"
			end
			puts "\n-----------------------------"
			counts += 1
		end
		#実行結果の解放
		sth.finish
		# 0件ならエラー文言それ以外なら件数表示
		displayCount = (counts == 0) ? "\n 登録されていません" : "\n#{counts}件のデータを表示します"
		print displayCount
	end
	def modify
		puts "\n3. データの修正"
		print "データを修正します。"
		hanabi = Hanabi.new("", "")
		print "\n"

		print "キー:"
		key = gets.chomp

		print "名前："
		hanabi.name = gets.chomp
		print "役柄："
		hanabi.desc = gets.chomp

		# レコードのデータを修正する
		@dbh.do("update hanabiInfo
			set id	= \'#{key}\',
				  name	= \'#{hanabi.name}\',
			    desc	= \'#{hanabi.desc}\';
		")
		puts "\n修正しました"
	end
	def delete
		puts "\n8. データの削除"
		print "キー:"
		key = gets.chomp
		print "このレコードを削除しますか？（Y/yなら削除を実行します）："

		answer = gets.chomp.upcase
		if /^Y$/ =~ answer
			# keyと照合して合致すればそのレコードを削除する
			@dbh.do("delete from hanabiInfo where id = \'#{key}\';")
			puts "\n削除しました"
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
hanabiCasting = HanabiCasting.new('hanabiData.db')

hanabiCasting.run