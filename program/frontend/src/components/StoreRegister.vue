<template>
    <div :style="`background: url(${require('../assets/register.jpg')}) no-repeat center center; background-size: cover; height: 100vh; padding: 5% 0;`">
        <!-- 添加了一个半透明背景层，确保文字清晰可见 -->
        <div style="background-color: rgba(255, 255, 255, 0.8); border-radius: 10px; padding: 20px;">
          <div>
              <h1 class="header">商家注册</h1>
          </div>
          <el-text class="header" size="large">账号ID:{{ sto_ID }}</el-text>
          <br>
          <el-form :model="form" 
                  @submit.prevent="registerStore"
                  label-width="100px" 
                  style="max-width: 460px;position: relative;margin: auto;"
                  label-position="right">
            <el-form-item label="商家名称" prop="sto_name">
              <el-input v-model="form.sto_name"></el-input>
            </el-form-item>
            <el-form-item label="商家介绍" prop="sto_introduction">
              <el-input v-model="form.sto_introduction"></el-input>
            </el-form-item>
            <el-form-item label="营业执照">
              <el-upload
                v-model:file-list='fileList'
                class="upload-demo"
                action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15"
                :auto-upload="false">
                <template #trigger>
                  <el-button type="primary">select file</el-button>
                </template>
              </el-upload>
            </el-form-item>
            <el-form-item label="商家图片">
              <el-upload
                v-model:file-list='fileList1'
                class="upload-demo"
                action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15"
                :auto-upload="false"
                :multiple="true"
                :limit="9"
                :before-upload="beforeImageUpload"
                :on-exceed="handleExceed">
                <template #trigger>
                  <el-button type="primary">select file</el-button>
                </template>
              </el-upload>
            </el-form-item>
            <el-form-item>
            <p>请选择主营商品</p>
            <el-select
              v-model="cus_category"
              multiple
              placeholder="Select"
              style="width: 240px;position: relative;margin: auto;"
            >
              <el-option
                v-for="item in com_category"
                :key="item"
                :label="item"
                :value="item"
              />
            </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" native-type="submit">确认注册</el-button>
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
  sto_ID: route.params.id, // assuming the user id is passed as a route param
  sto_name: '',
  sto_introduction: '',
  sto_licenseImage: null,  //商家执照
  sto_picture: null, // 商家图片
});
const cus_category = ref([]);
const com_category=ref([])
const sto_ID=ref(sessionStorage.getItem('id') as string)
const fileList = ref([]);  // 用于保存商家执照的文件列表
const fileList1 = ref([]); // 用于保存商家图片的文件列表


  const get_comcategory=()=>{
      axios.get('/api/category/getcategories'
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

    const beforeImageUpload = (file: File) => {
    if (fileList1.value.length >= 9) {
      ElMessage.error('You can only upload up to 9 images.');
      return false;
    }
    return true;
};

const handleExceed = () => {
    ElMessage.warning('You can only upload up to 9 images.');
};

const registerStore = async () => {
  console.log(sessionStorage.getItem('id') as string)
  try {
    const formData = new FormData();
    // 处理营业执照图片
    fileList.value.forEach((file) => {
        formData.append('sto_licenseImage', file.raw); // 将文件添加到FormData中
    });
    // 处理商家图片
    fileList1.value.forEach((file) => {
        formData.append('sto_picture', file.raw);  // 将商家图片添加到FormData中
    });
    formData.append('sto_ID',sto_ID.value as any)
    formData.append('sto_name', form.sto_name);
    formData.append('sto_introduction', form.sto_introduction);
    cus_category.value.forEach((category)=>{
      formData.append('com_categories[]',category)
    })

    const response = await axios.post('/api/register/store', formData, {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    });

    if (response.status === 200) {
      const data = response.data;
      if (data.message === 'success') {
        ElMessage({
          message: '商家注册成功，正在跳转...',
          type: 'success',
        });
        // 这里跳转到登录首页
        router.push('/login');
      } else if (data.message === '商家未存在') {
        ElMessage({
          message: '商家未存在',
          type: 'error',
        });
      }
    } else {
      console.error(`Error: HTTP status code ${response.status}`);
    }
  } catch (error) {
    console.error(error);
  }
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
