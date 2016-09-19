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



#size: lengthと同じ。文字列中の文字の数を返す

#times: 一定の回数だけ同じ処理をさせるメソッド。
#参考URL: http://d.hatena.ne.jp/sandai/20090203/p1

#ゲッター、名前　年齢を個別に表示できる
#セッター、名前、年齢を変更できる
#ゲッターがないとセッターが表示されたない
#セッター
# def name=(value)
# name=と(value)にスペースがエラーがおきる
#アクセスメソッドでゲッターセッターを簡単に定義できる
# attr_accessor :name, :age

#ハッシュ
#個別の呼び出しかたは puts hoge[:fuga]
#要素すべての呼び出しかたは hoge.each { |key, value| puts "#{key} #{value}"}

#配列
#hoge = [fuga, zuga]
#ハッシュ
#hoge = { fuga: 'fuga', zuga: 'zuga'}

#getsメソッド キーボードからの入力を待つ。改行まで読み込むと、getsメソッドが終了して次の処理へ進みます。
#chompメソッド 入力に含まれている改行文字を取り除く

#while ture
# ループさせる時に使用
# while true endの枠内で書けばループをぬけることができる
# while true
# 	ループさせるコード
# 	break ←処理を抜けるときはbreakを使用
# end


#細かな点
# def initialize(name, age)
# 		#濁点があると、putsで配列が表示されてしまう
# 		@name = name,
# 		@age = age
# 	end
# [hoge, fuga], hoge

#toFormatStringの中でputsしない。 ハッシュのタイトルが一番下に表示されてしまう
# def  toFormatString(sep = "\n")
# 	"#{@title}#{sep}#{@author}#{sep}#{@page}#{sep}#{@publish_date}#{sep}"
# end

#クラス内でputsしてたら、一番下のプロパティでputsしない
#したら中身全部呼ばれる
#悪い例:
#class Member
#	def print
#		@cast.each{ |key, value|
#			puts "#{key}: #{value}.toFormatString"
#		}
#	end
#end
#member = Member.new
#puts member.list


#変数にkeyがないとエラーになる
# def setUpPlayer
# open(@csv, "r:UTF-8") {|file|
# 	file.each {|value|
# 		key, name, position, number = value.chomp.split(',')
# 		# 蔵書データ1件分のインスタンスを作成してハッシュに登録する
# 		@player[key] = 
# 		OsakaToin.new(name, position, number.to_i)
# 	}
# }
# # @player['大阪桐蔭投手: 選手紹介'] = OsakaToin.new("根尾昴", "投手", 18)
# # @player["大阪桐蔭内野手: 選手紹介"] = OsakaToin.new("永広", "二塁手", 5)
# end



# class Student
# 	def initialize(name, age)
# 		@name = name
# 		@age = age
# 	end
# 	def to_s
# 		"#{@name},#{@value}"
# 	end
# end


# class StudentBook
# 	def initialize
# 		@student = {}
# 	end

# 	def setUpStudent
# 		@student = {
# 			yamada: Student.new('山田', 18),
# 			satou: Student.new('佐藤', 28),
# 			suzuki: Student.new('鈴木', 33)
# 		}
# 	end
# 	def printStudnet
# 		@student.each { |key, value|
# 			puts "#{key}: #{value}"
# 		}
# 	end

# 	def listAllStudent
# 		setUpStudent
# 		printStudnet
# 	end
# end

# studentBook = StudentBook.new
# studentBook.listAllStudent


# class OsakaToin
# 	def initialize(name, age, position, number)
# 		@name = name
# 		@age = age
# 		@position = position
# 		@number = number
# 	end
# 	def to_s
# 		"#{@name},#{@age},#{@position},#{@number}"
# 	end
# 	def toFormattedString()
# 		"名前: #{@name}, 年齢: #{@age}, ポジション: #{@position}, 背番号: #{@number}"
# 	end
# end

# class OsakaToinPlayer
# 	def initialize
# 		@students = {}
# 	end
# 	def setUpStudents
# 		@students = {
# 			player1: OsakaToin.new('根尾昴', 16, '投手', '18番'),
# 			player2: OsakaToin.new('吉澤', 18, '三塁手', '5番')
# 		}
# 	end
# 	def printStudents
# 		@students.each { |key, value|
# 			puts "#{key}, #{value.toFormattedString}"
# 		}
# 	end

