<script lang="coffee">
new Vue(
  el: '#app'
  store: require('./store.coffee')
  components:
    front: require('./Front.vue')
    side:  require('./Side.vue')
)
</script>

<style lang="scss">
.app {
  display: flex;
  align-items: stretch;

  .front { flex: 1; }
  .side  { width: 250px; }
}
</style>
