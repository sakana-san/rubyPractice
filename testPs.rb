# -*- coding: utf-8 -*-
require 'date'
require 'pstore'


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
	def initialize(pstore)
		@db = PStore.new(pstore)
	end
	# def set
	# 	@cast = {
	# 		member1: Hanabi.new('のりみち', '主人公、なづなが好き'),
	# 		member2: Hanabi.new('なづな', 'のりみちを密かに想う少女、複雑な家庭の中で育つ'),
	# 		member3: Hanabi.new('ゆうすけ', 'のりみちの友達、なづなが好きでのりみちをライバル視している'),
	# 		member4: Hanabi.new('純一', 'のりみちの友達、和弘と花火が丸いか平べったいかで揉める。平べったい派。三浦先生が好き。'),
	# 		member5: Hanabi.new('和弘', 'のりみちの友達、純一と花火が丸いか平べったいかで揉める。丸い派。灯台で花火を見る計画をたてた'),
	# 		member6: Hanabi.new('稔', 'のりみちの友達、一番小さいが、大人ぶって花火に行くなんてダサいと発言して、純一たちにからかわれる')
	# 	}
	# end
	def add
		hanabi = Hanabi.new('', '')
		print "\n"
		print 'キー:'
		key = gets.chomp

		print '名前:'
		hanabi.name = gets.chomp
		print '役柄:'
		hanabi.desc = gets.chomp

		flag = 0
		flag = 1 if hanabi.name != '' || hanabi.desc != ''
		if flag == 1
			# 作成したデータを1件分をPStoreデータベースに登録する
			@db.transaction do
				@db[key] = hanabi
			end
		else
			print '入力してください'
		end
	end
	def prints
		puts "\n-----------------------------"
		@db.transaction(true) do #読み込みモード
			# rootsがキーの配列を返し、eachで1件ずつ処理する
			@db.roots.each { |key|
				#得られたキーを使ってPstoreからデータを取得
				puts "キー: #{key}"
				print @db[key].toFormatString
				puts "\n-----------------------------"
			}
		end
	end
	def search
		hanabi = Hanabi.new('', '')
		print "\n"
		print 'キー:'
		key = gets.chomp

		# 空白入力でなければ
		if key != ''
			@db.transaction do
				#Pstoreからのデータがあれば出力、なければエラー文言を返す
				searchAnswer = (@db.root?(key)) ? @db[key].toFormatString : '指定された条件がありません'
				print searchAnswer
			end
		else
			print '入力してください'
		end
	end
	def deleteCast
		hanabi = Hanabi.new('', '')
		print "\n"
		print 'キー:'
		key = gets.chomp

		# 空白入力でなければ
		if key != ''
			@db.transaction do
				if @db.root?(key)
					print @db[key].toFormatString
					print "\n削除しますか?(Y/yなら削除を実行します):"
					answer = gets.chomp.upcase
					if /^Y$/ =~ answer
						@db.delete(key)
						puts "\nデータベースから削除しました"
					end
				else
					print '指定された条件がありません'
				end
			end
		else
			print '入力してください'
		end
	end
	def run
		while true
			print '
				1. データ登録
				2. データの表示
				3. データの検索
				8. データの削除
				9. 終了
			'
			num = gets.chomp
			case
				when '1' == num
					add
				when '2' == num
					prints
				when '3' == num
					search
				when '8' == num
					deleteCast
				when '9' == num
					break;
				else
			end
		end
	end
end

hanabiCasting = HanabiCasting.new('cast.db')

hanabiCasting.run