const { defineConfig } = require('@vue/cli-service')
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
                target: "http://localhost:5000",
                changeOrigin: true,
            },
            '/commodity_image': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            },
            '/commodity_form_data': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            },
            '/commodityImage': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            },
            '/store_image': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            },
            '/appeal': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            },
            '/appeal_image': {
                //target: "http://localhost:5000",
                //target: "http://127.0.0.1:4523/m1/3026709-0-default",
                target: "http://localhost:5000",
                changeOrigin: true
            }
        }
    }
})