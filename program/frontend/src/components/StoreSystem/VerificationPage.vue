<template>
  <el-dialog v-model="dialogVisible" title="信息确认" draggable>
    <el-tag>{{'用户ID: '+ resVerificate.CUS_ID }}</el-tag>
    <el-table :data="resVerificate.LIST" border style="width: 100%" height="150">

        <el-table-column prop="IND_ID" label="订单ID">

        </el-table-column>
        <el-table-column prop="COM_ID" label="商品ID" >
          <template #default="scope">
            <el-tag @click="router.push('/view?com_id='+resVerificate.LIST[scope.$index].COM_ID)">{{ resVerificate.LIST[scope.$index].COM_ID }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="IND_QUANTITY" label="订单数量" />
        <el-table-column prop="COM_NAME" label="商品名称" />
        <el-table-column prop="IND_ID" label="订单ID" />
    </el-table>
    <template #footer>
      <span class="dialog-footer">
        <el-button type="primary" @click="dialogVisible=false">
          确定
        </el-button>
      </span>
    </template>
  </el-dialog>
<el-card>
<el-row :gutter="20">
<el-col :span="8">
<el-input placeholder="请输入核销码" clearable v-model="query" :disabled="Boolean(state)" />
  </el-col>
  <el-button type="danger" icon="search" @click="verificate" :disabled="Boolean(state)" />
  <el-col :span="2"/>
  <el-col :span="4">
    <el-radio-group v-model="tabPosition" fill="#F56C6C" style="margin-bottom: 30px">
      <el-radio-button label="top" @click="order=1,getVerificationsList()">最早购买</el-radio-button>
      <el-radio-button label="right" @click="order=0,getVerificationsList()">最近购买</el-radio-button>
    </el-radio-group>
    </el-col>
  <el-col :span="8">
    <el-input placeholder="请输入电话号" clearable v-model="phone" />
    <!-- <el-button type="primary" icon="search" @click="getVerificationsList"/> -->
  </el-col>
  <el-button type="danger" icon="search" @click="getVerificationsList"/>
  
  <el-col :span="10"></el-col>
  <el-col :span="5">

        
  </el-col>
</el-row>

<el-tabs type="border-card" class="demo-tabs"  v-loading="loading">
  <el-tab-pane>
    <template #label>
      <span class="custom-tabs-label"  @click="state=0,getVerificationsList()">
        <el-icon><Warning /></el-icon>
        <span>待核销</span>
      </span>
    </template>
  </el-tab-pane>

  <el-tab-pane>
    <template #label>
      <span class="custom-tabs-label"  @click="state=1,getVerificationsList()">
        <el-icon><CircleCheck /></el-icon>
        <span>已核销</span>
      </span>
    </template>
  </el-tab-pane>

  <el-tab-pane>
    <template #label>
      <span class="custom-tabs-label"  @click="state=-1,getVerificationsList()">
        <el-icon><CircleClose /></el-icon>
        <span>过期未取</span>
      </span>
    </template>
  </el-tab-pane>


  <el-row :gutter="20">
    <el-col :span="12" v-for="(item,index) in verificationsList" :key="index">
    <el-card>
        <el-descriptions
        class="margin-top"
        title="订单信息"
        :column="3"
        size="small"
        border
    >
        <template #extra>
        </template>
        <el-descriptions-item>
        <template #label>
            <div class="cell-item">
            <el-icon :style="iconStyle">
                <user />
            </el-icon>
            用户名
            </div>
        </template>
        {{ item.CUS_NICKNAME }}
        </el-descriptions-item>
        <el-descriptions-item>
        <template #label>
            <div class="cell-item">
            <el-icon :style="iconStyle">
                <iphone />
            </el-icon>
            电话
            </div>
        </template>
        {{item.USER_PHONE}}
        </el-descriptions-item>
        <el-descriptions-item>
        <template #label>
            <div class="cell-item">
            <el-icon :style="iconStyle">
                <location />
            </el-icon>
            用户ID
            </div>
        </template>
        {{item.CUS_ID}}
        </el-descriptions-item>
        <el-descriptions-item>
        <template #label>
            <div class="cell-item">
            <el-icon :style="iconStyle">
                <tickets />
            </el-icon>
            订单创建时间
            </div>
        </template>
        <el-tag size="small" type="warning">{{item.IND_CREATIONTIME}}</el-tag>
        </el-descriptions-item>
        
    </el-descriptions>

        <el-table :data="item.BOX" border style="width: 100%" height="150">
          <!-- <el-table-column label="商品图片" width="105">
            <template #default="scope">
              <div style="display: flex; align-items: center">
                <el-image
                  style="width: 180px; height: 90px"
                  :src="change([item.BOX[scope.$index].COM_IMAGE])"
                  :zoom-rate="1.2"
                  :initial-index="0"
                  fit="fill"
                />
              </div>
            </template>
            <template #header="scope">
                    {{ '商品图片' }}
                    <el-tooltip
                        effect="dark"
                        :content="item.BOX[scope.$index].IND_NOTES"
                        placement="top"
                    >
                        <el-icon style="margin-left: 4px" :size="12">
                        <Warning />
                        </el-icon>
                    </el-tooltip>
            </template>
          </el-table-column> -->
            <el-table-column prop="IND_ID" label="订单ID">

            </el-table-column>
            <el-table-column prop="COM_ID" label="商品ID">
              <template #default="scope">
                <el-tag @click="router.push('/view?com_id='+item.BOX[scope.$index].COM_ID)">{{ item.BOX[scope.$index].COM_ID }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="IND_QUANTITY" label="订单数量" />
            <el-table-column prop="IND_MONEY" label="订单金额" />
            <el-table-column prop="COM_NAME" label="商品名称" />
            <el-table-column prop="IND_NOTES" label="用户评论" >
                <template #default="scope">
                    {{ item.BOX[scope.$index].IND_NOTES }}
                </template>
            </el-table-column>
            <el-table-column prop="IND_RATING" label="订单评分" />
        </el-table>
    </el-card>
    </el-col>
  </el-row>
</el-tabs>

<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
      :current-page="pagenum" :page-sizes="[2, 4, 6, 10, 16, 20]" :page-size="pagesize"
      layout="sizes, prev, pager, next, jumper" :total="800" >
</el-pagination>


</el-card>
</template>




<script lang="ts" setup>
import { Options, Vue } from 'vue-class-component';
import axios from 'axios';
import {onMounted, ref,computed} from 'vue'
import { useRouter,useRoute } from 'vue-router';
import { ArrowLeft } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox,ElNotification, buildLocaleContext } from 'element-plus'
// import router from 'router';
import { it } from 'element-plus/es/locale';
const tabPosition = ref('right')
const dialogVisible=ref(false);
const router=useRouter();
const sto_id=sessionStorage.getItem('sto_id') as string;
const query=ref('');
const loading=ref(false);
const verificationsList=ref([
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
},
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
},
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
},
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
},
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
},
{
"CUS_ID": 1000001,
"IND_CREATIONTIME": "2023-08-11 15:14:56",
"USER_PHONE": "17879683110",
"CUS_NICKNAME": "张翔",
"BOX": [
  {
    "IND_ID": 1,
    "COM_ID": 263,
    "IND_QUANTITY": 2,
    "IND_MONEY": 70,
    "COM_NAME": "test1",
    "COM_IMAGE": ".\\wwwroot\\commodity_image\\263\\com_image_0.jpg",
    "IND_NOTES": "",
    "IND_RATING": "-1"
  }
]
}
])

