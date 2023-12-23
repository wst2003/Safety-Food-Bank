const { defineConfig } = require('@vue/cli-service')
const baseURL = "http://localhost:5000";
const imageURL = "https://food-bank.obs.cn-east-3.myhuaweicloud.com/"
module.exports = defineConfig({
    transpileDependencies: true,
    chainWebpack: config => {
        config
            .plugin('html')
            .tap(args => {
                args[0].title = '食保宝'
                return args
            })
    },
    devServer: {
        historyApiFallback: true,
        client: {
            overlay: false,  // 禁用错误覆盖
        },
        proxy: {
            '/api': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: baseURL,
                changeOrigin: true,
            },
            '/commodity_image': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            },
            '/commodity_img': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            },
            '/commodity_form_data': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: baseURL,
                changeOrigin: true
            },
            '/commodityImage': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            },
            '/store_image': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            },
            '/appeal': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            },
            '/appeal_image': {
                //target: baseURL,
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: imageURL,
                changeOrigin: true
            }
        }
    }
})