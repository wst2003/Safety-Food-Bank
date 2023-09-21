<template>
  <div>
      <h1 class="header">中转界面</h1>
  </div>
  <el-text class="header" size="large">账号ID:{{ user_ID }}</el-text>
  <br>
  <el-row>
    <el-col :span="24">
      <el-button color="#24db67" :dark="true" @click="gotoUserInfoPage">查看个人信息</el-button>
      <el-button color="#7DD8E6" :dark="true">账户充值</el-button>
      <el-button color="#BFC7C8" :dark="true" @click="gotoChatPage">与他人聊天</el-button>
    </el-col>
  </el-row>
</template>

<script lang="ts" setup>
import { onMounted, reactive, ref } from 'vue';
import axios from 'axios';
import { useRouter, useRoute } from 'vue-router';
import { ElMessage } from 'element-plus';

const router = useRouter();
const route = useRoute();
const user_ID=ref(route.query.id)
const user_type=ref("")


onMounted(async () => {
  user_ID.value=route.query.id
  try {
    const response = await axios.get('/api/getinformation/user?user_ID='+user_ID.value);
    if (response.status === 200) {
      user_type.value = response.data.user_type;
      console.log(response.data)
    } else {
      console.error(`Error: HTTP status code ${response.status}`);
    }
  } catch (error) {
    console.error(error);
  }
    
});

const gotoUserInfoPage=()=>{
  router.push({ name: 'UserInfoPage', query: { id: user_ID.value } })
}

const gotoChatPage=()=>{
  console.log(user_type.value)
  if(user_type.value==="0"){
    router.push({name:"ChatPage",query:{cus_id:user_ID.value,sto_id:"1000001",user_type:"0"}})
  }
  else
    router.push({name:"ChatPage",query:{cus_id:"1000000",sto_id:user_ID.value,user_type:"1"}})
}   
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
</style>
