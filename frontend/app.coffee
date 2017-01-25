$ = require('jquery')
Vue = require('vue')
Toastr = require('toastr')

$ ->
  window.app = new Vue
    el: '#app'
    data:
      url: undefined
      title: undefined
      playerSize: 'small'
      youtubeIds: []
      options: [
        "autoplay=1",
      ]
    computed:
      src: ->
        head = @youtubeIds[0]
        tail = @youtubeIds.slice(1)
        "https://www.youtube.com/embed/#{head}?playlist=#{tail.join(',')}&#{@options.join('&')}"
      playerWidth: ->
        switch @playerSize
          when 'small'
            640
          when 'large'
            1280
      playerHeight: ->
        switch @playerSize
          when 'small'
            360
          when 'large'
            720
    methods:
      submit: ->
        return if @url == undefined || @url.length == 0
        $.ajax
          url: "/youtube_ids.json"
          type: 'GET'
          data:
            url: @url
        .done (response) =>
          json = JSON.parse response
          @title       = json.title
          @youtubeIds  = json.youtubeIds
        .fail (response) =>
          json = JSON.parse response.responseText
          Toastr.error('', json.errorMessage)
      compressVideoSize: -> @playerSize = 'small'
      expandVideoSize: ->   @playerSize = 'large'
