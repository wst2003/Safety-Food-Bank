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
  
  </el-row>
    <el-row>
    <el-col :span="24">
      <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
      <el-input placeholder="请输入内容" clearable v-model="query" />
        </el-col>
        
        <el-col :span="7"><el-button type="primary" icon="search" @click="getGoods"/></el-col>
        <el-col :span="3"><el-tag>按名称排序方式：</el-tag></el-col>
        <el-col :span="4">
        <el-radio-group v-model="tableLayout">
          <el-radio-button label="升序" @click="checkLeft"/>
          <el-radio-button label="默认" @click="checkLeft1"/>
          <el-radio-button label="降序" @click="checkLeft2"/>
        </el-radio-group>
        </el-col>
      </el-row>
  
      <el-row>
    <el-table
      v-loading="loading"
     :data="goodsList"
      style="width: 100%" max-height="1000" 
      border 
      stripe
      @sort-change="changeSort"
      :default-sort="{ prop: 'USER_ID', order: 'ascending' }"
      >
      <el-table-column label="用户图片" width="200" v-if="type=='1'">
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
      <el-table-column prop="USER_NAME" label="用户名字"> </el-table-column>
      <el-table-column prop="USER_ID" sortable="custom" label="用户ID">
        <template #default="scope">
        <el-tag @click="router.push({path:'/UserInfoPage',query:{id:goodsList[scope.$index].USER_ID,flag:1}})">{{ goodsList[scope.$index].USER_ID }}</el-tag>
        </template>
      </el-table-column>
    <el-table-column prop="USER_REGTIME" label="用户注册日期" >
    </el-table-column>
      <!-- <el-table-column prop="USER_STATE"  label="用户状态">
      </el-table-column> -->

      <el-table-column label="操作" width="250px">
      <template #default="scope">
        <el-button
          type="warning"
          icon="List"
          size="medium"
          color="#ff9966"
          style="color: white;"
          @click="viewIndent(scope.$index)"
          v-if= "parseInt(type)"
          ></el-button>
        <el-button
          type="success"
          icon="Goods"
          size="medium"
          color="#ffcb66"
          style="color: white;"
          @click="viewCommodity(scope.$index)"
          v-if= "parseInt(type)"
          ></el-button>
        <el-button
          type="danger"
          size="medium"
          @click="changeState(scope.$index)"
          v-if= "isOverDate[scope.$index]"
        >封禁</el-button>
        <el-button
          type="primary"
          size="medium"
          @click="changeState(scope.$index)"
          v-if= "!isOverDate[scope.$index]"
        >解封</el-button>
        </template>
    </el-table-column>
    </el-table>
    </el-row>
    <!-- 分页区域 -->
    <el-row>
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
            :current-page="pagenum" :page-sizes="[1, 3, 5, 10, 15, 20]" :page-size="pagesize"
            layout="total, sizes, prev, pager, next, jumper" :total="type=='1'? 13:5">
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
    import { ArrowLeft, User } from '@element-plus/icons-vue'
    import { ElMessage, ElMessageBox,ElNotification } from 'element-plus'
