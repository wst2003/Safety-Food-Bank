<template>
  <el-container>
    <el-header style="background-color: #aa1514;"> 
      <el-row justify="space-between">
        <el-col :span="4" style="display: flex; align-items: center;"> <!-- 使用flex布局来垂直居中 -->
          <img src="../assets/shibaobao_logo.png" alt="商标" style="height: 100%; max-height: 50px; margin-right: 10px;"> <!-- 添加商标图片 -->
          <h3 style="
            color:aliceblue;
            text-overflow:ellipsis;
            white-space:nowrap;
            overflow:hidden;">
            个人信息
          </h3>
        </el-col>
        <el-col :span="20" style="display: flex; justify-content: flex-end; align-items: center;">
          <el-link icon="el-icon-edit" @click="modifyUserInfo" style="color: aliceblue; font-size: large; margin-left: 15px;">修改信息</el-link>
          <el-link icon="el-icon-plus" @click="rechargeNow" style="color: aliceblue; font-size: large; margin-left: 15px;" v-if="flag==null && displayUserType === '顾客'">充值</el-link>
          <el-link icon="el-icon-minus" @click="withdrawNow" style="color: aliceblue; font-size: large; margin-left: 15px;" v-if="flag==null">提现</el-link>
          <el-link icon="el-icon-arrow-left" @click="goBack" style="color: aliceblue; font-size: large; margin-left: 15px;">返回主页</el-link>
        </el-col>
      </el-row>
    </el-header>
    <el-main style="background-color: #fef0f0; min-height: 100vh;">
      <el-form :model="userInfo" style="max-width: 1100px; position: relative; margin: auto;">
        <el-row :gutter="25" v-if="flag==null">
          <!-- 昵称和用户ID -->
          <div v-if="displayUserType === '顾客'" style="display: flex; align-items: center;">
            <img src="../assets/icons8-user-64.png" alt="顾客图标" style="margin-left: 20px;">
            <div style="font-size: 24px; margin-left: 15px;">
              {{ greeting }}，尊敬的顾客 {{ userInfo.cus_nickname }}
            </div>
          </div>
          <div v-else-if="displayUserType === '商户'"  style="display: flex; align-items: center;">
            <img src="../assets/icons8-user-64.png" alt="商家图标" style="margin-left: 20px;">
            <div style="font-size: 24px; margin-left: 15px;">
              {{ greeting }}，尊敬的 {{ userInfo.sto_name }} 店主
            </div>
          </div>
        </el-row>
        <br><br>
        <div style="border-bottom: 1px solid gray; padding: 10px;">
          <div style="display: flex; align-items: center;">
            <img src="../assets/icons8-account-64.png" alt="关于账户">
            <h3 style="margin-left: 10px;">关于账户</h3>
          </div>
          <div style="clear: both;"></div>
        </div>
        <br><br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-id-64.png')" alt="用户ID图标" style="height: 1.1em; margin-right: 1px;">
              用户ID：
            </span>
          </el-col>
          <el-col :span="9">
            <span class="value">{{ userInfo.user_ID }}</span>
          </el-col>
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-telephone-64.png')" alt="电话号码图标" style="height: 1.1em; margin-right: 1px;">
              电话号码：
            </span>
          </el-col>
          <el-col :span="9">
            <span class="value">{{ userInfo.user_phone }}</span>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-money-50.png')" alt="余额图标" style="height: 1.1em; margin-right: 1px;">
              账户余额：
            </span>
          </el-col>
          <el-col :span="3">
            <span class="value" v-if="showBalance">
              ¥ {{ userInfo.user_balance }}
            </span>
            <span class="value" v-else>
              ¥ ******
            </span>
          </el-col>
          <el-col :span="3">
            <el-button 
                style="float: left; background-color: #aa1514; color: white;" 
                @click="toggleBalance">
              显示余额
            </el-button>
          </el-col>
        </el-row>
        <br><br>
        <!-- 基本信息或商户信息 -->
        <div style="border-bottom: 1px solid gray; padding: 10px;">
          <div v-if="displayUserType === '顾客'" style="display: flex; align-items: center;">
            <img src="../assets/icons8-information-64.png" alt="基本信息">
            <h3 style="margin-left: 10px;">基本信息</h3>
          </div>
          <div v-if="displayUserType === '商户'" style="display: flex; align-items: center;">
            <img src="../assets/icons8-store-64.png" alt="商户信息">
            <h3 style="margin-left: 10px;">商户信息</h3>
          </div>
          <div v-if="displayUserType === '顾客'" style="float: right;"><i class="el-icon-user"></i></div>
          <div v-else-if="displayUserType === '商户'" style="float: right;"><i class="el-icon-s-shop"></i></div>
          <div style="clear: both;"></div>
        </div>
        <br><br>
        <!-- 根据 displayUserType 显示相应的字段 -->
        <div v-if="displayUserType === '顾客'">
          <!-- 显示顾客相关的表单项 -->
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-status-48.png')" alt="用户状态图标" style="height: 1.1em; margin-right: 1px;">
                用户状态：
              </span>
            </el-col>
            <el-col :span="9">
              <span class="value">{{ displayUserState }}</span>
            </el-col>
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-time-64.png')" alt="注册时间图标" style="height: 1.1em; margin-right: 1px;">
                注册时间：
              </span>
            </el-col>
            <el-col :span="9">
              <span class="value">{{ userInfo.user_regTime }}</span>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-address-50.png')" alt="注册地址图标" style="height: 1.1em; margin-right: 1px;">
                注册地址：
              </span>
            </el-col>
            <el-col :span="21">
              <span class="value">{{ userInfo.user_address }}</span>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-like-50.png')" alt="商品喜好图标" style="height: 1.1em; margin-right: 1px;">
                商品喜好：
              </span>
            </el-col>
            <el-col :span="15">
              <el-select v-model="userInfo.cus_loves" multiple disabled>
                <el-option
                  v-for="(item, index) in userInfo.cus_loves"
                  :key="index"
                  :label="item"
                  :value="item"
                ></el-option>
              </el-select>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-note-64.png')" alt="备注图标" style="height: 1.1em; margin-right: 1px;">
                备注信息：
              </span>
            </el-col>
            <el-col :span="21">
              <span class="value">{{ userInfo.cus_notes }}</span>
            </el-col>
          </el-row>
        </div>
        <div v-else-if="displayUserType === '商户'">
          <!-- 显示商户相关的表单项 -->
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-status-48.png')" alt="商户状态图标" style="height: 1.1em; margin-right: 1px;">
                商户状态：
              </span>
            </el-col>
            <el-col :span="9">
              <span class="value">{{ displayStoreState }}</span>
            </el-col>
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-time-64.png')" alt="商户注册时间图标" style="height: 1.1em; margin-right: 1px;">
                注册时间：
              </span>
            </el-col>
            <el-col :span="9">
              <span class="value">{{ userInfo.user_regTime }}</span>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-address-50.png')" alt="商户注册地址图标" style="height: 1.1em; margin-right: 1px;">
                注册地址：
              </span>
            </el-col>
            <el-col :span="21">
              <span class="value">{{ userInfo.user_address }}</span>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-goal-64.png')" alt="主营类型图标" style="height: 1.1em; margin-right: 1px;">
                主营类型：
              </span>
            </el-col>
            <el-col :span="15">
              <el-select v-model="userInfo.categories" multiple disabled>
                <el-option
                  v-for="(item, index) in userInfo.categories"
                  :key="index"
                  :label="item"
                  :value="item"
                ></el-option>
              </el-select>
            </el-col>
          </el-row>
          <br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-information-64.png')" alt="商户简介图标" style="height: 1.1em; margin-right: 1px;">
                商户简介：
              </span>
            </el-col>
            <el-col :span="21">
              <span class="value">{{ userInfo.sto_introduction }}</span>
            </el-col>
          </el-row>
          <br><br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-license-64.png')" alt="营业执照图标" style="height: 1.1em; margin-right: 1px;">
                营业执照：
              </span>
            </el-col>
            <el-col :span="21">
              <el-image style="width: 100px; height: 100px" :src="image" />
            </el-col>
          </el-row>
          <br><br>
          <el-row :gutter="25">
            <el-col :span="3">
              <span class="label">
                <img :src="require('../assets/icons8-image-64.png')" alt="商户图片图标" style="height: 1.1em; margin-right: 1px;">
                商户图片：
              </span>
            </el-col>
            <el-col :span="9">
              <div class="grid-container">
                <div v-for="(pic, index) in storePictures" :key="index" class="grid-item">
                  <el-image :src="pic" style="width: 100%; height: 100%; object-fit: cover;"></el-image>
                </div>
              </div>
            </el-col>
          </el-row>
          <br>
        </div> 
      </el-form>
      <!-- 充值弹窗 -->
      <el-dialog title = "充值" v-model = "showRecharge" width = "30%">
        <el-input v-model="recharge_amount" placeholder="请输入充值金额"></el-input>
        <template v-slot:footer>
          <el-button style="background-color: white; color: #aa1514;" @click="showRecharge = false">取消</el-button>
          <el-button style="background-color: #aa1514; color: white;" @click="confirmRecharge">确认支付</el-button>
        </template>
      </el-dialog>

      <!-- 提现弹窗 -->
      <el-dialog title = "提现" v-model = "showWithdraw" width = "30%">
        <el-input v-model="withdraw_amount" placeholder="请输入提现金额"></el-input>
        <template v-slot:footer>
          <el-button style="background-color: white; color: #aa1514;" @click="showWithdraw = false">取消</el-button>
          <el-button style="background-color: #aa1514; color: white;" @click="confirmWithdraw">确认提现</el-button>
        </template>
      </el-dialog>
    </el-main>
  </el-container>
