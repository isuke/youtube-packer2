$ = require('jquery')
Vue = require('vue')

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
        $.ajax
          url: "/youtube_ids.json"
          type: 'GET'
          data:
            url: @url
        .done (response) =>
          console.log response
          json = JSON.parse response
          @title       = json.title
          @youtubeIds  = json.youtubeIds
        .fail (response) =>
          console.error response
      compressVideoSize: -> @playerSize = 'small'
      expandVideoSize: ->   @playerSize = 'large'