import { id } from 'element-plus/es/locale';
    const router=useRouter();
    const pagenum=ref(1);
    const pagesize=ref(5);
    const query=ref('');
    const haveQuery=ref('');
    const tableLayout = ref('默认')
    const uploadDate=ref('');
    const expirationDate=ref('')
    const loading=ref(false);
    const ableEdit = ref([true]);
    const isEmpty = ref([true]) //是否售空
    const isOverDate = ref([true]) //是否过期
    const sto_id=ref('');
    const route=useRoute();
    const type=ref('');
    const dialogVisible = ref(false)
    const text=ref('');
    const goodsList=ref([
        {
            "USER_ID": 1000001,
            "USER_NAME": "张翔",
            "USER_REGTIME": "2023-08-01",
            "USER_STATE": '1',
            "STO_IMAGE": "store_image\\1000040_picture.jpg"
        }
    ]);

  
  const status=ref(1);  //1 在售 0 售罄/下架 -1 过期
  const id_order=ref(1);
  const name_order=ref(-1);
  const category=ref([]);
  const getGoodsList=async()=>{
    loading.value=Boolean(true);
    goodsList.value.length=0;
    var Name=query.value;
    if(Name.length==0)
        Name="NULL";
    axios.get('/api/administrator/userlist?ID_ORDER='+id_order.value+'&NAME_ORDER='+name_order.value+'&USER_NAME='+Name+'&USER_TYPE='+type.value+'&BEGIN_NUMBER='+(pagesize.value*(pagenum.value-1)+1)+'&END_NUMBER='+(pagesize.value*pagenum.value)) 
      .then(response=>{
        console.log(id_order.value);
        console.log(pagesize.value*(pagenum.value-1)+1);
        console.log(pagesize.value*pagenum.value);
        console.log(type);
        goodsList.value=JSON.parse(JSON.stringify(response.data));
        for(var i=0;i<goodsList.value.length;++i){
           getState(i)
           if(goodsList.value[i].USER_STATE=='1')
            goodsList.value[i].USER_STATE='离线';
            else
              goodsList.value[i].USER_STATE='在线'
        }
        // console.log(goodsList.value[0].USER_REGTIME)
        isEmpty.value = []
        isOverDate.value=[]
        
        loading.value=Boolean(false);
      })
  }
  
  
  const getGoods=async()=>{
    getGoodsList().then(()=>{
    ElNotification.success({
      title: 'Success',
      message: '搜索成功',
      duration: durationTime
    })})

    haveQuery.value=query.value;
  }
  
  const changeSort=(value)=>{
    console.log(value.order);
    if(value.order=='ascending')
      id_order.value=1;
    else
      id_order.value=0;
    
    var str='';
    for(var i=0;i<query.value.length;++i)
      str+=query.value[i];
    console.log(str);
    query.value=haveQuery.value;
    getGoodsList();
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
    // console.log(change([goodsList.value[index].STO_IMAGE]));
    return goodsList.value[index].STO_IMAGE;
  }

    onBeforeUpdate(()=>{
      //sto_id.value = route.query.sto_id as string;
    //   sto_id.value = sessionStorage.getItem('sto_id') as string;
        type.value=route.query.type as string;
    //   console.log(sto_id.value);
        // console.log(type);
        getGoodsList();
    });

    onMounted(()=>{
      //sto_id.value = route.query.sto_id as string;
    //   sto_id.value = sessionStorage.getItem('sto_id') as string;
        type.value=route.query.type as string;
    //   console.log(sto_id.value);
        // console.log(type);
        getGoodsList();
    });

  var durationTime=2000;
  
  
    const handleSizeChange=(val:number)=>{
      pagesize.value=val;
      getGoodsList();
    }
  
    const handleCurrentChange=(val:number)=>{
      pagenum.value=val;
      
      getGoodsList();
    }

  
  
  const viewIndent=(index:number)=>{
    // sessionStorage.setItem('sto_id',goodsList.value[index].USER_ID.toString());
    router.push({
        path:'/indent',
        query:{
            sto_id:goodsList.value[index].USER_ID
        }
    })
  }
  const viewCommodity=(index:number)=>{
    // sessionStorage.setItem('sto_id',goodsList.value[index].USER_ID.toString());
    router.push({
        path:'/commodity',
        query:{
            sto_id:goodsList.value[index].USER_ID,
            admi:1
        }
    })
  }

const checkLeft=()=>{
  name_order.value=1;
  getGoodsList();
}

const checkLeft1=()=>{
  name_order.value=-1;
  getGoodsList();
}

const checkLeft2=()=>{
  name_order.value=0;
  getGoodsList();
}

const getState=(index:number)=>{
  axios.get('api/administrator/userstate?USER_ID='+goodsList.value[index].USER_ID+'&USER_TYPE='+type.value)
  .then(response=>{
    console.log('getState : '+(parseInt(response.data)==1));
    isOverDate.value[index]=(parseInt(response.data)==1);
  })
  return;
}

const changeState=(index:number)=>{
  var temp=isOverDate.value[index]? 1:0;
  // console.log(getState(index))
  console.log('from_State : '+temp);
  temp^=1
  // dialogVisible.value=true;
  axios.post('api/administrator/changeuserstate',{USER_ID:goodsList.value[index].USER_ID,USER_TYPE:type.value,TO_STATE:temp})
    .then(response=>{
      getState(index)
      ElNotification.success({
            title: 'Success',
            message: '成功',
            duration: 2000
          })
    });
  console.log('to_State : '+temp);
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
      ElNotification.success({
            title: 'Success',
            message: '成功',
            duration: 2000
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
    