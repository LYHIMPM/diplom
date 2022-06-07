const path = require("path");
const common = require("./webpack.common");
var HtmlWebpackPlugin = require("html-webpack-plugin");
const {merge} = require("webpack-merge");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

module.exports = merge(common, {
    mode: "development", // читаемый формат вывода
    output: {
        filename: "js/[name].js",
        chunkFilename: 'js/[id].bundle_[chunkhash].js',
        path: path.resolve("../website/static/webpack_bundles/"),
        clean: true,
    },
    optimization: {
        splitChunks: {
            chunks: 'all',
            name: 'vendors',
        },
    },
    plugins: [
        new CleanWebpackPlugin(),
        // new HtmlWebpackPlugin({template: "./src/index.html"}),
    ]
});