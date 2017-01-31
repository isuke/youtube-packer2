<template lang="pug">
.front
  h3.front__title YoutubePacker2
  .front__description
    p Extract YouTube movies from URL, And pack these to a playlist.
    p Enter URL that you want to make playlist.
  .front__search
    input.front__search__url(type="url" v-model="url" placeholder="http://...")
    button.front__search__submit(v-on:click="submit") submit

  .front__video
    h1.front__video__title(v-text="title")
    iframe.front__video__player(
      type="text/html"
      frameborder="0"
      v-bind:width="playerWidth"
      v-bind:height="playerHeight"
      v-bind:src="src"
      v-if="youtubeIds.length > 0"
    )
    .front__video__buttons
      button.front__video__buttons__compress_btn(v-if="playerSize === 'large'" v-on:click="compressVideoSize")
        i.fa.fa-compress
      button.front__video__buttons__expand_btn(v-if="playerSize === 'small'" v-on:click="expandVideoSize")
        i.fa.fa-expand
</template>

<script lang="coffee">
module.exports = {
  data: ->
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
}
</script>

<style lang="scss" scoped>
.front {
  padding-top: 10px;
  text-align: center;

  &__description {
    font-size: small;
  }

  &__search {
    display: flex;

    &__url {
      flex: 1;
    }
    &__submit {
      width: 100px;
      margin: 0;
    }
  }
}
</style>
