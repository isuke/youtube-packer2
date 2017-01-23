$ = require('jquery')
Vue = require('vue')

$ ->
  window.app = new Vue
    el: '#app'
    data:
      url: undefined
      title: undefined
      width: 640
      height: 360
      youtube_ids: []
      options: [
        "autoplay=1",
      ]
    computed:
      src: ->
        head = @youtube_ids[0]
        tail = @youtube_ids.slice(1)
        "https://www.youtube.com/embed/#{head}?playlist=#{tail.join(',')}&#{@options.join('&')}"
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
          @youtube_ids = json.youtube_ids
        .fail (response) =>
          console.error response
      smallVideoSize: ->
        @width = 640
        @height = 360
      largeVideoSize: ->
        @width = 1280
        @height = 720
