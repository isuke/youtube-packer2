require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require 'open-uri'
require 'rabl'

class String
  URL_REG = /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+/

  def url?
    self =~ URL_REG
  end
end

helpers do
  YOUTUBE_REG = /((www\.youtube\.com)|(youtu\.be))\/((watch\?v=)|(v\/)|(embed\/)?)([A-Za-z0-9_-]{11})/

  def youtube_ids(doc)
    result = []
    ['iframe[src]', 'object > embed[src]'].each do |css|
      doc.css(css).each do |d|
        tmp = YOUTUBE_REG.match(d['src'])
        result << tmp[8] unless tmp.nil? || result.include?(tmp[8])
      end
    end
    result
  end
end

get '/' do
  slim :app
end

get '/youtube_ids.json' do
  url = params[:url]
  doc = Nokogiri::HTML(open(url))

  @title = doc.title
  @youtube_ids = youtube_ids doc

  # @title = "debug"
  # @youtube_ids = ["GOP5kIzaWQE","UbkwELpUhmA","pFqs9rwakjc","RiYYYv6VQrA","rMhWhQv7nFc","wpQKLMg-AJk","6is0zT1Qf-0","HMMqJs7WVtY","DHmYC8a_4cI","csisM0fshrU","jFBv-sf8qGs","ypULrLzKRb0","GHG3e0bQe3I","wqtGqIuP8ZE","6zzgBFoBrNo"]

  rabl :youtube_ids
end
