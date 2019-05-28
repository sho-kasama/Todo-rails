require 'open-uri'  # URLにアクセスするためのライブラリの読み込み
require 'nokogiri'  # Nokogirirライブラリの読み込み

url = "http://www.yahoo.co.jp/" # スクレイピング先のURL

charset = nil # charsetを指定しない場合、文字コードはlibxml2の自動判別に頼ることになる
html = open(url) do |f|
    charset = f.charset  # 文字種別を取得している
    f.read # htmlを読み込んで変数htmlに渡す
end

doc = Nokogiri::HTML.parse(html, nil, charset) # htmlをパース(解析)してオブジェクトを生成する

p doc.title # タイトルを表示する
p doc.content
p doc.name