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

class NotURLError < StandardError; end
class NotFoundYoutubeMovie < StandardError; end

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
  begin
    @error_message = nil

    @url = params[:url]
    doc = Nokogiri::HTML(open(@url))

    @title = doc.title
    @youtube_ids = youtube_ids doc

    raise NotFoundYoutubeMovie if @youtube_ids.empty?

  rescue OpenURI::HTTPError, SocketError, Errno::ENOENT, NotURLError
    status 400
    @error_message = 'This value is incorrect url.'
  rescue NotFoundYoutubeMovie
    status 400
    @error_message = 'Not found YouTube movie from this site.'
  end

  rabl :youtube_ids
end
