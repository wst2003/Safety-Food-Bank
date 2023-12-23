<template>
  <el-dialog v-model="dialogVisible" title="理由发布" width="30%" draggable>
    <el-input
    v-model="text"
    class="w-50 m-2"
    type="textarea"
    placeholder="请输入理由"
    style="width: 450px"
    maxlength="400"
    show-word-limit
    autosize
  />
  <template #footer>
      <span class="dialog-footer">
        <el-button @click="noticeNotUpload">取消</el-button>
        <el-button type="primary" @click="noticeUpload">
          确认
        </el-button>
      </span>
    </template>
  </el-dialog>
    <el-row>
  <el-page-header :icon="ArrowLeft" title="返回" @back="goBack" >
    <template #content>
      <span class="text-large font-600 mr-3"> 商品总览 </span>
    </template>
  </el-page-header>
  
  </el-row>
    <el-row>
    <el-col :span="24">
      <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
      <el-input placeholder="请输入内容" clearable v-model="query" />
        </el-col>
        <el-button type="primary" icon="search" @click="getGoods"/>
        <el-col :span="10"></el-col>
        <el-col :span="5">
        
          <el-radio-group v-model="tableLayout">
            <el-radio-button label="在售" @click="checkLeft"/>
            <el-radio-button label="售罄" @click="checkLeft1"/>
            <el-radio-button label="过期" @click="checkLeft2"/>
          </el-radio-group>
              
        </el-col>
      </el-row>
  
      <el-row>
    <el-table
      v-loading="loading"
     :data="goodsList"
      style="width: 100%" max-height="1000" 
      border 
      @sort-change="changeSort"
      :default-sort="{ prop: 'com_id', order: 'ascending' }"
      :row-style="changeStyle"
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
              @click="getSrcList(scope.$index)"
            />
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="com_name" label="商品名字"> </el-table-column>
      <el-table-column prop="com_id" sortable="custom" label="商品ID"></el-table-column>
      <el-table-column prop="com_curr_price" label="当前价格"></el-table-column>
      <el-table-column
      prop="com_left"
      label="商品余量"
      ></el-table-column>
      <el-table-column
      prop="com_categories"
      label="商品类别"
      width="225"
      >
      <template #header>
        <div class="categoryStyle">
        {{'商品类别'}}
        <el-select
        v-model="category"
        multiple
        collapse-tags
        collapse-tags-tooltip
        :max-collapse-tags="2"
        placeholder="Select"
        style="width: 210px"
      >
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
        />
      </el-select>
      </div>
      </template>
    </el-table-column>
    <el-table-column prop="com_uploaddate" label="上传日期" width="160">
      <template #header>
        <div class="categoryStyle">
        {{'上传日期'}}
            <el-date-picker
              v-model="uploadDate"
              type="date"
              placeholder="Pick a day"
              :disabled-date="disabledDate"
              :shortcuts="shortcuts"
              size="default"
              style="width: 150px"
              value-format="YYYY-MM-DD"
            />
          </div>
        </template>
    </el-table-column>
    <el-table-column prop="com_expirationdate" label="过期日期" width="160">
      <template #header>
        <div class="categoryStyle">
        {{'过期日期'}}
            <el-date-picker
              v-model="expirationDate"
              type="date"
              placeholder="Pick a day"
              :shortcuts="shortcuts"
              size="default"
              style="width: 150px"
              value-format="YYYY-MM-DD"
            />
          </div>
        </template>
    </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="scope">
          <el-button
            type="primary"
            icon="search"
            size="medium"
            @click="viewDetail(scope.$index)"
            ></el-button>
          <el-button
            type="primary"
            icon="edit"
            size="medium"
            :disabled = "isOverDate[scope.$index]"
            @click="viewUpdate(scope.$index)"
            v-if="!parseInt(admi)"
            ></el-button>
          <el-button
            type="danger"
            icon="delete"
            size="medium"
            :disabled = "isEmpty[scope.$index]||isOverDate[scope.$index]"
            @click="deleteCommodity(scope.$index)"
          ></el-button>
          </template>
      </el-table-column>
    </el-table>
    </el-row>
    <!-- 分页区域 -->
    <el-row>
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
            :current-page="pagenum" :page-sizes="[1, 3, 5, 10, 15, 20]" :page-size="pagesize"
            layout="total, sizes, prev, pager, next, jumper" :total="tot">
    </el-pagination>
  </el-row>
  
  </el-card>
  </el-col>
  </el-row>
    </template>
    
    <script lang="ts" setup>
    import { Options, Vue } from 'vue-class-component';
    import axios from 'axios';
    import {onMounted, ref,onBeforeUpdate} from 'vue'
    import { useRouter,useRoute } from 'vue-router';
    import { ArrowLeft } from '@element-plus/icons-vue'
    import { ElMessage, ElMessageBox,ElNotification, dayjs } from 'element-plus'
  import { ConsoleLogger } from '@microsoft/signalr/dist/esm/Utils';
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
    const sto_id=ref('');
    const route=useRoute();
    const admi=ref('0');
    const dialogVisible = ref(false)
    const text=ref('');
    const idx=ref(1);
    const goodsList=ref([
      {
          "com_id": 1,
          "com_name": "商品1",
          "com_left": 1,
          "com_uploaddate":'',
          "com_expirationdate":'',
          "com_curr_price": 0.01,
          "com_categories": [
              "苹果"
          ],
          "com_image": [
              ".\\wwwroot\\commodity_image\\1\\com_image_0.jpg"
          ]
      }
  ]);
  const shortcuts = [
    {
      text: 'Today',
      value: new Date(),
    },
    {
      text: 'Yesterday',
      value: () => {
        const date = new Date()
        date.setTime(date.getTime() - 3600 * 1000 * 24)
        return date
      },
    },
    {
      text: 'A week ago',
      value: () => {
        const date = new Date()
        date.setTime(date.getTime() - 3600 * 1000 * 24 * 7)
        return date
      },
    },
  ]
  const disabledDate = (time: Date) => {
    return time.getTime() > Date.now()
  }
  const options =ref( [
    {
      value: '主食',
      label: '主食',
    },
    {
      value: '面包',
      label: '面包',
    },
    {
      value: '苹果',
      label: '苹果',
    }
  ]);
  const tot =ref(0)
  const status=ref(1);  //1 在售 0 售罄/下架 -1 过期
  const order=ref(0);
  const category=ref([]);
  const getGoodsList=async()=>{
    loading.value=Boolean(true);
    goodsList.value.length=0;
    axios.get('/api/sto/StoreQueryCommodity/totalnum?STO_ID='+sto_id.value+'&COM_STATUS='+status.value)
  .then(response=>{
    tot.value=response.data;
  });
    axios.post('/api/sto/StoreQueryCommodity/list?STO_ID='+sto_id.value+'&com_begin_n='+(pagesize.value*(pagenum.value-1)+1)+'&com_end_n='+(pagesize.value*pagenum.value),{
      "status":status.value,
      "order":order.value,
      "category":category.value,
      "query":query.value,
      'COM_UPLOADDATE':uploadDate.value,
      'COM_EXPIRATIONDATE':expirationDate.value
    }) 
      .then(response=>{
        console.log(pagesize.value*(pagenum.value-1)+1);
        console.log(pagesize.value*pagenum.value);
        goodsList.value=JSON.parse(JSON.stringify(response.data));
        isEmpty.value = []
        isOverDate.value=[]
        for(var i = 0; i < goodsList.value.length;i++){
          if(status.value==1){
            isEmpty.value.push(false);
            isOverDate.value.push(false);
          }
          else if (status.value==0){
            isEmpty.value.push(true);
            isOverDate.value.push(false);
          }
          else{ if(status.value==-1)
            if(goodsList.value[i].com_left !=0)  {isEmpty.value.push(false);}
            else {isEmpty.value.push(true);}
            isOverDate.value.push(true);
          }
        }
        loading.value=Boolean(false);
      })
  }
  
  const checkLeft=()=>{
    status.value=1;
    getGoodsList();
  }
  
  const checkLeft1=()=>{
    status.value=0;
    getGoodsList();
  }
  
  const checkLeft2=()=>{
    status.value=-1;
    getGoodsList();
  }
  
  const getGoods=async()=>{
    getGoodsList().then(()=>
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
      order.value=0;
    else
      order.value=1;
    
    var str='';
    for(var i=0;i<query.value.length;++i)
      str+=query.value[i];
    console.log(str);
    query.value=haveQuery.value;
    getGoodsList();
    query.value=str;
  }
  
  function change(strr :string[]){
      return strr;
    // var arr=[''];
    //   for(var i=0;i<strr.length;i++)
    //     arr.push(strr[i]);
    //   for(i=1;i<arr.length;i++){
    //     var str=arr[i].split('\\');
    //     arr[i]='/';
    //     for(var j=2;j<str.length;j++){
    //       arr[i]+=str[j];
    //       if(j!=str.length-1)
    //         arr[i]+='/'
    //     }
    //     // console.log(arr[i]);
    //   }
    //
    //   // srcList.value=arr;
    //   // console.log(arr.length)
    //   return arr[1];
  }
  
  
  const srcList =ref( [
    "/commodity_image\\1\\com_image_0.jpg",
    ]);
  const url = 'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg';
  const getUrl=(index:number)=>{
    return change(goodsList.value[index].com_image);
  }
  
  const goBack=()=>{
    history.back();
  }
  onMounted(()=>{
      //sto_id.value = route.query.sto_id as string;
      if(route.query.sto_id==null)
        sto_id.value = sessionStorage.getItem('sto_id') as string;
      else
        sto_id.value = route.query.sto_id as string;
  
      if(route.query.admi!=null)
        admi.value='1';
      console.log(sto_id.value);
        getGoodsList();
    });
  
  onBeforeUpdate(()=>{
    if(route.query.sto_id==null)
        sto_id.value = sessionStorage.getItem('sto_id') as string;
      else
        sto_id.value = route.query.sto_id as string;
      console.log(sto_id.value);
        getGoodsList();
  })
    const viewDetail=(index: number)=>{
        // router.push('/view');
        console.log(goodsList.value[index].com_id);
        router.push({
          path: '/indDetail',
          query:{
              com_id:goodsList.value[index].com_id
          }
      });
    }
  var durationTime=2000;
  const viewUpdate=(index: number)=>{
        // router.push('/view');
        console.log(goodsList.value[index].com_id);
        router.push({
          path: '/updateCommodity',
          query:{
              com_id:goodsList.value[index].com_id,
              sto_id:sto_id.value
          }
      });
    }
  
    const deleteCommodity=(index: number)=>{
  
      ElMessageBox.confirm(
      '此操作将下架该商品，是否继续？',
      'Warning',
      {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
        type: 'warning',
      }
    )
      .then(() => {
        idx.value=index;
        // dialogVisible.value=true;
        noticeUpload();
      })
      .catch(() => {
        ElNotification({
          title: 'Info',
          message: '操作取消',
          type: 'info',
          duration: durationTime
        })
      })
  
    }
  
  
    const handleSizeChange=(val:number)=>{
      pagesize.value=val;
      getGoodsList();
    }
  
    const handleCurrentChange=(val:number)=>{
      pagenum.value=val;
      
      getGoodsList();
    }
  
    const getSrcList=(index:number)=>{
      var arr: string[];
      // arr=goodsList.value[index].com_image;
      arr=[];
      for(var i=0;i<goodsList.value[index].com_image.length;i++)
        arr.push(goodsList.value[index].com_image[i]);
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
  
    const tableRowClassName = ({
      rowIndex,
    }: {
      rowIndex: number
    }) => {
      if (rowIndex === 1) {
        return 'warning-row'
      } else if (rowIndex === 3) {
        return 'success-row'
      }
      return ''
    }
  
    const changeStyle=({row,index})=>{
      console.log(dayjs(row.com_expirationdate).add(1,'day').isBefore(dayjs()));
      // console.log(dayjs());
      if(dayjs(row.com_expirationdate).add(1,'day').isBefore(dayjs()))
        return '--el-table-tr-bg-color: var(--el-color-error-light-9);'
      else if(dayjs(row.com_expirationdate).add(1,'day').isBefore(dayjs().add(5,'day')))
        return '--el-table-tr-bg-color: var(--el-color-warning-light-9);'
      else if(dayjs(row.com_expirationdate).add(1,'day').isBefore(dayjs().add(1,'month')))
        return '--el-table-tr-bg-color: var(--el-color-success-light-9);'
    }

    const noticeNotUpload=()=>{
    dialogVisible.value = false;
    ElNotification({
        title: 'Info',
        message: '操作取消',
        type: 'info',
        duration: 2000
      })
      text.value='';
    
  }
  const noticeUpload=()=>{
    dialogVisible.value = false;
    axios.post('api/sto/UpdateCommodity/delcommodity?COM_ID='+goodsList.value[idx.value].com_id)
          .then(response=>{
            console.log(response);
            ElNotification.success({
              title: 'Success',
              message: '下架成功',
              duration: durationTime
            })
            var str=query.value;
            query.value=haveQuery.value;
            getGoodsList();
            query.value=str;
          })
          .catch((error)=>{
            ElNotification({
              title: 'Error',
              message: '下架失败',
              type: 'error',
              duration: durationTime
            })
          })
          dialogVisible.value=false;
          text.value='';
    }
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
  <style>
  .el-table .warning-row {
    --el-table-tr-bg-color: var(--el-color-warning-light-9);
    /* background-color: aquamarine; */
    /* color: aqua; */
  }
  .el-table .success-row {
    --el-table-tr-bg-color: var(--el-color-success-light-9);
  }
  </style>
    