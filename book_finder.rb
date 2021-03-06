require 'nokogiri'
require 'open-uri'

def books_per_page(page_number)
  base_url = "http://www.amazon.com/Best-Sellers-Kindle-Store-Science-Fiction/zgbs/digital-text/158591011/ref=zg_bs_158591011"
  page_url = "_pg_1?_encoding=UTF8&pg=#{page_number}&tf=2"
  url = base_url + page_url
  page = Nokogiri::HTML(open(url))
  print_titles(page)
  prompt_for_more(page_number)
end

def print_titles(page)
  titles_and_ranks = page.css(".zg_rankNumber, .zg_title a")
  books = Hash.new
  titles_and_ranks.each_slice(2) do 
    |i| books[i[0]] = i[1] 
  end

  books.map do |rank, title|
    puts rank.text + title.text 
    puts title["href"].strip
    puts "\n"
  end
end

def prompt_for_more(i)
  puts "want to see more titles?(y/n)"
  answer = gets.chomp
  if answer == "y"
    i = i+1
    books_per_page(i)
  end
end

i = 1
books_per_page(i)
