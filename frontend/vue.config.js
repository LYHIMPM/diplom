const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,

  // publicPath: process.env.NODE_ENV === 'production' ? '/static/website/dist/' : '/static/website/dist',
  publicPath: '/static/website/dist',
  outputDir: '../website/static/website/dist/',
  // indexPath: '../../templates/website/vue/base.html', // relative to outputDir!

  pages: {
    iwantcustom: {
      entry: "./src/pages/iwantcustom/main.js",
      template: "public/index.html",
      filename: "../../../templates/website/vue/iwantcustom.html",
      chunks: ["chunk-vendors", "iwantcustom"],
    },
    order: {
      entry: "./src/pages/order/main.js",
      template: "public/index.html",
      filename: "../../../templates/website/vue/order.html",
      chunks: ["chunk-vendors", "order"],
    },
    profile: {
      entry: "./src/pages/profile/main.js",
      template: "public/index.html",
      filename: "../../../templates/website/vue/profile.html",
      chunks: ["chunk-vendors", "profile"],
    },
    store: {
      entry: "./src/pages/store/main.js",
      template: "public/index.html",
      filename: "../../../templates/website/vue/store.html",
      chunks: ["chunk-vendors", "store"],
    },
    entry_details: {
      entry: "./src/pages/entry_details/main.js",
      template: "public/index.html",
      filename: "../../../templates/website/vue/entry_details.html",
      chunks: ["chunk-vendors", "entry_details"],
    },
  },

  devServer: {
    devMiddleware: {
      writeToDisk: true,
    },
  }
})
