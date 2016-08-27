# -*- coding: utf-8 -*-
require 'date'


class OsakaToin
	def initialize(name, position, number)
		@name = name
		@position = position
		@number = number
	end
	attr_accessor :name, :position, :number
	def to_s
		"#{@name}, #{@position}, #{@number}"
	end
	def toFormattedString(sep = "\n")
		"名前: #{@name}#{sep} ポジション: #{@position}#{sep} 背番号: #{@number}#{sep}"
	end
end

class OsakaToinPlayer
	def initialize
		@player = {}
	end
	def setUpPlayer
		@player['大阪桐蔭投手: 選手紹介'] = OsakaToin.new("根尾昴", "投手", 18)
		@player["大阪桐蔭内野手: 選手紹介"] = OsakaToin.new("永広", "二塁手", 5)
	end
	def addOsakaToinPlayer
		osakaToin = OsakaToin.new("", "", "")
		print "\n"
		print "キー"
		key = gets.chomp
		print "名前:"
		osakaToin.name = gets.chomp
		print "ポジション:"
		osakaToin.position = gets.chomp
		print "背番号:"
		osakaToin.number = gets.chomp
		@player[key] = osakaToin
	end
	def listAllPlayer
		puts "\n---------------"
		@player.each { |key, value|
			print value.toFormattedString()
		}
		puts "\n---------------"
	end
	def searchPlayer
		osakaToin = OsakaToin.new("", "", "")
		print "\n"
		print "名前:"
		osakaToin.name = gets.chomp
		print "ポジション:"
		osakaToin.position = gets.chomp
		print "背番号:"
		osakaToin.number = gets.chomp.to_i

		search = osakaToin
		foundPlayer = {}

		@player.each { |key, value|
			search_flag = 1
			input_check = 0

			#もし選手名が空ではなくて
			if search!= ''
				#search.nameとvalue.nameがマッチしなかった時、search_flagに0を代入
				#逆に言うと、マッチしたらsearch_flagに1を代入
				search_flag = 0 if search.name =~ /[^"#{value.name}"]/

				#search.positionとvalue.positionが1文字でも違えばsearch_flagに0を代入する
				search_flag = 0 if search.position != value.position
				search_flag = 0 if search.number != value.number
			else
				#もし選手名が空だったら1を追加する
				input_check += 1
			end
			foundPlayer[key] = value if search_flag == 1 && input_check < 1
		}
		puts "\n---------------"
		if foundPlayer.size > 0
			foundPlayer.each { |key, value|
				print value.toFormattedString()
			}
			puts "\n---------------"
		else
			print "条件に一致する選手がいてません"
		end
	end
	def run
		while true
			print "
				1. 選手の登録
				2. 選手の表示
				3. 選手の検索
				9. 終了
				番号を選んでください(1,2,3,9)："
			num = gets.chomp
			case
			when '1' == num
				addOsakaToinPlayer
			when '2' == num
				listAllPlayer
			when '3' == num
				searchPlayer
			when '9' == num
				break;
			else
			end
		end
	end
end

osakaToinPlayer = OsakaToinPlayer.new

osakaToinPlayer.setUpPlayer
osakaToinPlayer.run


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
breakingInfo.run