const pagenum=ref(1);
const pagesize=ref(6);



const order=ref(0);
const phone=ref('');
const state=ref(0);
const getVerificationsList=async()=>{
loading.value=Boolean(true);
verificationsList.value.length=0;
console.log(sto_id);
var Phone=phone.value;
if(Phone.length==0)
Phone="null";
axios.get('/api/sto/storeindentlist/indentbox?STO_ID='+sto_id+'&TIME_ORDER='+order.value+'&BOX_BEGIN='+(pagesize.value*(pagenum.value-1)+1)+'&BOX_END='+(pagesize.value*pagenum.value)+"&USER_PHONE="+Phone+"&IND_STATE="+state.value) 
.then(response=>{
  console.log(pagesize.value*(pagenum.value-1)+1);
  console.log(pagesize.value*pagenum.value);
  console.log(state.value);
  verificationsList.value=JSON.parse(JSON.stringify(response.data));
  for(var i=0;i<verificationsList.value.length;++i)
    for(var j=0;j<verificationsList.value[i].BOX.length;++j){
        // console.log(verificationsList.value[i].BOX[j].IND_RATING);
        if(verificationsList.value[i].BOX[j].IND_RATING=='-1')
          verificationsList.value[i].BOX[j].IND_RATING="无评分"
    }
  console.log(verificationsList.value);
  loading.value=Boolean(false);
})
}


onMounted(()=>{
//sto_id.value = route.query.sto_id as string;
  getVerificationsList();
});



const handleSizeChange=(val:number)=>{
pagesize.value=val;
getVerificationsList();
}

const handleCurrentChange=(val:number)=>{
pagenum.value=val;

getVerificationsList();
}
const resVerificate=ref({
  "CUS_ID": 1000001,
  "LIST": [
    {
      "IND_ID": 1,
      "COM_ID": 263,
      "COM_NAME": "test1",
      "IND_QUANTITY": 2
    }
  ]
})
const verificate=()=>{
axios.post('api/sto/verficate?'+"IND_VERFICATIONCODE="+query.value)
  .then(response=>{
    console.log(response.data);
    if(response.data=='核销失败'){
      ElNotification({
        title: 'Error',
        message: '核销失败',
        type: 'error',
        duration: 2000
      })
    }
    else{
      resVerificate.value=JSON.parse(JSON.stringify(response.data));
      console.log(resVerificate.value);
      ElNotification({
        title: 'success',
        message: '核销成功',
        type: 'success',
        duration: 2000
      })
      dialogVisible.value=true;
    }

    getVerificationsList();
  })
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


const iconStyle = computed(() => {
const marginMap = {
large: '8px',
default: '6px',
small: '4px',
}
return {
marginRight: marginMap["small"] || marginMap.default,
}
})
</script>



<style>
.demo-tabs > .el-tabs__content {
padding: 32px;
color: #6b778c;
font-size: 32px;
font-weight: 600;
}
.demo-tabs .custom-tabs-label .el-icon {
vertical-align: middle;
}
.demo-tabs .custom-tabs-label span {
vertical-align: middle;
margin-left: 4px;
}
</style>