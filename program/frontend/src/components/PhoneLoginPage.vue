<template>
    <div>
    <h1 class="header">通过您的电话号码登录</h1>
    <div id="hiddenContainer" style="display:none;"></div> <!-- 隐藏的地图容器 -->
    <div>
    <el-form label-width="100px" style="max-width: 460px;position: relative;margin: auto;">
      <el-form-item label="电话号码" :validate-status="phoneStatus" :error="phoneError">
        <el-input type="tel" v-model="loginPhoneNumber" placeholder="请输手机号" @blur="validatePhone" required/>
      </el-form-item>
      <el-form-item label="密码">
        <el-input type="password" show-password v-model="loginPassword" placeholder="请输入密码" required/>
      </el-form-item>
      <div class="submit-button" style="max-width: 120px;margin: auto;">
        <el-button type="default" round="true" :icon="Pointer" @click="login_id">提交</el-button>
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
import {idState } from '../../router/userID.js'

  const phoneStatus=ref('')
  const phoneError=ref('')
  const loginPhoneNumber=ref('')
  const loginPassword=ref('')
  const router = useRouter();
  const phoneReg = /^1[3-9]\d{9}$/;
  //const router=useRouter()
  /*商家远近排序使用的变量*/
  const user_id = ref();
  const user_address = ref('');
  const ori_sto_list = ref([]); // 用于存储原始的商家地理位置数据，包含sto_id及sto_address
  const new_sto_list = ref([]);  // 用于存储排好序的商家地理位置数据，仅含sto_id

  //引入百度地图
  /* eslint-disable */
  let map: BMapGL.Map;
  /* eslint-disable */
  let geoc: BMapGL.Geocoder;


const validatePhone = () => {
  if (!phoneReg.test(loginPhoneNumber.value)) {
    phoneStatus.value = 'error';
    phoneError.value = '电话号码格式不正确';
  } else {
    phoneStatus.value = 'success';
    phoneError.value = '';
  }
};

const login_id=async ()=> {
          axios.post('/api/login',  JSON.stringify({ 
            user_ID_phonenumber:loginPhoneNumber.value,
            user_password:loginPassword.value,
            login_type:"1" 
          }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response => {
              console.log('Login submitted successfully.');
              console.log(response.data);
              
              if(response.data.message==='该用户已经被封禁') {
                console.log('blocked.');
                sessionStorage.setItem("user_id",response.data.user_ID );
                router.push({
                      path:'/BlockUserPage',
                  });
              } 
              else if(response.data.message==='success'){
                /*------------------------*/
                /*登录成功后编辑此处跳转界面*/
                /*------------------------*/
                localStorage.setItem("user_id",response.data.user_ID );
                if (response.data.user_type=='1'){
                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("sto_id", response.data.user_ID);
                  sessionStorage.setItem("user_type", response.data.user_type);
                    router.push({
                      path:'/store',
                  });
                }
                else if (response.data.user_type=='0'){
                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("cus_id", response.data.user_ID);
                  sessionStorage.setItem("user_type", response.data.user_type);
                  console.log("loginUsername.value:"+response.data.user_ID);
                  /*获取用户账号*/
                  user_id.value = response.data.user_ID;
                  
                  /*获取用户位置*/
                  axios.get('/api/getinformation/user', { params: {user_ID: response.data.user_ID } })
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
                //router.push({name:'MiddleTest',query:{id:response.data.user_ID}})
              }
              else {
                ElMessageBox.alert(response.data.message, '登录失败', {
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
      };

      // 获取商家地理位置数据
      const fetchLocationData = () => {
        return new Promise(async (resolve, reject) => {
          try {
            const response = await axios.get('/api/search/sendLocation');
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
      map = new BMapGL.Map('hiddenContainer');  // 使用隐藏的 DOM 元素初始化
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
        const response = await axios.post('/api/search/getLocationSort', {
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
</script>

<style scoped>

.form-layout{
    display: relative;
    margin-top: 30px;
}
.header{
    display: flex;
    flex-direction:column;
    justify-content: center;
}
.submit-button{
    display: flex;
    margin-top: 30px;
    flex-direction:column;
    justify-content: center;
}

#hiddenContainer {
    display: none;
}
</style>