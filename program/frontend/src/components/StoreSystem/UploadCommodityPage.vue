<template>
  <el-card>
  <div>
    <v-form-render :form-json="formJson" :form-data="formData" :option-data="optionData" ref="vFormRef">
    </v-form-render>
    <el-row>
      <el-col :span="11"/>
    <el-button type="danger" size="large" plain  @click="submitForm">提交信息</el-button>
  </el-row>
    <!-- <el-button type="primary" @click="returnDetailPage">返回商品列表</el-button> -->
  </div>
</el-card>
</template>

<script lang = "ts" setup>
  import { ref, reactive, toRaw } from 'vue'
  import { ElMessage } from 'element-plus'
  import axios from 'axios';
  import vformjson from '../../vform.json'
  import { useRouter,useRoute } from 'vue-router';
  const formJson = reactive(vformjson )

  
  const formData = reactive({})
  const optionData = reactive({})
  const vFormRef = ref(null)
  const router=useRouter();
  const route=useRoute();
  const sto_ID = sessionStorage.getItem('sto_id') as string;

  const submitForm = () => {
    vFormRef.value.getFormData().then(async formData => {
      console.log(formData);
      formData.STO_ID = sto_ID;
      console.log("为了传商品基本信息获取IMAGE_KEY"+localStorage.getItem('IMAGE_KEY'));
      
      delete formData.com_image_upload;
      formData.IMAGE_KEY = localStorage.getItem('IMAGE_KEY');
      console.log("往后端传商品Json"+JSON.stringify(formData));
      const response = await axios.post("/api/sto/uploadcommodity/basic",JSON.stringify(formData),
      { headers: {'Content-Type': 'application/json'} } );
      console.log("商品上传成功后获得ID"+response.data);
      
      ElMessage({
        showClose: true,
        message: '上传成功！您的商品ID：'+response.data,
        type: 'success',
      })
      location.reload();
    }).catch(error => {
      // Form Validation failed
      ElMessage.error(error)

    })
  }

  const returnDetailPage = () =>{
    console.log(sto_ID);
  router.push({
      path: '/detail',
      query:{
          sto_id:sto_ID
      }
  });
}

</script>