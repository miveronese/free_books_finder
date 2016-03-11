require 'nokogiri'
require 'open-uri'

def books_per_page(page_number)
  base_url = "http://www.amazon.com/Best-Sellers-Kindle-Store-Science-Fiction/zgbs/digital-text/158591011/ref=zg_bs_158591011"
  page_url = "_pg_1?_encoding=UTF8&pg=#{page_number}&tf=2"
  url = base_url + page_url
  page = Nokogiri::HTML(open(url))
  puts titles(page)
end

def titles(page)
  books = page.css(".zg_title a")
  books.map do |book|
    book.text + book["href"]
  end
end

def question(i)
  puts "want to see more titles?(y/n)"
  answer = gets.chomp
  if answer == "y"
    i = i+1
    books_per_page(i.to_s)
    question(i)
  end
end

i = 1
books_per_page(i.to_s)
question(i)
