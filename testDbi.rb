# -*- coding: utf-8 -*-
require 'date'
require 'dbi'

class OsakaToin
	def initialize(name, position, grade)
		@name = name
		@position = position
		@grade = grade
	end
	attr_accessor :name, :position, :grade
	def to_s
		"#{@name}, #{@position}, #{@grade}"
	end
end

class OsakaToinPlayer
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
			@dbh.do("drop table if exists toinData")
			@dbh.do("create table toinData(
				id   varchar(50)  not null,
				name varchar(100)  not null,
				position  varchar(100)  not null,
				grade  varchar(50)  not null
			);")
			puts "\n初期化しました"
		end
	end
	def set
		osakaToin = OsakaToin.new(" ", " ", " ")
		print "\n 1.データの登録"
		print "データを登録します"

		print "\n"
		print "キー:"
		key = gets.chomp

		print "名前:"
		osakaToin.name = gets.chomp
		print "ポジション:"
		osakaToin.position = gets.chomp
		print "学年:"
		osakaToin.grade = gets.chomp

		if osakaToin.name != '' && osakaToin.position != '' && osakaToin.grade != ''
			@dbh.do("insert into toinData values(
				\'#{key}\',
				\'#{osakaToin.name}\',
				\'#{osakaToin.position}\',
				\'#{osakaToin.grade}\'
			)")
			puts "入力しました"
		else
			puts "入力してください"
		end
	end
	def list
		counts = 0
		#テーブルの項目を日本語に変えるハッシュ
		@item = {id: 'キー', name: '名前', position: '年齢'}
		puts "\n データの表示"

		#テーブルからデータを読み込んで表示
		sth = @dbh.execute('select * from toinData')
		#select分を1件ずつrowに取り出し繰り返し処理
		sth.each do |row|
			puts "\n-----------------------------"
			#each_with_nameメソッドで値と項目名を取り出す
			row.each_with_name do |value, name|
				print "#{@item[name]} #{value.to_s}"
			end
			puts "\n-------------------------"
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

		osakaToin = OsakaToin.new(" ", " ", " ")
		print "\n"

		print "キー:"
		key = gets.chomp

		print "名前:"
		osakaToin.name = gets.chomp
		print "ポジション:"
		osakaToin.position = gets.chomp
		print "学年:"
		osakaToin.grade = gets.chomp

		# レコードのデータを修正する
		@dbh.do("update toinData
			set id = \'#{key}\',
					name = \'#{osakaToin.name}\',
					position = \'#{osakaToin.position}\',
					grade = \'#{osakaToin.grade}\'
		")
		puts "\n修正しますた"
	end
	def delete
		print "\n8. データの削除"
		print "キー:"
		key = gets.chomp
		print "このレコードを削除しますか？（Y/yなら削除を実行します):"

		answer = gets.chomp.upcase
		if /^Y$/ =~ answer
			# keyと照合して合致すればそのレコードを削除する
			@dbh.do("delete from toinData where id = \'#{key}\';")
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
					set
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


osakaToinPlayer = OsakaToinPlayer.new('toinData.db')

puts osakaToinPlayer.run