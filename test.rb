# -*- coding: utf-8 -*-
require 'date'


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
  def initialize
    @cast = {}
  end
  def set
    @cast = {
        member1: Hanabi.new('のりみち', '主人公、なづなが好き'),
        member2: Hanabi.new('なづな', 'のりみちを密かに想う少女、複雑な家庭の中で育つ'),
        member3: Hanabi.new('ゆうすけ', 'のりみちの友達、なづなが好きでのりみちをライバル視している'),
        member4: Hanabi.new('純一', 'のりみちの友達、和弘と花火が丸いか平べったいかで揉める。平べったい派。三浦先生が好き。'),
        member5: Hanabi.new('和弘', 'のりみちの友達、純一と花火が丸いか平べったいかで揉める。丸い派。灯台で花火を見る計画をたてた'),
        member6: Hanabi.new('稔', 'のりみちの友達、一番小さいが、大人ぶって花火に行くなんてダサいと発言して、純一たちにからかわれる')
    }
  end
  def add
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
      @cast[key] = hanabi
    else
      print "入力してください"
    end
  end
  def prints
    puts "\n-----------------------------"
    @cast.each { |key, value|
      print value.toFormatString
      puts "\n-----------------------------"
    }
  end
  def search
    hanabi = Hanabi.new("", "")
    print "\n"
    print "キー:"
    key = gets.chomp

    print '名前:'
    hanabi.name = gets.chomp
    print '役柄:'
    hanabi.desc = gets.chomp

    @foundCast = {}


    @cast.each do |key, value|
      # hanabiに入力されていたら
      if hanabi != ''
        flag = 1
        check = 0
        flag = 0 if hanabi.name =~ /^"#{value.name}"/
        flag = 0 if hanabi.desc != value.desc
        @foundCast[key] = value if flag == 1 && check < 1
      else
        check += 1
      end
    end
    # @foundCastの件数が上記でエラーもかからず0でなければ
    if @foundCast.size > 0
      puts "\n-----------------------------"
      @foundCast.each do |key, value|
        print value.toFormatString
        puts "\n-----------------------------"
      end
    else
      puts "指定された条件がありません"
    end
  end
  def run
    while true
      print "
				1. データ登録
				2. データの表示
				3. データの検索
				9. 終了
			"
      num = gets.chomp
      case
        when "1" == num
          add
        when "2" == num
          prints
        when "3" == num
          search
        when "9" == num
          break;
        else
      end
    end
  end
end

hanabiCasting = HanabiCasting.new

hanabiCasting.set
hanabiCasting.run


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

# #while true内に
# print "
# 				1. データ登録
# 				2. データの表示
# 				3. データの検索
# 				9. 終了
# 			"
# num = gets.chomp
#を書かないと永遠ループしてしまう。
# while trueは条件がtrueになった時にループが止まる。


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



# class CreatorsFileAkiyama
#   def initialize(name, trade)
#     @name = name
#     @trade = trade
#   end
#   attr_accessor :name, :trade
#   def to_s
#     "#{@name},#{@trade}"
#   end
#   def toFormatString(sep="\n")
#     "名前: #{@name}, 職業:#{@trade}#{sep}"
#   end
# end
#
# class AkiyamaCharactor
#   def initialize
#     @cast = {}
#   end
#   def add
#     creatorsFileAkiyama = CreatorsFileAkiyama.new("", "")
#     print"\n"
#     print "キー"
#     key = gets.chomp
#
#     print "名前:"
#     creatorsFileAkiyama.name = gets.chomp()
#     print "職業:"
#     creatorsFileAkiyama.trade = gets.chomp()
#
#     unless creatorsFileAkiyama.name == '' || creatorsFileAkiyama.trade == ''
#       @cast[key] = creatorsFileAkiyama
#     else
#       errorAnswer = '入力してください'
#       puts errorAnswer
#     end
#   end
#   def list
#     @cast.each do |index, value|
#       puts value.toFormatString
#     end
#   end
#   def search
#     creatorsFileAkiyama = CreatorsFileAkiyama.new("", "")
#     print"\n"
#     print "キー"
#     key = gets.chomp
#     print "名前:"
#     creatorsFileAkiyama.name = gets.chomp()
#     print "職業:"
#     creatorsFileAkiyama.trade = gets.chomp()
#
#     @foundCast = {}
#     @cast.each do |index, value|
#       flag = 1
#       check = 0
#       if creatorsFileAkiyama != ''
#         flag = 0 if creatorsFileAkiyama.name =~ /^"#{value.name}"/
#         flag = 0 if creatorsFileAkiyama.trade != value.trade
#       else
#         check += 1
#       end
#       @foundCast[key] = value if flag == 1 && check < 1
#       if @foundCast.size > 0
#         puts "-------------------------------------"
#         @foundCast.each do |index, value|
#           puts value.toFormatString
#           puts "-------------------------------------"
#         end
#       else
#         puts '指定された項目が入力されていません'
#       end
#     end
#   end
#   def modify
#     creatorsFileAkiyama = CreatorsFileAkiyama.new("", "")
#     print"\n"
#     print "キー"
#     key = gets.chomp
#     print "名前:"
#     creatorsFileAkiyama.name = gets.chomp()
#     print "職業:"
#     creatorsFileAkiyama.trade = gets.chomp()
#     @modifyCast = {}
#     @cast.each do |index, value|
#       if creatorsFileAkiyama != '' && index == key
#         value.name = creatorsFileAkiyama.name
#         value.trade = creatorsFileAkiyama.trade
#         return @modifyCast[key] = value
#       else
#         puts '指定された項目が入力されていません'
#       end
#     end
#
#   end
#   def run
#     while true
#       print "
#         1, データの登録
#         2. データの表示
#         3. データの検索
#         4. データの修正
#         9. 終了
#       "
#       num = gets.chomp()
#       case
#         when "1" == num
#           add
#         when "2" == num
#           list
#         when "3" == num
#           search
#         when "4" == num
#           modify
#         when "9" == num
#           break;
#         else
#       end
#     end
#   end
# end
#
# akiyama =  AkiyamaCharactor.new
# akiyama.run