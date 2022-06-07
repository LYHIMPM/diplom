const path = require("path");
var HtmlWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const BundleTracker = require('webpack-bundle-tracker');
const { VueLoaderPlugin } = require('vue-loader')


const webpack = require('webpack');

module.exports = {
    entry: {
        main: "./src/scripts/main.js",
        profile_accounting: "./src/scripts/profile_accounting.js",
        profile_chats: "./src/scripts/profile_chats.js",
        profile_info: "./src/scripts/profile_info.js",
        profile_orders: "./src/scripts/profile_orders.js",
        entry_details: "./src/scripts/entry_details.js",
        order: "./src/scripts/order.js",
        store: "./src/scripts/store.js",
        breadcrumbs: "./src/scripts/breadcrumbs.js",
        // about: "./src/scripts/about.js",
        custom: "./src/scripts/custom.js",
        // login: "./src/scripts/login.js",
        // register: "./src/scripts/register.js",
        // sales: "./src/scripts/sales.js",
    },

    optimization: {
        splitChunks: {
            chunks: 'all',
            name: 'vendors',
            cacheGroups: {
                vendor: {
                  test: /[\\/]node_modules[\\/]/,
                  name(module) {
                    // get the name. E.g. node_modules/packageName/not/this/part.js
                    // or node_modules/packageName
                    const packageName = module.context.match(
                      /[\\/]node_modules[\\/](.*?)([\\/]|$)/
                    )[1];
          
                    // npm package names are URL-safe, but some servers don't like @ symbols
                    return `npm.${packageName.replace("@", "")}`;
                  }
                },
            }
        },
    },

    module: {
        rules: [
            {
                test: /\.(s*)css$/,
                use: [
                    // MiniCssExtractPlugin.loader,
                    // "style-loader",
                    'vue-style-loader',
                    {
                        loader: 'css-loader',
                        options: {
                            url: false
                        }
                    },
                    "sass-loader"
                ]
            },
            {
                test: /\.vue$/,
                loader: 'vue-loader'
            },
            {
                test: /\.js$/,
                include: path.resolve(__dirname, '../src'),
                loader: 'babel-loader',
            },
        ]
    },

    plugins: [
        new MiniCssExtractPlugin({filename: "css/[name].[contenthash].css"}),
        new BundleTracker({filename: './webpack-stats.json'}),
        new VueLoaderPlugin(),
        new webpack.DefinePlugin({
            __VUE_OPTIONS_API__: false,
            __VUE_PROD_DEVTOOLS__: false,
          }),
    ]
}