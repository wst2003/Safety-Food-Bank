<template>
    <el-dialog v-model="dialogVisible" title="管理员登录" width="30%" draggable>
    <el-input
    v-model="text"
    class="w-50 m-2"
    type="textarea"
    placeholder="请输入管理员密码"
    style="width: 300px"
    show-word-limit
    autosize
  />
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible=false">取消</el-button>
        <el-button type="danger" @click="dialogVisible=true,router.push('/administrator')">
          登录
        </el-button>
      </span>
    </template>
  </el-dialog>
  <div class="title-bar">
    <h1>食保宝</h1>
    <h2>临期食品交易平台</h2>
  </div>
  <div class="total-layout">
    <div class="container">
      <div class="tab">
        <el-radio-group v-model="label_default" size="large">
          <el-radio-button @click="selectTab(0)" label="手机验证码登录"/>
          <el-radio-button @click="selectTab(1)" label="密码登录"/>
        </el-radio-group>
      </div>

      <div class="component">
        <component :is="selectedTab"></component>
      </div>

      <div class="actions">
        <el-button @click="toRegister">没有账号？立即注册</el-button>
        <el-button @click="toFindPassword">找回密码</el-button>
        <el-button type="primary" @click="dialogVisible=true">管理员登录</el-button>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>

import {ref,shallowRef} from 'vue';
import { useRouter } from 'vue-router';
import codelogin from '../components/CodeLoginPage.vue'
import phonelogin from '../components/PhoneLoginPage.vue'

const dialogVisible=ref(false);
const text=ref('');
  const router=useRouter()
  const label_default=ref('ID登录')
  const tabs=[
        { name: 'ID登录', component: codelogin },
        { name: '电话号码登录', component: phonelogin },
  ]
  const selectedTab=shallowRef(codelogin)
  
  const selectTab=(index:number)=> {
      console.log(index)
      selectedTab.value = tabs[index].component;
      console.log(selectedTab.value)
    }
  
  const toRegister=()=>{
      //router.push({name:'register'})
      /*-------------------- */
      /*跳转到注册界面修改此处 */
      router.push({name: 'userregister'}); // 跳转到注册界面
      /*-------------------- */
  }

  const toFindPassword=()=>{
      router.push({name:'findpassword'})
  }

</script>

<style scoped>
.title-bar {
  background-color: rgba(0, 0, 0, 0.5); /* 半透明黑色背景 */
  color: white; /* 文字颜色 */
  padding: 10px 0; /* 填充 */
  text-align: center; /* 文字居中 */
  position: fixed; /* 固定在顶部 */
  width: 100%; /* 全宽 */
  z-index: 9999; /* 置于其他元素之上 */
}

h1, h2 {
  margin: 0;
  padding: 0;
}

.total-layout {
  background-image: url('../assets/storage.jpg'); /* Replace with your image path  register.jpg */
  background-size: cover;
  background-position: center center;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding-top: 70px; /* 添加顶部填充以避免标题栏遮挡内容 */
}

.container {
  background-color: rgba(255, 255, 255, 0.9); /* Slight transparency to see some of the background */
  padding: 40px;
  border-radius: 10px; /* Rounded edges */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* subtle shadow for depth */
  max-width: 600px; /* or whatever maximum width you want */
}

.tab {
  margin-bottom: 40px;
}

.component {
  width: 100%;
  max-width: 500px;
  margin-bottom: 40px;
}

.actions {
  display: flex;
  gap: 10px; /* Adjust as needed */
  flex-wrap: wrap;
  justify-content: center;
}

.el-button {
  margin: 10px; /* Space between buttons */
}
</style>