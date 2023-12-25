<template>
    <div>
      <h1 class="header">通过手机验证码登录</h1>
      <div id="hiddenContainer1" style="display:none;"></div> <!-- 隐藏的地图容器 -->
    <div>
    <el-form label-width="100px" style="max-width: 460px;position: relative;margin: auto;">
      <el-form-item label="手机号" >
        <el-row :gutter="10">
          <el-col>
            <el-input type="tel" v-model="phoneNumber" placeholder="请输入手机号" @blur="validatePhone" required/>
          </el-col>
          <el-col>
            <el-button type="default" round="true" @click="sendVarifyCode">发送验证码</el-button>
          </el-col>
        </el-row>
      </el-form-item>
      <el-form-item label="验证码">
        <el-input type="password" show-password v-model="varifyCode" placeholder="请输入验证码" required/>
      </el-form-item>
      <div class="submit-button" style="max-width: 120px;margin: auto;">
        <el-button type="default" round="true" :icon="Pointer" @click="login_code">提交</el-button>
      </div>
    </el-form>
    </div>
  </div>
</template>

<script lang="ts" setup>
import axios from 'axios';
import {ref} from 'vue';
//import { useRouter } from 'vue-router';
import { Pointer } from '@element-plus/icons-vue'
import { ElMessage,ElMessageBox } from 'element-plus';
import type {Action} from 'element-plus';
import { useRouter } from 'vue-router';
  const phoneNumber=ref('')
  const varifyCode=ref('')
  const randNumber=ref(0)
  const content=ref('')
  const router = useRouter();
  const phoneReg = /^1[3-9]\d{9}$/;
  const phoneStatus=ref('')
  const phoneError=ref('')
  //const router=useRouter()
  /*商家远近排序使用的变量*/
  const user_id = ref();
  const user_address = ref('');
  const ori_sto_list = ref([]); // 用于存储原始的商家地理位置数据，包含sto_id及sto_address
  const new_sto_list = ref([]);  // 用于存储排好序的商家地理位置数据，仅含sto_id
  const APIKEY='CoWVVBFzlMuhQ2j'//这两个参数需要修改
  const APIID='mms2982896'

  //引入百度地图
  /* eslint-disable */
  let map: BMapGL.Map;
  /* eslint-disable */
  let geoc: BMapGL.Geocoder;

  const validatePhone = () => {
  if (!phoneReg.test(phoneNumber.value)) {
    phoneStatus.value = 'error';
    phoneError.value = '电话号码格式不正确';
  } else {
    phoneStatus.value = 'success';
    phoneError.value = '';
  }
};

  const login_code = async ()=> {

    const message=ref('')
    if(varifyCode.value===randNumber.value.toString()){
      message.value="验证成功"
      ElMessageBox.alert(message.value, '验证', {
      confirmButtonText: 'OK',
      callback: (action: Action) => {
        ElMessage({
          type: 'info',
          message: `action: ${action}`,
        })
      },
    })
      axios.post('/api/pub/login',  JSON.stringify({ 
          user_ID_phonenumber:phoneNumber.value,
          user_password:varifyCode.value,
          login_type:"0" 
        }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response => {
            console.log(response.data.data);
            if(response.data.data.message==='该用户已经被封禁') {
                console.log('blocked.');
                sessionStorage.setItem("user_id",response.data.data.user_ID );
                router.push({
                      path:'/BlockUserPage',
                  });
              } 
            else if(response.data.data.message==='success'){
                /*------------------------*/
                /*登录成功后编辑此处跳转界面*/
                /*------------------------*/
              
                if (response.data.data.user_type=='1'){
                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("sto_id", phoneNumber.value);
                  sessionStorage.setItem("user_type", response.data.data.user_type);
                    router.push({
                      path:'/store'
                  });
                }
                else if (response.data.data.user_type=='0'){

                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("cus_id", phoneNumber.value);
                  sessionStorage.setItem("user_type", response.data.data.user_type);
                  console.log("loginUsername.value:"+phoneNumber.value)
                  /*获取用户账号*/
                  user_id.value = response.data.data.user_ID;
                  
                  
                  /*获取用户位置*/
                  axios.get('/api/pub/information/user', { params: {user_ID: response.data.data.user_ID } })
                  .then((res) => {
                      user_address.value = res.data.user_address;
                      console.log(user_address.value);
                  })
                  .catch(() => {
                      console.log('用户地址请求失败')
                  });

                  // 确保 fetchLocationData 完成后再进行页面跳转
                  fetchLocationData()
                    .then(() => {
                      router.push({
                        path: '/home',
                      });
                    })
                    .catch((error) => {
                      console.error('Fetch location data failed:', error);
                    });
                }
              }
              else {
                ElMessageBox.alert(response.data.data.message, '登录失败', {
                  confirmButtonText: 'OK',
                  callback: (action: Action) => {
                    ElMessage({
                      type: 'info',
                      message: `action: ${action}`,
                    })
                  },
                })
              }
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
    }
    else{
      message.value="验证失败"
    
    ElMessageBox.alert(message.value, '验证', {
      confirmButtonText: 'OK',
      callback: (action: Action) => {
        ElMessage({
          type: 'info',
          message: `action: ${action}`,
        })
      },
    })
  }
          
      };

      // 获取商家地理位置数据
      const fetchLocationData = () => {
        return new Promise(async (resolve, reject) => {
          try {
            const response = await axios.get('/api/cus/search/sendLocation');
            ori_sto_list.value = response.data.address_list;
            // 调用百度地图API进行排序
            await sortStoresByDistance(ori_sto_list.value);  // 确保此函数执行完成
            resolve();  // Promise 解析，表示可以进行下一步
          } catch (error) {
            console.error('获取地理位置数据出错:', error);
            reject(error);  // 出错时，Promise 被拒绝
          }
        });
      };     

    const sortStoresByDistance = (data) => {
      const storeDistances = [];
      console.log('111');
      map = new BMapGL.Map('hiddenContainer1');  // 使用隐藏的 DOM 元素初始化
      console.log('222');
      const myGeo = new BMapGL.Geocoder();
      myGeo.getPoint(user_address.value, function(userPoint) {
        if (userPoint) {
          data.forEach((store) => {
            myGeo.getPoint(store.sto_address, function(storePoint) {
              if (storePoint) {
                const distance = map.getDistance(userPoint, storePoint);
                storeDistances.push({ sto_id: store.sto_id, distance });
              } else {
                storeDistances.push({ sto_id: store.sto_id, distance: Infinity });
              }
              // 当所有商店都已处理
              if (storeDistances.length === data.length) {
                // 进行排序
                storeDistances.sort((a, b) => a.distance - b.distance);
                // 更新new_sto_list
                new_sto_list.value = storeDistances.map(item => item.sto_id);
                console.log(new_sto_list.value);

                // 调用API，将排序后的结果传给后端
                sendSortedDataToBackend(new_sto_list.value, parseInt(user_id.value, 10));
              }

            });
          });

        }
      });
    };

    // 将排序结果发送到后端
    const sendSortedDataToBackend = async (sortedStoIds, userId) => {
      try {
        const response = await axios.post('/api/cus/search/getLocationSort', {
          sto_id: sortedStoIds,
          user_id: userId
        });

        if (response.data && response.data.msg) {
          console.log('后端返回信息：', response.data.msg);
        }
      } catch (error) {
        console.error('发送排序结果到后端失败:', error);
      }
    };

    const sendVarifyCode=async ()=> {
    //发送验证码前首先验证下手机号是否被注册
    axios.post('/api/pub/resetpassword/verify',  JSON.stringify({ 
          user_phone:phoneNumber.value
        }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response => {
            if(response.data.message!='success'){
              ElMessageBox.alert(response.data.message, '验证码发送错误', {
              confirmButtonText: 'OK',
            })
            return 
            }
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
          
          randNumber.value=Math.floor(Math.random() * (9999 - 1000)) + 1000
          content.value='您的验证码是：'+randNumber.value.toString()+'。请不要把验证码泄露给其他人。'
          //这里是发送短信的接口，无需更改
          axios.get('http://106.ihuyi.com/webservice/sms.php?method=Submit&account='+APIID+'&password='+APIKEY
          +'&mobile='+phoneNumber.value+'&content='+content.value,{
        headers: {
              // 'Content-Type': 'application/json', 
              "Access-Control-Allow-Origin": "*",
          }
          })
          .then(response => {
              console.log(response.data);
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
      };
</script>

<style scoped>
.total-layout{
    display: flex;
    flex-direction:column;
    
}

.form-layout{
  display: flex;
  justify-content: center;

}
.header{
    display: flex;
    justify-content: center;
    align-items: center;
    
}
.submit-button{
    display: flex;
    margin-top: 30px;
    flex-direction:column;
    justify-content: center;

    /*width: 90px;
    /*justify-content: center;*/
}

#hiddenContainer1 {
    display: none;
}
</style>