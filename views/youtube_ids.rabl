object false

if @error_message.nil?
  node(:url) { @url }
  node(:title) { @title }
  node(:youtubeIds) { @youtube_ids }
else
  node(:errorMessage) { @error_message }
end