</template>

  

<script lang="ts" setup>
/* eslint-disable */
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import { useRouter, useRoute } from 'vue-router';

const route = useRoute();
const userInfo = ref({});
const image=ref('')
const storePictures = ref([]);
const user_ID = ref('');
const flag=route.query.flag;
//const alipayBase = 'http://localhost:3000';
const alipayBase = 'http://localhost:3000';
// 充值提现相关
function generateOrderId() {
  // 获取当前时间的时间戳，精确到秒
  const timestamp = Math.floor(Date.now() / 1000); 
  // 生成一个1000到9999之间的随机数
  const randomDigits = Math.floor(Math.random() * 9000) + 1000;
  return `${timestamp}${randomDigits}`;
}

const showBalance  = ref(false);  // 在个人信息页面中显示余额
const toggleBalance = () => {
  showBalance.value = !showBalance.value;
}
const showRecharge = ref(false);
const showWithdraw = ref(false)
const recharge_amount = ref('');  // 用户充值的数量
const withdraw_amount = ref('')    //用户提现的数量
const rechargeNow = () => {
  showRecharge.value = true;
}
const withdrawNow = () => {
    showWithdraw.value = true
}
const confirmRecharge = () => {
    console.log('11111');
  // 使用 generateOrderId 函数生成一个唯一的orderId
  const orderId = generateOrderId();

  axios.post(alipayBase + '/api/payment', {
    orderId: orderId,
    price: recharge_amount.value,
    name: '充值',
    cus_id: user_ID.value,
  })
  .then((res) => {
    window.location.href = res.data.data.paymentUrl;
  });
  axios.post('/api/cus/balance/setBalance', {
    cus_id: user_ID.value,
    balance: parseFloat(userInfo.value.user_balance) + parseFloat(recharge_amount.value),
  })
  .then((res) => {    
  });
}
const confirmWithdraw = () => {
  if (parseFloat(withdraw_amount.value) > parseFloat(userInfo.value.user_balance)) {
      alert('余额不足');
      return;  // 提前终止函数的执行
  }

  const outBizNo = generateOrderId(); // 这需要是一个动态生成的唯一值
  const orderTitle = '提现';
  const payeeInfo = { 
    identity: '2088722008198443', // 支付宝用户ID
    identity_type: 'ALIPAY_USER_ID' // 支付宝的会员ID
  };

  axios.post(alipayBase + '/api/withdraw', {
      out_biz_no: outBizNo,
      trans_amount: parseFloat(withdraw_amount.value).toFixed(2),
      biz_scene: 'DIRECT_TRANSFER',
      product_code: 'TRANS_ACCOUNT_NO_PWD',
      order_title: orderTitle,
      payee_info: payeeInfo,
  })
  .then((res) => {
      if (res.data.success) {
        axios.post('/api/cus/balance/setBalance', {
          cus_id: user_ID.value,
          balance: parseFloat(userInfo.value.user_balance) - parseFloat(withdraw_amount.value),
        })
        .then((res) => {    
        });
        alert('提现成功');
        window.location.reload();  // 刷新页面
      } else {
        alert('提现失败: ' + res.data.errorMessage);
      }
  })
  .catch((error) => {
      console.error(error);
      alert('提现请求失败');
  });

  showWithdraw.value = false;
}
  
