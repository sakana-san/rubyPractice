# -*- coding: utf-8 -*-
# puts "ようこそorint"
# puts '藤沢へ'
# puts 'hello' << 'world'

# puts 'さよなら' .concat 'バイバイ';

# h = '僕は';
# w = '田中です'

# puts h << w
# prime100 = 541;
# print "100の素数は#{prime100}です"


# require 'date'

# print Date.new(2016,3,3) .to_s


# train_types = ['local', 'lapid', 'express']

# exam_scores = [40, 35, 42, 37, 48]
# fruits_prices = [['apple', 200], ['orenge', 100], ['melon', 600]]

# fruits_prices.each { |fp|
# 	puts "名前: #{fp[0]}, 値段: #{fp[1]}円"
# }

# sum = 0
# fruits_prices.each{ |fp| sum += fp[1]}
# puts "一個ずつ買うと全部でsum円です"

# #　表示したいデータを作成する
# title = '重版出来'
# author = 'TBSテレビドラマ制作委員会'
# leading_actor = '黒沢 心'
# Airdate = '火曜日 夜21時'

# ##作成したデータを表示
# puts title
# puts author
# puts leading_actor
# puts Airdate

# puts '番組名: ' + title
# puts '製作者: ' + author
# puts '主役: ' + leading_actor
# puts '放送日: ' + Airdate

# #表示した蔵所データ作成
# pages = 100
# price = 2890
# tax = 0.08
# purchase_price = price * (1 + tax)

# #蔵所データ表示
# puts 'ページ数' + pages.to_s + 'ページ'
# puts '本体価格' + price.to_s + '円'
# puts '購入費用' + purchase_price.to_s + '円'

# require 'date'

# publish_date = Date.new(2016, 6, 11)
# mon_name = Date::MONTHNAMES[publish_date.mon]
# abbr_mon_name = Date::ABBR_MONTHNAMES[publish_date.mon]

# puts '出版年: ' + publish_date.year.to_s
# puts '出版月: ' + mon_name
# puts '購入日: ' + abbr_mon_name

#蔵所データ本番
require 'date'

#表示したいデータを作成する
titles = [
 '重版出来',
 'ピーヴの遷移'
]
authors = ['黒沢　心', '中田 伯']
phonetic = ['くろさわ こころ', 'なかた はく']
publishers = [
 '週刊バイブス', '興信館'
]
pages = [100, 150]
prices = [580, 620]
purchase_prices = [650, 700]

isbn_10s = ['4883732088', '4883733458']
publish_dates = [Date.new(2016, 6, 11), Date.new(2016, 6, 18)]

#蔵所データを表示させる

titles.size.times{ |i|
puts '--------------------------------------'
puts '書籍名: ' + titles[i]
puts '著者名: ' + authors[i]
puts '出版社: ' + publishers[i]
puts 'ページ数: ' + pages[i].to_s
puts '値段' + prices[i].to_s
puts '購入価格' + purchase_prices[i].to_s
puts 'ISBN' + isbn_10s[i]
puts '購入日' + publish_dates[i].to_s

}


