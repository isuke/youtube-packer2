module.exports = {
  entry: './frontend/main.js',
  output: {
    path: 'public',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },
  resolve: {
    extenstions: ['', '.js', '.json', '.html'],
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  }
};
