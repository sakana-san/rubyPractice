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