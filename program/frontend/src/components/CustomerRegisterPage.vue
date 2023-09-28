<template>
  <div :style="`background: url(${require('../assets/register.jpg')}) no-repeat center center; background-size: cover; height: 100vh; padding: 5% 0;`">

    <!-- 添加了一个半透明背景层，确保文字清晰可见 -->
    <div style="background-color: rgba(255, 255, 255, 0.8); border-radius: 10px; padding: 20px;">
      <h1 class="header" style="text-align: center; color: #333;">顾客注册</h1>
      
      <!-- 账号ID展示 -->
      <div style="text-align: center; font-size: large; margin-bottom: 20px;">
        您的账号ID: {{ cus_ID }}
      </div>
      
      <el-form :model="form"
               @submit.prevent="registerCus"
               label-width="100px"
               style="max-width: 460px; position: relative; margin: auto;"
               label-position="right">
        
        <el-form-item label="设置昵称" prop="cus_nickname">
          <el-input v-model="form.cus_nickname"></el-input>
        </el-form-item>
        <el-form-item label="个人备注" prop="cus_introduction">
          <el-input type="textarea" v-model="form.cus_notes" style="width: 100%;" rows="2"></el-input>
        </el-form-item>
        <el-form-item label="支付密码" prop="cus_payPassword">
          <el-input type="password" v-model="form.cus_payPassword"></el-input>
        </el-form-item>
        <el-form-item>
          <p>请选择喜好商品</p>
          <el-select v-model="cus_category"
                     multiple
                     placeholder="Select"
                     style="width: 100%; position: relative; margin: auto;">
            <el-option v-for="item in com_category"
                       :key="item"
                       :label="item"
                       :value="item"/>
          </el-select>
        </el-form-item>
        <el-form-item>
          <!-- 增加了按钮的样式，使其更为吸引眼球 -->
          <el-button type="primary" native-type="submit" style="width: 100%; border-radius: 25px; box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);">确认注册</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

  
  <script lang="ts" setup>
  import { onMounted, reactive, ref } from 'vue';
  import axios from 'axios';
  import { useRouter, useRoute } from 'vue-router';
  import { ElMessage } from 'element-plus';
  
  const router = useRouter();
  const route = useRoute();
  const form = reactive({
    cus_nickname: '',
    cus_notes: '',
    cus_payPassword: '',
  });
  const cus_ID=ref(sessionStorage.getItem('id') as string)
  const cus_category = ref([]);
  const com_category=ref([]);

  const get_comcategory=()=>{
      axios.get('/api/pub/category/getcategories'
      ,{
        headers: {
              //'Content-Type': 'application/json', 
              "Access-Control-Allow-Origin": "*",
          }
          }).then(response => {
            console.log(response.data.categorylist)
            com_category.value=response.data.categorylist
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
    }
    onMounted(()=>{
        get_comcategory()
    })

  const registerCus = async () => {
    console.log(sessionStorage.getItem('id') as string)
    try {
      
  
      const response = await axios.post('/api/pub/register/customer', 
      JSON.stringify({ 
          cus_ID:cus_ID.value,
          cus_nickname:form.cus_nickname,
          cus_notes:form.cus_notes,
          cus_payPassword:form.cus_payPassword,
          cus_category:cus_category.value
        }), 
      {
        headers: {
          'Content-Type': 'application/json',
        },
      });
  
      if (response.status === 200) {
        const data = response.data;
        if (data.message === 'success') {

          axios.post('/api/pub/recommendation',
          {
              user_id:cus_ID.value
          }).then(res=>{
              console.log('推荐算法启动成功',res)
          }).catch(()=>{
              console.log('推荐算法启动失败')
          })
          console.log(cus_category)
          ElMessage({
            message: '顾客注册成功，正在跳转...',
            type: 'success',
          });
          // 这里跳转到登录首页
          router.push('/login');
        } else if (data.message === '顾客未存在') {
          ElMessage({
            message: '顾客未存在',
            type: 'error',
          });
        }
      } else {
        console.error(`Error: HTTP status code ${response.status}`);
      }
    } catch (error) {
      console.error(error);
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
    /*align-items: center;*/
    
}
</style>