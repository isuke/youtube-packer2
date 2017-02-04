var AssetsPlugin = require('assets-webpack-plugin')

module.exports = {
  entry: './frontend/app.js',
  output: {
    path: 'public',
    filename: 'bundle-[hash].js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: "style!css" },
      { test: /\.scss$/, loader:  "style!css!postcss!sass" },
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "url?limit=10000&mimetype=application/font-woff" },
      { test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: "file" },
      { test: /\.vue$/, loader: "vue" }
    ]
  },
  vue: {
    loaders: {
      scss: 'vue-style!css!sass'
    }
  },
  resolve: {
    extenstions: ['', '.js', '.json', '.html'],
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  },
  postcss: function() {
    return [require('autoprefixer')];
  },
  plugins: [new AssetsPlugin()]
};
