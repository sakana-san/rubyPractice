# -*- coding: utf-8 -*-
require 'date'

class Student
	def initialize(name, age)
		@name = name
		@age = age
	end
	def to_s
		"#{@name},#{@value}"
	end
end



class StudentBook
	def initialize
		@student = {}
	end

	def setUpStudent
		@student = {
			yamada: Student.new('山田', 18),
			satou: Student.new('佐藤', 28),
			suzuki: Student.new('鈴木', 33)
		}
	end
	def printStudnet
		@student.each { |key, value|
			puts "#{key}: #{value}"
		}
	end

	def listAllStudent
		setUpStudent
		printStudnet
	end
end

studentBook = StudentBook.new
studentBook.listAllStudent



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