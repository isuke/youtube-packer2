<template lang="pug">
.side(v-if="isOpen")
  h3.side__title list

  ul.side__list
    li.side__list__item(v-for="playlist in playlists")
      a.side__list__item__link(
        v-text="t(playlist.title)"
        v-on:click="setPlaylist(playlist)"
      )
</template>

<script lang="coffee">
bus = require('./bus.coffee')

module.exports = {
  data: ->
    titleLength: 40
    isOpen: false
    playlists: []
  methods:
    t: (str) ->
      if str.length > @titleLength
        str.slice(0, @titleLength-3) + '...'
      else
        str
    setPlaylist: (json) ->
      bus.$emit 'setPlaylistEvent', json
    _loadPlaylists: ->
      Store.forEach (_, val) => @playlists.push(val)
  created: ->
    bus.$on 'toggleMenuEvent', => @isOpen = !@isOpen

    @_loadPlaylists()
}
</script>

<style lang="scss" scoped>
.side {
  background-color: #333;
  color: #f3f3f3;
  padding: 10px;

  &__list {
    list-style: none;
    padding: 0;

    &__item {
      &__link {
        color: #f3f3f3;
        cursor: pointer;

        &:hover {
          color: #0074d9;
        }
      }
    }
  }
}
</style>
