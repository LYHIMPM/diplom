const path = require("path");
const common = require("./webpack.common");
var HtmlWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const {merge} = require("webpack-merge");
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const TerserPlugin = require("terser-webpack-plugin");
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");


module.exports = merge(common, {
    mode: "production",
    output: {
        filename: "js/[name]-[contenthash].js",
        path: path.resolve("../website/static/webpack_bundles/"),
        clean: true,
    },
    optimization: {
        minimize: true,
        minimizer: [
          new TerserPlugin(),
          new CssMinimizerPlugin(),
        ],
        splitChunks: {
            chunks: 'all',
            name: 'vendors',
        },
    },
    plugins: [
        new CleanWebpackPlugin(),
        new MiniCssExtractPlugin({filename: "css/[name].[contenthash].css"}),
        // new HtmlWebpackPlugin({
        //     template: "./src/index.html",
        //     minify: {
        //         removeComments: true,
        //         collapseWhitespace: true,
        //         removeAttributeQuotes: true
        //     }
        // }),
    ]
});