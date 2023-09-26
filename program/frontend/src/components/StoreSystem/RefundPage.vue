<template>
  <el-row>
<el-page-header :icon="ArrowLeft" title="返回" @back="goBack" >
  <template #content>
    <span class="text-large font-600 mr-3"> 退款订单查看 </span>
  </template>
</el-page-header>

</el-row>
  <el-row>
  <el-col :span="24">
    <el-card>
    <el-row :gutter="20">
      <el-col :span="8">
    <el-input placeholder="请输入内容" clearable v-model="phone" />
      </el-col>
      <el-button type="danger" icon="search" @click="getIndents"/>
      <el-col :span="10"></el-col>
      
      <!-- <el-col :span="2">
        <el-button type="info" @click="complain">投诉</el-button>

          </el-col> -->
      
    </el-row>

    <el-row>
  <el-table
    v-loading="loading"
   :data="indentsList"
    style="width: 100%" max-height="1000" 
    border 
    stripe
    @sort-change="changeSort"
    :default-sort="{ prop: 'IND_CREATIONTIME', order: 'ascending' }"
    >
    <el-table-column label="商品图片" width="200">
      <template #default="scope">
        <div style="display: flex; align-items: center">
          <el-image
            style="width: 180px; height: 90px"
            :src="getUrl(scope.$index)"
            :zoom-rate="1.2"
            :initial-index="0"
            fit="fill"
          />
        </div>
      </template>
    </el-table-column>
    <el-table-column prop="COM_NAME" label="商品名字"> </el-table-column>
    <el-table-column prop="COM_ID"  label="商品ID">
      <template #default="scope">
        <el-tag @click="router.push('/view?com_id='+indentsList[scope.$index].COM_ID)">{{ indentsList[scope.$index].COM_ID }}</el-tag>
      </template>
    </el-table-column>
    <el-table-column prop="IND_MONEY" label="商品价格/退款金额"></el-table-column>
    <el-table-column sortable="custom"
    prop="IND_CREATIONTIME"
    label="订单创建时间/退货时间"
    width="500"
    ></el-table-column>
    <el-table-column prop="IND_RNOTES" label="退货原因"></el-table-column>
    <el-table-column label="操作">
        <template v-slot="{row}">
          <el-button type="warning" @click="complain(row.CUS_ID)">投诉</el-button>
        </template>
      </el-table-column>
  </el-table>
  </el-row>
  <!-- 分页区域 -->
  <el-row>
  <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
          :current-page="pagenum" :page-sizes="[1, 3, 5, 10, 15, 20]" :page-size="pagesize"
          layout="sizes, prev, pager, next, jumper" :total="800">
  </el-pagination>
</el-row>

</el-card>
</el-col>
</el-row>





<el-dialog
title="提交投诉"
v-model="isComplaintDialogVisible"
:before-close="handleClose">
<div>
  <el-select v-model="appMatters" placeholder="（必填）请选择投诉事项">
    <el-option label="多次退款刷单" value="5"></el-option>

    <!-- 更多选项 -->
  </el-select>
  <br>
  <br>
  
  <el-input
    type="textarea"
    v-model="complaintText"
    placeholder="（必填）请详细描述你的投诉"></el-input>

    <br>
  <!-- <input type="file" multiple @change="complaintImages = $event.target.files" /> -->
  <!-- 在这里添加上传组件 -->
<!-- 图片上传组件 -->
<el-upload
    :file-list="fileList"
    :limit="3"
    :on-exceed="handleExceed"
    :before-upload="beforeUpload"
  >
    <el-button type="danger">点击上传申诉截图</el-button>
  </el-upload>
   <!-- 图片预览 -->
   <div v-for="image in sctImages" :key="image">
    <el-image :src="image" style="width: 100px; height: 100px;"></el-image>
  </div>
</div>
<template #footer>
  <el-button @click="isComplaintDialogVisible = false">取消</el-button>
  <el-button @click="submitForm" type="danger">提交</el-button>
  </template>
