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
		"#{@name}, #{@desc}"
	end
	def toFormatString(sep="\n")
		"名前:#{@name}#{sep}役柄:#{@desc}#{sep}"
	end
end

class HanabiCasting
	def initialize(sqlite)
		@dbName = sqlite
		@dbh = DBI.connect("DBI:SQLite3:#{@dbName}")
		@item = {}
	end
	def initHanabi
		puts "\n0. データの初期化"
		print "初期化しますか？（Y/yなら削除を実行します）："
		answer = gets.chomp.upcase
		if /^Y$/ =~ answer
			@dbh.do("drop table if exists HanabiInfo")
			@dbh.do("create table HanabiInfo (
				id    varchar(50)  not null,
				name  varchar(50)  not null,
				desc  varchar(100)  not null
			);")
			puts "\nデーターを初期化しました。"
		end
	end
	def add
		puts "\n1. データの登録"
		print "データを登録します。"

		hanabi = Hanabi.new("", "")
		print "\n"

		print "キー:"
		key = gets.chomp
		print '名前:'
		hanabi.name = gets.chomp
		print '役柄:'
		hanabi.desc = gets.chomp

		flag = 0
		flag = 1 if hanabi.name != '' || hanabi.desc != ''
		if flag == 1
			@dbh.do("insert into HanabiInfo values(
				\'#{key}\',
				\'#{hanabi.name}\',
				\'#{hanabi.desc}\'
			);")
			puts "\n登録しました。"
		else
			print "入力してください"
		end
	end
	def prints
		@item = {'id' => 'キー', 'name' => '名前', 'desc' => '役柄'}

		puts "\n2. データの表示"
		print "データを表示します。"

		sth = @dbh.execute("select * from HanabiInfo")

		count = 0
		sth.each do |row|
			puts "\n-----------------------------"
			row.each_with_name do |val, name|
				puts "#{@item[name]}: #{val.to_s}"
			end
		end
		puts "\n-----------------------------"
		count += 1
	end
	def modify
		puts "\n3. データの修正"
		print "データを修正します。"
		hanabi = Hanabi.new("", "")
		print "\n"

		print "キー:"
		key = gets.chomp
		print '名前:'
		hanabi.name = gets.chomp
		print '役柄:'
		hanabi.desc = gets.chomp

		@dbh.do("update HanabiInfo 
			set id = \'#{key}\',
				name = \'#{hanabi.name}\',
				desc = \'#{hanabi.desc}\';
		")
		puts "\n修正しました。"
	end
	def deleteHanabi
		hanabi = Hanabi.new("", "")
		puts "\n8. データの削除"
		print "キー:"
		key = gets.chomp
		print "このレコードを削除ますか？（Y/yなら削除を実行します）："

		answer = gets.chomp.upcase
		if /^Y$/ =~ answer
			@dbh.do("delete from HanabiInfo where id = \'#{key}\';")
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
				initHanabi
			when "1" == num
				add
			when "2" == num
				prints
			when "3" == num
				modify
			when "8" == num
				deleteHanabi
			when "9" == num
				break;
			else
			end
		end
	end
end

hanabiCasting = HanabiCasting.new('hanabiData.db')

hanabiCasting.run