# 	def listAllStudents
# 		setUpStudents
# 		printStudents
# 	end
# end

# osakaToinPlayer = OsakaToinPlayer.new()

# osakaToinPlayer.listAllStudents



# class ToinGakuenInfo
# 	def initialize(name, grade, position, number)
# 		@name = name
# 		@grade = grade
# 		@position = position
# 		@number = number
# 	end
# 	attr_accessor :name, :grade, :position, :number
# 	def to_s
# 		"#@name, #@grade, #@position, #@number"
# 	end
# 	def toFormatString(sep = "\n")
# 		[
# 			"選手名: #{@name}",
# 			"学年: #{@grade}",
# 			"ポジション: #{@position}",
# 			"背番号: #{@number}",
# 		].join(sep)
# 	end
# end

# toinGakuenInfo = Hash.new
# toinGakuenInfo["大阪桐蔭選手紹介"] = ToinGakuenInfo.new(
#   '根尾 昴',
#   '一年生',
#   '投手',
#   '16'
#   )
# toinGakuenInfo["大阪桐蔭選手紹介2"] = ToinGakuenInfo.new( 
# 	'永谷 弘樹',
# 	'三年生',
# 	'二塁手',
# 	'18'
# )

# toinGakuenInfo.each { |key, value|
#   puts "#{key}:\n#{value.toFormatString}"
# }

# player = toinGakuenInfo["大阪桐蔭選手紹介2"]
# puts player.name


# class BreakingBad
# 	def initialize(title, cast)
# 		@title = title
# 		@cast = cast
# 	end
# 	def to_s
# 		"#{@title}, #{@cast}"
# 	end
# 	attr_accessor :title, :cast
# 	def toFormatString(sep = "\n")
# 		"番組名: #{@title}#{sep} キャスト: #{@cast}#{sep}"
# 	end
# end

# class BreakingInfo
# 	def initialize
# 		@info = {}
# 	end
# 	def setUP
# 		@info = {
# 			infoVer1: BreakingBad.new('ブレイキングバッド', 'ウオルターホワイト'),
# 			infoVer2: BreakingBad.new('ブレイキングバッド', 'ジェシーピンクマン')
# 		}
# 	end
# 	def add
# 		breakingBad = BreakingBad.new("", "")
# 		print "\n"
# 		print "キー:"
# 		key = gets.chomp

# 		print "番組名:"
# 		breakingBad.title = gets.chomp

# 		print "キャスト:"
# 		breakingBad.cast = gets.chomp
# 		@info[key] = breakingBad
# 	end
# 	def list
# 		@info.each { |key, value|
# 			print value.toFormatString
# 		}
# 	end
# 	def search
# 		breakingBad = BreakingBad.new("", "")
# 		print "\n"
# 		print "番組名:"
# 		breakingBad.title = gets.chomp

# 		print "キャスト:"
# 		breakingBad.cast = gets.chomp

# 		foundBreaking = {}

# 		@info.each { |key, value|
# 			flag = 1
# 			check = 0

# 			if breakingBad != ''
# 				flag = 0 if breakingBad.title =~ /[^"#{value.title}"]/
# 				flag = 0 if breakingBad.cast != value.cast
# 			else
# 				check += 1
# 			end
			
# 			foundBreaking[key] = value if flag == 1 && check < 1
# 		}
# 		puts "\n--------------------------"
# 		if foundBreaking.size > 0
# 			foundBreaking.each { |key, value|
# 				print value.toFormatString
# 			}
# 			puts "\n--------------------------"
# 		else
# 			print "条件に一致する情報がありません"
# 		end
# 	end
# 	def run
# 		while true
# 			print "
# 				1.データの登録
# 				2.データの表示
# 				3.データの検索
# 				9.データの終了
# 			"
# 			num = gets.chomp
# 			case 
# 			when '1' == num
# 				add
# 			when '2' == num
# 				list
# 				add
# 			when '3' == num
# 				search
# 			when '9' == num
# 				break;
# 			else
# 			end
# 		end
# 	end
# end

# breakingInfo = BreakingInfo.new
# breakingInfo.setUP
 # breakingInfo.run
