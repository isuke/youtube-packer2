module.exports = {
  entry: './frontend/main.js',
  output: {
    path: 'public',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" },
      { test: /\.scss$/, loader:  "style!css!sass" },
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url?limit=10000&mimetype=application/font-woff" },
      { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file" }
    ]
  },
  resolve: {
    extenstions: ['', '.js', '.json', '.html'],
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  }
};
