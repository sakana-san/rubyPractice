# -*- coding: utf-8 -*-
require 'date'

class Manga
	def initialize(name, num)
		@name = name
		@num = num
	end
	attr_accessor :name, :num
	def to_s
		"#{@name}, #{@num}"
	end
	def toFormatString(sep="\n")
		"タイトル: #{@name}#{sep}巻数: #{@num}#{sep}"
	end
end

class MangaList
	def initialize
		@list = {}
	end
	def set
		@list = {
			ptn1: Manga.new('ジブリ', 1),
			ptn2: Manga.new('こち亀', 3)
		}
	end
	def add
		manga = Manga.new("", "")
		print "キー"
		key = gets.chomp

		print "名前:"
		manga.name = gets.chomp

		print "巻数:"
		manga.num = gets.chomp.to_i

		#み入力の場合はエラーを吐かせる
		if manga.name != '' && manga.num != ''
			# 作成したデータ1件分をハッシュに登録する
			@list[key] = manga
		else
			puts "\n--------------------------"
			print "入力してください"
			puts "\n--------------------------"
		end
	end
	def list
		@list.each { |key, value|
			print value.toFormatString
		}
	end
	def search
		manga = Manga.new("", "")
		print "キー"
		key = gets.chomp

		print "タイトル:"
		manga.name = gets.chomp

		print "巻数:"
		manga.num = gets.chomp.to_i
		
		@foundManga = {}
		# データを1件ずつ取り出して検索と比較する
		@list.each { |key, value|
			flag = 1 # 検索条件と一致しているか
			check = 0 # 検索条件が未入力か
			if @list != ''
				flag = 0 if manga.name =~ /[^"#{value.name}"]/
				flag = 0 if manga.num != value.num
			else
				check += 1;
			end
			# 比較が一致したらvalueを入力、未入力の場合は格納しない
			@foundManga[key] = value if flag == 1 && check < 1
		}
		puts "\n--------------------------"
		if @foundManga.size > 0
			#比較が一致したデータを表示
			@foundManga.each { |key, value|
				print value.toFormatString
			}
			puts "\n--------------------------"
		else
			print "情報に一致する情報がありません"
		end
	end
	def run
		while true
			print "
				1. データの登録
				2. データの表示
				3. 検索
				9. 終了
			"
			num = gets.chomp
			case
			when "1" == num
				add
			when "2" == num
				list
			when "3" == num
				search
			when "9" == num
				break;
			else
			end
		end
	end
end

mangaList = MangaList.new

mangaList.set
mangaList.run
