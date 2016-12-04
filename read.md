# ruby環境設定

* 既存 ruby -version
    * ruby 2.0.0p648 (2015-12-16 revision 53162)

* 変えるversion
    * ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin15]

## readline環境設定
`brew install readline`

```
ruby ビルドとかに必要なパス⬇︎
LDFLAGS:  -L/usr/local/opt/readline/lib
CPPFLAGS: -I/usr/local/opt/readline/include
```

## openssll環境設定
`brew install openssl`

```
ruby ビルドとかに必要なパス⬇︎
LDFLAGS:  -L/usr/local/opt/openssl/lib
CPPFLAGS: -I/usr/local/opt/openssl/include
```


## rbenv rubyの環境が選べる
`brew install rbenv`

### PATHを通す
/Users/sakana/にある.zshrcファイルに記述

```
# User configuration
export PATH="$HOME/.rbenv/bin:$PATH" 
if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi
```

### ruby-buildでruby2.3.1をビルドする
`CONFIGURE_OPTS="--with-readline-dir=/usr/local/opt--with-openssl-dir=/sur/local/opt" rbenv install 2.3.1`

### 使用するバージョンを切り替える
rbenv global 2.3.1

### rehashする(最近はいらない説がある)
rehash