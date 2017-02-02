<template lang="pug">
.front
  .front__wrapper
    h3.front__title YoutubePacker2
    .front__description
      p Extract YouTube movies from URL, And pack these to a playlist.
      p Enter URL that you want to make playlist.
    .front__search
      input.front__search__url(type="url" v-model="inputUrl" placeholder="http://...")
      button.front__search__submit(v-on:click="submit") submit

    .front__video
      h2: a.front__video__title(v-bind:href="$store.state.url" target="_blank" v-text="$store.state.title")
      iframe.front__video__player(
        type="text/html"
        frameborder="0"
        v-bind:width="playerWidth"
        v-bind:height="playerHeight"
        v-bind:src="src"
        v-if="$store.state.youtubeIds.length > 0"
      )
  .front__video_btns
    button.front__video__buttons__compress_btn(v-if="playerSize === 'large'" v-on:click="compressPlayerSize")
      i.fa.fa-compress
    button.front__video__buttons__expand_btn(v-if="playerSize === 'small'" v-on:click="expandPlayerSize")
      i.fa.fa-expand
  .front__menu_toggle
    button.front__video__buttons__expand_btn(v-on:click="toggleSide")
      i.fa.fa-bars
</template>

<script lang="coffee">
module.exports = {
  data: ->
    inputUrl: undefined
    playerSize: 'small'
    options: [
      "autoplay=1",
    ]
  computed:
    src: ->
      head = @$store.state.youtubeIds[0]
      tail = @$store.state.youtubeIds.slice(1)
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
      return if @inputUrl == undefined || @inputUrl.length == 0
      $.ajax
        url: "/youtube_ids.json"
        type: 'GET'
        data:
          url: @inputUrl
      .done (response) =>
        json = JSON.parse response
        @$store.commit('setPlayer', json)
        @$store.commit('pushPlaylist', json)
        @_savePlaylist(json)

        @inputUrl = undefined
      .fail (response) =>
        json = JSON.parse response.responseText
        Toastr.error('', json.errorMessage)
    compressPlayerSize: -> @playerSize = 'small'
    expandPlayerSize: ->   @playerSize = 'large'
    toggleSide: -> @$store.commit('toggleSide')
    _savePlaylist: (json) ->
      LocalStorage.set(json.youtubeIds.join(''), json)
}
</script>

<style lang="scss" scoped>
.front {
  display: flex;
  justify-content: center;
  padding-top: 10px;
  text-align: center;

  &__wrapper {
    flex-basis: 640px;
  }

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

  &__video_btns {
    position: fixed;
    top: 0;
    left: 10px;
  }

  &__menu_toggle {
    position: fixed;
    top: 0;
    right: 10px;
  }
}
</style>