const greeting = ref('');
const setGreeting = () => {
  const now = new Date();
  const hour = now.getHours();

  if (hour < 12) {
    greeting.value = '早上好';
  } else if (hour >= 12 && hour < 14) {
    greeting.value = '中午好';
  } else if (hour >= 14 && hour < 18) {
    greeting.value = '下午好';
  } else {
    greeting.value = '晚上好';
  }
};
//加入百度地图组件


onMounted(async () => {
  setGreeting();
  console.log('123');
   //user_ID.value = route.query.id as string;
   if(sessionStorage.getItem('sto_id')!=null){
     user_ID.value = sessionStorage.getItem('sto_id') as string;
  }
  if(sessionStorage.getItem('cus_id')!=null){
     user_ID.value = sessionStorage.getItem('cus_id') as string;
  }

  if(flag!=null)
    user_ID.value=route.query.id as string;
  console.log("这是ID"+user_ID.value)
  console.log("这是ID"+user_ID.value);
  try {
    console.log(userInfo.value.cus_notes);
    const response = await axios.get('/api/pub/information/user', { params: {user_ID:user_ID.value } });
    if (response.status === 200) {
      userInfo.value = response.data;

      
    } else {
      console.error(`Error: HTTP status code ${response.status}`);
    }

    console.log('##'+userInfo.value.user_type)
    if (userInfo.value.user_type === '0') {
      const customerResponse = await axios.get('/api/pub/getinformation/customer', { params: { cus_ID: user_ID.value } });
      if (customerResponse.status === 200) {
          Object.assign(userInfo.value, customerResponse.data);
          console.log(userInfo.value.cus_notes);
      } else {
          console.error(`Error: HTTP status code ${customerResponse.status}`);
      }
    } else if (userInfo.value.user_type === '1') {
      const storeResponse = await axios.get('/api/pub/getinformation/store', { params: { sto_ID: user_ID.value } });
      image.value='https://food-bank.obs.cn-east-3.myhuaweicloud.com\\'+storeResponse.data.sto_licenseImg;
      if (storeResponse.status === 200) {
          Object.assign(userInfo.value, storeResponse.data);
          const storePicResponse = await axios.get('/api/pub/getinformation/storeimg', { params: { sto_ID: user_ID.value } });
          console.log("picAddress"+storePicResponse.data[0].imgURL)
          storePictures.value = storePicResponse.data.map(pic => 'https://food-bank.obs.cn-east-3.myhuaweicloud.com\\' + pic.imgURL);
      } else {
          console.log("获取图片错误")
          console.error(`Error: HTTP status code ${storeResponse.status}`);
      }
    }
  } catch (error) {
    console.log(userInfo.value.cus_notes);
    console.error(error);
  }
  console.log(userInfo.value.cus_notes);
});

  const displayUserType = computed(() => {
  return userInfo.value.user_type === '0' ? '顾客' : '商户';
  });

  const displayUserState = computed(() => {
  return userInfo.value.cus_state === '0' ? '封禁' : '正常';
  });

  const displayStoreState = computed(() => {
  return userInfo.value.sto_state === '0' ? '封禁' : '正常';
});

