require 'nokogiri'
require 'open-uri'
require 'csv'

urls = %w(
  https://qiita.com/search?q=ruby,
  https://qiita.com/search?q=php,
  https://qiita.com/search?q=swift
)
titles = []

charset = nil
urls.each do |url|
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)
  doc.xpath('//h1[@class="searchResult_itemTitle"]').each do |node|
    title = node.css('a').inner_text
    titles.push(title)
  end
end

CSV.open("qiita_title.csv", "w") do |csv|
  csv << titles
end