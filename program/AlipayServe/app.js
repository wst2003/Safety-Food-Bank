const express = require('express');
const cors = require('cors'); // 引入CORS模块
const alipaySdk = require('./alipay.js'); // 引入你之前定义的支付宝配置文件
const AlipayFormData = require('alipay-sdk/lib/form').default; // 引入AlipayFormData
const app = express();


app.use(cors()); // 使用CORS中间件
// 解析JSON请求体
app.use(express.json());

// 支付接口
app.post('/api/payment', function (req, res, next) {
    // 接收前端给后端的订单号
    let orderId = req.body.orderId;
    // 前端给后端总价
    let price = req.body.price;
    // 前端给后端商品名称
    let name = req.body.name; // 不需要调用 join
    let user_id = req.body.cus_id;
    const formData = new AlipayFormData();
    // 调用get方法
    formData.setMethod('get'),
        // 支付时 的信息
        formData.addField('bizContent', {
            outTradeNo: orderId, // 订单号
            productCode: 'FAST_INSTANT_TRADE_PAY', // 写死的
            totalAmount: price, // 金额
            subject: name // 商品名称
        });
    // 支付成功或者失败打开的页面
    // 获取环境变量中的HOST，如果没有则默认localhost
    const host = process.env.HOST || 'localhost';
    // 获取环境变量中的 PORT，如果没有则默认为8080
    const port = process.env.PORT || '8080'
    let returnURL = `http://${host}:${port}/UserInfoPage?id=${user_id}`;
    formData.addField('returnUrl', returnURL);
    //formData.addField('returnUrl', 'http://localhost:8080/PayTest');
    const result = alipaySdk.exec(
        'alipay.trade.page.pay',
        {},
        { formData: formData },
    );
    result.then(resp => {
        res.send({
            data: {
                code: 200,
                success: true,
                paymentUrl: resp
            }
        })
    })
});

// 退款接口
app.post('/api/refund', function (req, res, next) {
    // 从请求中获取订单号和退款金额
    let orderId = req.body.orderId;
    let refundAmount = req.body.refundAmount;

    // 调用支付宝SDK的退款功能
    alipaySdk.exec(
        'alipay.trade.refund',
        {
            bizContent: {
                outTradeNo: orderId,
                refundAmount: refundAmount
            }
        }
    ).then((response) => {
        // 根据支付宝的响应处理退款结果
        console.log('Response:', response); // 添加此行以打印响应
        if (response.code === '10000') {
            res.send({
                data: {
                    code: 200,
                    success: true,
                    message: '退款成功'
                }
            });
        } else {
            res.send({
                data: {
                    code: 400,
                    success: false,
                    message: '退款失败'
                }
            });
        }
    }).catch((error) => {
        // 处理退款请求错误
        console.error(error);
        res.status(500).send({
            error: '退款请求失败'
        });
    });
});

app.post('/api/withdraw', function (req, res, next) {

    const {
        out_biz_no,
        trans_amount,
        biz_scene,
        product_code,
        order_title,
        payee_info,
    } = req.body;

    console.log('Received withdraw request!');

    // Construct the biz_content
    const bizContent = {
        out_biz_no: out_biz_no,
        trans_amount: trans_amount,
        biz_scene: biz_scene,
        product_code: product_code,
        order_title: order_title,
        payee_info: {
            identity: payee_info.identity,
            identity_type: 'ALIPAY_USER_ID'
        }
    };

    console.log('Biz content created!');

    // 执行转账
    alipaySdk.exec('alipay.fund.trans.uni.transfer', {
        biz_content: bizContent // This wraps all the transfer details into a single JSON string
    }).then((response) => {
        console.log(response);

        if (response.code === '10000') {
            res.send({ success: true });
        } else {
            res.send({ success: false, errorMessage: response.msg });
        }
    }).catch((error) => {
        console.error(error);
        res.status(500).send({ success: false, errorMessage: '提现请求失败' });
    });
});








// 启动服务器
const port = 3000;
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
