<template>
    <div>
      <h1 class="header">通过您的ID登录</h1>
      <div id="hiddenContainer1" style="display:none;"></div> <!-- 隐藏的地图容器 -->
    <div>
    <el-form label-width="100px" style="max-width: 460px;position: relative;margin: auto;">
      <el-form-item label="账号ID" >
        <el-input type="tel" v-model="loginUsername" placeholder="请输入账号" required/>
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
  const loginUsername=ref('')
  const loginPassword=ref('')
  const router = useRouter();
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

  const login_id = async ()=> {
          axios.post('/api/pub/login',  JSON.stringify({ 
          user_ID_phonenumber:loginUsername.value,
          user_password:loginPassword.value,
          login_type:"0" 
        }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response => {
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
              
                if (response.data.user_type=='1'){
                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("sto_id", loginUsername.value);
                  sessionStorage.setItem("user_type", response.data.user_type);
                    router.push({
                      path:'/store'
                  });
                }
                else if (response.data.user_type=='0'){

                  sessionStorage.removeItem("sto_id");
                  sessionStorage.removeItem("cus_id");
                  sessionStorage.removeItem("user_type");
                  sessionStorage.setItem("cus_id", loginUsername.value);
                  sessionStorage.setItem("user_type", response.data.user_type);
                  console.log("loginUsername.value:"+loginUsername.value)
                  /*获取用户账号*/
                  user_id.value = response.data.user_ID;
                  
                  
                  /*获取用户位置*/
                  axios.get('/api/pub/getinformation/user', { params: {user_ID: response.data.user_ID } })
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

    /*width: 90px;
    /*justify-content: center;*/
}

#hiddenContainer1 {
    display: none;
}
</style>