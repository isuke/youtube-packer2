<script lang="coffee">
Front = require('./front.vue')

new Vue(
  el: '#app'
  components: { Front }
)
</script>

<style lang="scss">
.app {
  display: flex;
  justify-content: center;

  .front { flex-basis: 640px; }
}
</style>
