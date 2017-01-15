# 作りながら学ぶ ruby エラー帳

## rubyのハッシュについて--------------------------------------------

### rubyのhashはkeyが文字列かシンボルかどうか区別する
- シンボル
```
hoge = { satoshi: ‘聖’, murayama: ‘村山’ }
hoge[:satoshi]  #=> “聖”
hoge[‘satoshi’] #=>  nil
```

- 文字列
```
hoge = {‘satoshi’ =>  ‘聖’, ‘murayama’ =>   ‘村山’ }
hoge[:satoshi] #=> nil
hoge[‘satoshi’] #=>  “聖”
```

`key`が文字列かシンボルか意識しなくても 
valueを取り出たいときにrubyのメソッドを使わなければいけない。

- 参考URL
    - http://qiita.com/QUANON/items/169c73425a6bc50dee51

## バグ①
- 登録でエラー
```
testDbi.rb:43:in `add': undefined method `cast=' for #<Hanabi:0x007feec300bbd0 @cast=" ", @desc=" "> (NoMethodError)
from testDbi.rb:82:in `run'
from testDbi.rb:98:in `<main>'

attr_accessorがないと、データ登録、変更でエラーがかかる
```

## バグ②
- ERROR SyntaxError: (erb):70: syntax error, unexpected end-of-input, expecting keyword_end

ようは、if文のendがないぜって言われている
http://qiita.com/scivola/items/3017068a354892b239f4


## バグ③
- near "=": syntax error
かなり謎なエラー。
testDbi.rbで変数名にcastを使うと、erb側で必ずエラーが起きる。
それ以外の変数名ならいける。

## バグ④
- undefined local variable or method  ‘target_id’for main:Object
edited.erbにtarget_idは必要ないのに、使っていたのでエラーが起きた

## バグ⑤
登録してるのに表示されない場合は、
 **<%= require[name] %>** の **=** が抜けている可能性が高いのでそこをチェックする




