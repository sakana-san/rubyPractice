●SASSの書き方

mixin test
↓
=test

@include test
↓
+test

extendでパーシャルを使う場合は
↓
@extend %test


clearfixの使い方

.test
	.alignLeft
		float: left;
	@extend %clearfix

[コンパイル後]
.test:after {
	content: " ";
	display: table;
	clear: both;
}

# ブランチが複雑なので一旦説明します

- feature/ruby_studyLesson
    - 選手データのtestDbi.rbが入っている。ここからdatabaseを作成している
- feature/ruby_studyLesson_dev
    - 花火データのtestDbi.rbが入っている。ここからdatabaseを作成している

- feature/ruby_production_application
    - 選手データの完成品が入っている。今実装には関係ないのでいじらない
- feature/ruby_production_application_dev
    - 打ち上げ花火の完成品が入っている。基本的にはここをいじらない
- feature/ruby_production_application_dev_mounting
    - 練習用の何も入っていないdefaultのブランチ。ここにいろいろ入れていく
- feature/ruby_production_application_dev_mounting_○◯
    - ○◯ページを作るブランチ。作り終えたら、ruby_production_application_dev_mountingにmergeする

#### 基本的には1ページずつブランチを作って、feature/ruby_production_application_dev_mountingにmergeしていく
