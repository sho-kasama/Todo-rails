require 'open-uri'
require 'nokogiri'

# スクレイピング先のURL
url = 'http://matome.naver.jp/tech'

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを作成
doc = Nokogiri::HTML.parse(html, nil, charset)

doc.xpath('//li[@class="mdTopMTMList01Item"]').each do |node|
  # tilte
  p node.css('h3').inner_text

  # 記事のサムネイル画像
  p node.css('img').attribute('src').value

  # 記事のサムネイル画像
  p node.css('a').attribute('href').value
end
