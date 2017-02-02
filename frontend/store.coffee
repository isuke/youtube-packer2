module.exports = new Vuex.Store(
  state:
    isSideOpen: false
    url: undefined
    title: undefined
    youtubeIds: []
    playlists: []
  mutations:
    toggleSide: (state) ->
      state.isSideOpen = !state.isSideOpen
    setPlayer: (state, payload) ->
      state.url        = payload.url
      state.title      = payload.title
      state.youtubeIds = payload.youtubeIds
    pushPlaylist: (state, payload) ->
      state.playlists.push payload
)
