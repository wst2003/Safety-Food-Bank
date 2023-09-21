<template>

  <el-card>

    <el-row :gutter="20">
      <el-col :span="3"><el-tag>按申诉时间排序方式：</el-tag></el-col>
      <el-radio-group v-model="tableLayout">
        <el-radio-button label="升序" @click="order=0,getVerificationsList()"/>
        <el-radio-button label="降序" @click="order=1,getVerificationsList()"/>
      </el-radio-group>
      <el-col  v-for="(item,index) in verificationsList" :key="index">
      <el-card>
        {{ "申诉ID : "+item.APP_ID }}
        <el-row :gutter="20" >
            <el-col :span="5" v-for="(itemm,idx) in item.SCT_IMAGE" :key="idx"><el-image style="width: 200px; height: 100px" :src="itemm" fit="fill" :preview-src-list="[itemm]" /></el-col>
            <el-col :span="19">
              <el-descriptions
          class="margin-top"
          :column="3"
          size="large"
          border
      >
          <template #extra>
          </template>
          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <location />
              </el-icon>
              申诉时间
              </div>
          </template>
          {{item.APP_TIME}}
          </el-descriptions-item>
          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <user />
              </el-icon>
              申诉者ID
              </div>
          </template>
          
          <el-tag size="small" @click="router.push({path:'/UserInfoPage',query:{id:item.APP_USERID,flag:1}})">{{ item.APP_USERID }}</el-tag>
          </el-descriptions-item>

          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <tickets />
              </el-icon>
              申诉事项
              </div>
          </template>
          <el-tag size="small" type="danger">{{item.APP_MATTERS}}</el-tag>
          </el-descriptions-item>

          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <iphone />
              </el-icon>
              申诉商品ID
              </div>
          </template>
          <el-tag v-if="item.COM_ID=='无'" >{{'无'}}</el-tag>
          <el-tag v-else size="small" @click="router.push({path: '/indDetail',query:{com_id:item.COM_ID}});">{{item.COM_ID}}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <location />
              </el-icon>
              申诉对象ID
              </div>
          </template>
          <el-tag v-if="item.USER_ID=='无'" >{{'无'}}</el-tag>
          <el-tag v-else size="small" @click="router.push({path:'/UserInfoPage',query:{id:item.USER_ID,flag:1}})">{{item.USER_ID}}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <location />
              </el-icon>
              申诉评论ID
              </div>
          </template>
          {{ item.CMT_ID }}
            <el-tooltip
                effect="dark"
                :content="item.CMT_CONTENT"
                placement="top"
                v-if="item.CMT_ID!='无'"
            >
                <el-icon style="margin-left: 4px" :size="12">
                <Warning />
                </el-icon>
            </el-tooltip>
          </el-descriptions-item>


          <el-descriptions-item>
          <template #label>
              <div class="cell-item">
              <el-icon :style="iconStyle">
                  <location />
              </el-icon>
              申诉内容
              </div>
          </template>
          {{item.APP_CONTENT}}
          </el-descriptions-item>
      </el-descriptions>
            </el-col>
        </el-row>
          

      </el-card>
      </el-col>
    </el-row>

  <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
        :current-page="pagenum" :page-sizes="[2, 4, 6, 10, 16, 20]" :page-size="pagesize"
        layout="total, sizes, prev, pager, next, jumper" :total="800" >
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
const tableLayout = ref('升序')
const verificationsList=ref([
  {
    "APP_ID": 1,
    "APP_TIME": "2023-08-25 16:11:24",
    "SCT_IMAGE": [
      "appeal_image\\1_1.jpg",
      "appeal_image\\1_2.jpg"
    ],
    "USER_ID": "1000001",
    "COM_ID": "261",
    "CMT_ID": "-1",
    "CMT_CONTENT": "null",
    "APP_USERID": "1000000",
    "APP_MATTERS": "1",
    "APP_CONTENT": "奸商啊啊啊啊"
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
axios.get('api/administrator/appeallist?TIME_ORDER='+order.value+'&BEGIN_NUM='+(pagesize.value*(pagenum.value-1)+1)+'&END_NUM='+(pagesize.value*pagenum.value)) 
  .then(response=>{
    console.log(pagesize.value*(pagenum.value-1)+1);
    console.log(pagesize.value*pagenum.value);
    console.log(state.value);
    verificationsList.value=JSON.parse(JSON.stringify(response.data));
    for(var i=0;i<verificationsList.value.length;++i){
      if(verificationsList.value[i].CMT_ID=="-1")
        verificationsList.value[i].CMT_ID='无'
      if(verificationsList.value[i].COM_ID=='-1')
        verificationsList.value[i].COM_ID='无'
      if(verificationsList.value[i].USER_ID=='-1')
        verificationsList.value[i].USER_ID='无'
      if(verificationsList.value[i].APP_MATTERS=='1')
        verificationsList.value[i].APP_MATTERS='商品信息不实'
      if(verificationsList.value[i].APP_MATTERS=='2')
        verificationsList.value[i].APP_MATTERS='食品安全问题'
      if(verificationsList.value[i].APP_MATTERS=='3')
        verificationsList.value[i].APP_MATTERS='商家资质不全'
      if(verificationsList.value[i].APP_MATTERS=='4')
        verificationsList.value[i].APP_MATTERS='恶意评论'
      if(verificationsList.value[i].APP_MATTERS=='5')
        verificationsList.value[i].APP_MATTERS='多次退款刷单'
      if(verificationsList.value[i].APP_MATTERS=='6')
        verificationsList.value[i].APP_MATTERS='多次恶意评论'
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
  axios.post('api/verficate?'+"IND_VERFICATIONCODE="+query.value)
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
  font-size: 16px;
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