</el-dialog>
  </template>
  
  <script lang="ts" setup>
  import { Options, Vue } from 'vue-class-component';
  import axios from 'axios';
  import {onMounted, ref,watch} from 'vue'
  import { useRouter,useRoute } from 'vue-router';
  import { ArrowLeft } from '@element-plus/icons-vue'
  import { ElMessage, ElMessageBox,ElNotification } from 'element-plus'
  const router=useRouter();
  const pagenum=ref(1);
  const pagesize=ref(5);
  const query=ref('');
  const haveQuery=ref('');
  const tableLayout = ref('在售')
  const uploadDate=ref('');
  const expirationDate=ref('')
  const loading=ref(false);
  const ableEdit = ref([true]);
  const isEmpty = ref([true]) //是否售空
  const isOverDate = ref([true]) //是否过期
  const sto_id=sessionStorage.getItem('sto_id') as string;
  const route=useRoute();
  const indentsList=ref([
      {
          "IND_ID": 19,
          "IND_QUANTITY": 2,
          "COM_ID": 270,
          "COM_NAME": "test10",
          "COM_IMAGE": ".\\wwwroot\\commodity_image\\270\\com_image_0.jpg",
          "IND_MONEY": "28",
          "IND_RMONEY": "16",
          "IND_CREATIONTIME": "2023-08-11 08:45:21",
          "IND_RTIME": "2023-08-13 16:04:54",
          "IND_RNOTES": "不需要了",
          //新增
          "CUS_ID":0,
      }
  ]);


const status=ref(1);  //1 在售 0 售罄/下架 -1 过期
const order=ref(1);
const category=ref([]);
const phone=ref('');
const getindentsList=async()=>{
  loading.value=Boolean(true);
  indentsList.value.length=0;
  var Phone=phone.value;
  if(Phone.length==0)
    Phone='null';
  axios.get('api/sto/storeindentlist/refundlist?STO_ID='+sto_id+'&TIME_ORDER='+order.value+'&USER_PHONE='+Phone+'&BEGIN_NUMBER='+(pagesize.value*(pagenum.value-1)+1)+'&END_NUMBER='+(pagesize.value*pagenum.value)) 
    .then(response=>{
      console.log(pagesize.value*(pagenum.value-1)+1);
      console.log(pagesize.value*pagenum.value);
      indentsList.value=JSON.parse(JSON.stringify(response.data));
      for(var i=0;i<indentsList.value.length;++i){
        indentsList.value[i].IND_MONEY+=' / '+indentsList.value[i].IND_RMONEY;
        indentsList.value[i].IND_CREATIONTIME+=' / '+indentsList.value[i].IND_RTIME;
      }
      loading.value=Boolean(false);
    })
}

const getIndents=async()=>{
  getindentsList().then(()=>
  ElNotification.success({
    title: 'Success',
    message: '搜索成功',
    duration: durationTime
  }))
  haveQuery.value=query.value;
}

const changeSort=(value)=>{
  console.log(value.order);
  if(value.order=='ascending')
    order.value=1;
  else
    order.value=0;
  
  var str='';
  for(var i=0;i<query.value.length;++i)
    str+=query.value[i];
  console.log(str);
  query.value=haveQuery.value;
  getindentsList();
  query.value=str;
}

function change(strr :string[]){
  var arr=[''];
    for(var i=0;i<strr.length;i++)
      arr.push(strr[i]);
    for(i=1;i<arr.length;i++){
      var str=arr[i].split('\\');
      arr[i]='/';
      for(var j=2;j<str.length;j++){
        arr[i]+=str[j];
        if(j!=str.length-1)
          arr[i]+='/'
      }
      // console.log(arr[i]);
    }

    // srcList.value=arr;
    // console.log(arr.length)
    return arr[1];
}


const srcList =ref( [
  "/commodity_image\\1\\com_image_0.jpg",
  ]);
const url = 'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg';
const getUrl=(index:number)=>{
  return change([indentsList.value[index].COM_IMAGE]);
}

const goBack=()=>{
  history.back();
}
onMounted(()=>{
    //sto_id.value = route.query.sto_id as string;
    console.log(sto_id);
    getindentsList();
  });