const router = useRouter();

const goBack = () => {
    const userType = sessionStorage.getItem("user_type");
    if(flag!=null){
      router.push('/administrator')
    }
    else if (userType === '1') {
      router.push({ path: '/store' });
    } else if (userType === '0') {
      router.push({ path: '/home' });
    } else {
      console.error("Invalid user type");
    }
  };
const modifyUserInfo = () => {
  
if(flag!=null){
  if (userInfo.value.user_type === '0') {
    router.push({ name: 'ModifyCustomerInfoPage' ,query:{id:user_ID.value,flag:1}});
  } else {
    router.push({ name: 'ModifyStoreInfoPage' ,query:{id:user_ID.value,flag:1}});
  }
}
else{
  if (userInfo.value.user_type === '0') {
    router.push({ name: 'ModifyCustomerInfoPage' });
  } else {
    router.push({ name: 'ModifyStoreInfoPage'});
  }
}
};



  
</script>


<style scoped>
  .form-layout{
    display: flex;
    flex-direction:column;
    width:300px;
    margin-left: 620px;
    justify-content: center;
  }
  .header{
      display: flex;
      justify-content: center;
      align-items: center;
      
  }
.form-item {
    display: flex;
    align-items: center;
  }
  .label {
    color: grey;
    margin-right: 10px;
  }
  .value {
    color: black;
    font-size: larger;
  }

  .grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1px;
  }

  .grid-item {
    width: 100px;
    height: 100px;
    margin: 2px;
  }
    /* 改变下拉列表的背景颜色 */
    .el-select-dropdown .el-scrollbar__wrap {
    background-color: #aa1514;
  }
  
  /* 改变下拉列表项的文本颜色 */
  .el-select-dropdown .el-select-dropdown__item {
    color: white; /* 或其他你喜欢的颜色 */
  }
  
  /* 改变已选择选项的背景颜色 */
  .el-tag--info {
    background-color: #aa1514;
  }

  /* 改变已选择选项的文本颜色 */
  .el-tag--info .el-tag__close {
    color: white; /* 或其他你喜欢的颜色 */
  }

  /* 改变已选择选项关闭按钮的颜色 */
  .el-tag--info .el-tag__close.el-icon-close {
    color: white; /* 或其他你喜欢的颜色 */
  }
</style>