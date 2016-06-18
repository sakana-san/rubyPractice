# -*- coding: utf-8 -*-
require 'date'

# titles = [
# 	'ドラゴンボール',
# 	'寄生獣'
# ]
# author = [
# 	'鳥山明',
# 	'岩本明宏',
# ]
# yomi = [
# 	'とりやまあきら',
# 	'いわもとあきひろ'
# ]
# publishers = [
# 	'集英社',
# 	'講談社'
# ]
# pages = [177, 344]
# prices = [500, 1000]

# publish_date = [
# 	Date.new( 2016, 6, 19),
# 	Date.new( 2016, 8, 30),
# ]

# titles.size.times{|i| 
# 	puts '書籍名: ' + titles[i]
# 	puts '著者: ' + author[i]
# 	puts 'かな: ' + yomi[i]
# 	puts '出版社: ' + publishers[i]
# 	puts 'ページ: ' + pages[i].to_s
# 	puts '値段: ' + prices[i].to_s
# 	puts '購入日: ' + publish_date[i].to_s
# }

# class Manga
# 	def initialize(name, price)
# 		@name = name
# 		@price = price
# 	end

# 	attr_accessor :name, :price

# 	def to_s
# 		"#{@name}, #{@price}"
# 	end
# end

# db = Manga.new('ドラゴンボール: ', 500)
# ch = Manga.new('シティーハンター:', 500)

# puts db.to_s
# puts ch.to_s

# puts "氏名: #{db.name}、年齢: #{db.price}円"
# puts "氏名: #{ch.name}、年齢: #{ch.price}円"

# db.name = 'オラ孫悟空'
# db.price = 1000


# puts "氏名: #{db.name}、年齢: #{db.price}円"



class BookInfo

	def initialize(title, author, page, publish_date)
		@title = title
		@author = author
		@page = page
		@publish_date = publish_date
	end

	attr_accessor :title, :author, :page, :publish_date

	def to_s
		"#{@title}, #{@author}, #{@page}, #{@publish_date},"
	end

	def toFormattedString( sep = "\n")
		"書籍名: #{@title}#{sep}著者名: #{@author}#{sep}ページ数: #{@page}#{sep}購入日: #{@publish_date}#{sep}"
		
	end
end 


book_info = BookInfo.new(
	'ドラゴンボール',
	'鳥山明',
	500,
	Date.new(2016, 06 ,19)
)


puts book_info.to_s

book_info.title = 'ゲレクシス'
book_info.author = '古谷実'

puts "書籍名: #{book_info.title}"
puts "著者: #{book_info.author}"
puts "ページ: #{book_info.page.to_s}"
puts "購入日: #{book_info.publish_date.to_s}"

puts book_info.toFormattedString("/")