var durationTime=2000;



  const handleSizeChange=(val:number)=>{
    pagesize.value=val;
    getindentsList();
  }

  const handleCurrentChange=(val:number)=>{
    pagenum.value=val;
    
    getindentsList();
  }

  const getSrcList=(index:number)=>{
    var arr: string[];
    // arr=indentsList.value[index].com_image;
    arr=[];
    for(var i=0;i<indentsList.value[index].com_image.length;i++)
      arr.push(indentsList.value[index].com_image[i]);
    for(i=0;i<arr.length;i++){
      var str=arr[i].split('\\');
      arr[i]='/';
      for(var j=2;j<str.length;j++){
        arr[i]+=str[j];
        if(j!=str.length-1)
          arr[i]+='/'
      }
      console.log(arr[i]);
    }

    srcList.value=arr;
    // url.value=srcList.value[0];
  }


//================scz  modify
const complainID=ref(0);
const isComplaintDialogVisible = ref<boolean>(false);  // 切换投诉对话框的可见性
  const complain = (CUS_ID) => {
    console.log("当前投诉的用户id是："+CUS_ID)
    complainID.value=CUS_ID;
    console.log("isComplaintDialogVisible.value:"+isComplaintDialogVisible.value)
    // 打开投诉对话框
    isComplaintDialogVisible.value = true;
    //
  }
const appMatters = ref<number | null>(null);
  const complaintText = ref<string>('');  // 存储投诉文本
    const handleExceed = () => {
    alert('最多只能上传三张图片');
  };
  const fileList = ref<any[]>([]);
  const sctImages = ref<string[]>([]);

  // 转换图片为Base64
  const beforeUpload = (file: File) => {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = () => {
        if (reader.result) {
          sctImages.value.push(reader.result.toString());
          resolve(true);
        } else {
          reject(new Error('文件转换错误'));
        }
      };
    });
  };
  // 提交表单数据
  const submitForm = async () => {
    if(appMatters.value===-1||complaintText.value===''|| !sctImages.value || sctImages.value.length === 0){
          ElMessage({
            message: '请完整填写3项申诉内容！',
            type: 'warning',
          })
        return;
       }
    if (appMatters.value !== null&&complaintText.value!==null) {
      try {
        console.log("base64数组："+sctImages.value);
        
          const response = await axios.post(`/api/appeal/createAppeal`, {
            app_matters: appMatters.value,
            app_content: complaintText.value,
            sct_images: sctImages.value,
            app_userID: sessionStorage.getItem("sto_id"),
            //这里后续需要进一步修改
            user_ID:complainID.value,
            com_ID:-1,
            cmt_ID:-1,

            // 其他需要发送的字段
          });
          console.log('Server response:', response.data);
          sctImages.value=[];
            complaintText.value='';
            isComplaintDialogVisible.value=false;
            ElMessage({
              message: '已经成功发送申诉！',
              type: 'success',
            })
        
       
      } catch (error) {
        console.error('Error submitting form:', error);
      }
    } else {
      alert('未选择必填项！');
    }
  };
  async function submitComplaint() {
// 提交投诉的逻辑


// 这里添加发送到后端 API 的代码
// ...

// 关闭投诉对话框
isComplaintDialogVisible.value = false;
}



// 定义watch函数
watch(isComplaintDialogVisible, (newValue, oldValue) => {
      if (newValue === false) {
        sctImages.value = [];
        complaintText.value = '';
        appMatters.value = -1;
      }
    });
  </script>
  
  <!-- Add "scoped" attribute to limit CSS to this component only -->
  <style scoped>
  .el-row {
  margin-bottom: 20px;
}
.el-row:last-child {
  margin-bottom: 0;
}
.el-col {
  border-radius: 4px;
}

.grid-content {
  border-radius: 4px;
  min-height: 36px;
}
  h3 {
    margin: 40px 0 0;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  a {
    color: #42b983;
  }
  .demo-image__error .image-slot {
  font-size: 30px;
}
.demo-image__error .image-slot .el-icon {
  font-size: 30px;
}
.demo-image__error .el-image {
  width: 100%;
  height: 200px;
}

.categoryStyle{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
  </style>
  