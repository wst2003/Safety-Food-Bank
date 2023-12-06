<template>
  <div :style="`background: url(${require('../assets/register.jpg')}) no-repeat center center; background-size: cover; height: 80vh; padding: 5% 0;`">


<!-- 添加了一个半透明背景层，确保文字清晰可见 -->
<div style="background-color: rgba(255, 255, 255, 0.8); border-radius: 10px; padding: 20px;height: 85%;">
    <div>
    <h1 class="header">找回密码</h1>
    <el-form class="form-layout" label-position="" style="position: relative;margin: auto;" >
      <br>
      <br>
      <div>
        <el-form-item label="请输入手机号" prop="user_phone" :validate-status="phoneStatus" :error="phoneError">
        <el-input type="tel" v-model="phoneNumber" placeholder="请输入手机号" @blur="validatePhone"  required/>
        </el-form-item>
      </div>
      <div class="register">
      <el-button
      type="button.type"
      @click="sendVarifyCode"
      style="display: flex;margin-left: 45%;"
      >发送验证码</el-button>
      <br>
      <br>
    </div>
      <div>
        <el-form-item label="请输入验证码">
        <el-input type="text" show-password v-model="varifyCode" placeholder="请输入验证码" required/>
        </el-form-item>
      </div>
      <div class="register">
      <el-button
      type="button.type"
      @click="varify"
      style="display: flex;margin-left: 50%;"
      >验证</el-button>
      <br>
      <br>
    </div>
      <div>
        <el-form-item label="请输入新密码">
        <el-input type="password"  show-password v-model="loginPassword" placeholder="请输入密码" required :disabled="isdisabled"/>
      </el-form-item>
      </div>
      <div class="register">
      <el-button
      type="button.type"
      @click="sendNewPassword"
      :disabled="isdisabled"
      style="display: flex;margin-left: 50%;"
      >确定</el-button>
    </div>
    </el-form>

  </div>
  </div>
  </div>
</template>

<script lang="ts" setup>
import axios from 'axios';
import {ref} from 'vue';
//import { useRouter } from 'vue-router';
import { ElMessage,ElMessageBox } from 'element-plus';
import type {Action} from 'element-plus';
import { useRouter,useRoute } from 'vue-router';
const router=useRouter();

  //const router=useRouter()
  const phoneStatus=ref('')
  const phoneError=ref('')
  const phoneNumber=ref('')
  const loginPassword=ref('')
  const varifyCode=ref('')
  const APIKEY='CoWVVBFzlMuhQ2j'
  const APIID='mms2982896'
  const randNumber=ref(0)
  const content=ref('')
  const isdisabled=ref(true)
  const config={
        headers: {
              //'Content-Type': 'application/json', 
              // "Access-Control-Allow-Origin": "*",
          }
          }
  const phoneReg = /^1[3-9]\d{9}$/; 

const validatePhone = () => {
  if (!phoneReg.test(phoneNumber.value)) {
    phoneStatus.value = 'error';
    phoneError.value = '电话号码格式不正确';
  } else {
    phoneStatus.value = 'success';
    phoneError.value = '';
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
          +'&mobile='+phoneNumber.value+'&content='+content.value,config)
          .then(response => {
              console.log(response.data);
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
      };

const varify=()=>{
  const message=ref('')
  if(varifyCode.value===randNumber.value.toString()){
    isdisabled.value=false
    message.value="验证成功"
  }
  else{
    message.value="验证失败"
  }
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

const sendNewPassword=async ()=>{
  axios.post('api/pub/resetpassword/sendnewpassword',  JSON.stringify({ 
          user_phonenumber:phoneNumber.value,
          user_new_password:loginPassword.value }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response => {
              const message=ref('')
              console.log(response.data);
              if(response.data.message==='success'){
                message.value='修改密码成功'
                router.push('/login');
              }
              else {
                message.value=response.data.message
              }

            ElMessageBox.alert(message.value, '修改密码', {
              confirmButtonText: 'OK',
              callback: (action: Action) => {
              ElMessage({
                type: 'info',
                message: `action: ${action}`,
              })
              },
            })
          })
          .catch((error) => {
              console.log('An error occurred:', error);
          });
}
</script>

<style scoped>
.form-layout{
    display: flex;
    flex-direction:column;
    width:500px;
    margin-left: 620px;
    justify-content: center;
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
</style>