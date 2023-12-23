<template>
    <el-card>
        <!-- 搜索区域 -->
        <el-row :gutter="20">
            <el-col :span="8">
                <el-input 
                    placeholder="请输入商品名称或商家名称" 
                    v-model="queryInfo.query" 
                    clearable
                    @clear="queryClearReset"
                >
                    <template #append>
                    <el-button @click="queryHistory" type="danger"><el-icon><search/></el-icon></el-button>
                    </template>
                </el-input>
            </el-col>
            <el-col :span="4">
                <!-- <el-button type="danger" @click="queryClearReset">显示所有</el-button> -->
            </el-col>
        </el-row>
        <!-- 列表区域 -->
        <el-table 
            :data="historyList.historyList"  
            height="80vh"
            v-loading="loading"
            >
            <el-table-column type="index"></el-table-column>
            <el-table-column label="预览图" prop="com_firstImage">
                <!-- 图片的显示 -->
                <template  v-slot="scope">            
                    <img :src="scope.row.com_firstImage"  min-width="70" height="70" />
                 </template> 
            </el-table-column>
            <el-table-column label="名称" prop="com_name">
                <template v-slot="scope">
                    <el-link type="primary"   @click="comClick(scope.row.com_id)">{{ scope.row.com_name }}</el-link>
                </template>
            </el-table-column>
            <el-table-column label="浏览时间" prop="bro_time_end"></el-table-column>
            <el-table-column label="简介" prop="com_introduction"></el-table-column>
            <el-table-column label="当前价格" prop="com_price"></el-table-column>
            <el-table-column label="过期日期" prop="com_expirationDate">
                <template  v-slot="scope">
                    <el-text type="danger" v-if="scope.row.com_status==-1">已过期 </el-text>
                    <el-text :style="{color:ex_color(scope.row.com_expirationDate)}"  v-else>{{ scope.row.com_expirationDate }} </el-text>            
                 </template> 
            </el-table-column>
            <el-table-column label="余量" prop="com_left">
                <template  v-slot="scope">
                    <el-text type="danger" v-if="scope.row.com_status==0">售罄 </el-text>
                    <el-text  v-else>{{ scope.row.com_left }} </el-text>
                </template> 
            </el-table-column>
            <el-table-column label="商店" prop="sto_name">
                <template v-slot="scope">
                    <el-link type="primary"   @click="stoClick(scope.row.sto_id)">{{ scope.row.sto_name }}</el-link>
                </template>
            </el-table-column>
            <el-table-column label="操作" prop="favor_state" fixed="right">
                <template v-slot="scope">
                    <el-button type="warning" :icon="scope.row.favor_state==1?StarFilled:Star"  circle @click="favorClick(scope.row.com_id)"/>
                </template>
            </el-table-column>
        </el-table>

        <!-- 分页组件 -->
        <el-pagination 
        v-model:current-page="queryInfo.pagenum" 
            :page-size="queryInfo.pagesize" 
            layout="total, prev, pager, next, jumper"
            :total="queryInfo.total" 
            @current-change="handleCurrentChange"
        >
        </el-pagination>

    </el-card>
</template>
<script setup lang="ts">
import {reactive,onActivated,onMounted, ref} from 'vue';
import {useRouter} from 'vue-router'
import  baseURL  from "../../../../router/baseURL.js";
import  baseURL_obs  from "../../../../router/baseURL.js";
import {store}from '../../../../router/store'
import axios from 'axios';
import {
  Star,
  StarFilled
} from '@element-plus/icons-vue'
import { ElMessageBox} from 'element-plus';
const router=useRouter()
const user_id=ref();
interface ComInfo{
    com_id:number,
    com_name:string,
    com_introduction:string,
    com_oriPrice:number,
    com_expirationDate:string,
    com_uploadDate:string,
    com_left:number,
    com_rating:number,
    sto_name:string,
    sto_id:number,
    com_categories:Array<string>,
    com_firstImage:string,
    com_price:number,
    favor_state:number,
    com_status:number,
    bro_time_end:string

}

//筛选后的浏览记录
const historyList=reactive({historyList:Array<ComInfo>()})
//该用户的全部浏览记录
const queryInfo=reactive({
    query:'',//当前检索内容
    pagenum: 1,//当前页码
    pagesize:10,//每页显示条数
    total:0
})
const loading = ref(true)

//显示的记录
onMounted(()=>{
     user_id.value=sessionStorage.getItem("cus_id")
    //记得改回来
    //user_id.value=1000000
})

// 每次activated，按照当前搜索，重新拉取历史记录
onActivated(()=>{
    store.activePath='/home/history'
    loading.value=true;

    axios.post(
        `/api/cus/history/getBrowsingHistoryNumber`,
        {
            cus_id: user_id.value,
        }
    ).then(res=>{
        console.log('拉取浏览记录总数成功',res.data.bro_num)
        queryInfo.total=res.data.bro_num
        return  axios.post(
        `/api/cus/history/getBrowsingHistory`,
        {
            cus_id: user_id.value,
            begin_pos:queryInfo.pagesize * (queryInfo.pagenum - 1),
            end_pos:queryInfo.pagesize * queryInfo.pagenum,
            search_str:queryInfo.query
        })
    }).then(res=>{
            queryInfo.pagenum=1;
            historyList.historyList=res.data.com_list;
            //这里对图片的相对路径进行处理
            historyList.historyList.forEach((item)=>{
                item.com_firstImage="/"+item.com_firstImage
            })
            //queryInfo.total=res.data.total
            console.log('浏览记录拉取成功',historyList.historyList)
            loading.value=false;
        }).catch(error => {
            console.error('浏览记录请求失败', error);
            loading.value=false;
            ElMessageBox.alert('浏览记录请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });
})

function handleCurrentChange(){
    // 此处调用拉取接口
    console.log('当前页数',queryInfo.pagenum)
    loading.value=true;
    axios.post(
        `/api/cus/history/getBrowsingHistory`,
        {
            cus_id: user_id.value,
            begin_pos:queryInfo.pagesize * (queryInfo.pagenum - 1),
            end_pos:queryInfo.pagesize * queryInfo.pagenum,
            search_str:queryInfo.query
        }).then(res=>{
            historyList.historyList=res.data.com_list;
            //这里对图片的相对路径进行处理
            historyList.historyList.forEach((item)=>{
                item.com_firstImage="/"+item.com_firstImage
            })
            //queryInfo.total=res.data.total
            loading.value=false;
            console.log('浏览记录拉取成功',historyList.historyList)
        }).catch(error => {
            loading.value=true;
            console.error('浏览记录请求失败', error);
            ElMessageBox.alert('浏览记录请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });
}


function queryHistory(){
    loading.value=true;
    // 此处调用拉取接口
    console.log(queryInfo.query);
    //在表中显示满足搜索条件的商品或商家
    axios.post(
        `/api/cus/history/getBrowsingHistory`,
        {
            cus_id: user_id.value,
            begin_pos:0,
            end_pos:queryInfo.pagesize,
            search_str:queryInfo.query
        }).then(res=>{
            queryInfo.pagenum=1;
            historyList.historyList=res.data.com_list;
            //这里对图片的相对路径进行处理
            historyList.historyList.forEach((item)=>{
                item.com_firstImage="/"+item.com_firstImage
            })
            //queryInfo.total=res.data.total
            loading.value=false;
            console.log('浏览记录搜索成功',historyList.historyList)
        }).catch(error => {
            loading.value=false;
            console.error('浏览记录请求失败', error);
            ElMessageBox.alert('浏览记录请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });
}

function queryClearReset(){
    loading.value=true;
    // 此处调用拉取接口
    queryInfo.query=""
    console.log("重置搜索内容");
    //重新显示所有记录
    axios.post(
        `/api/cus/history/getBrowsingHistory`,
        {
            cus_id: user_id.value,
            begin_pos:0,
            end_pos:queryInfo.pagesize,
            search_str:""
        }).then(res=>{
            loading.value=false;
            queryInfo.query="";
            queryInfo.pagenum=1;
            historyList.historyList=res.data.com_list;
            //这里对图片的相对路径进行处理
            historyList.historyList.forEach((item)=>{
                item.com_firstImage="/"+item.com_firstImage
            })
            //queryInfo.total=res.data.total
            console.log('浏览记录拉取成功',historyList.historyList)
        }).catch(error => {
            loading.value=false;
            console.error('浏览记录请求失败', error);
            ElMessageBox.alert('浏览记录请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });
}


function comClick(com_id:number){
    router.push({ 
            path: '/home/commodityDetail', 
            query: { com_id: com_id ,cus_id:user_id.value} 
        })
}

function stoClick(sto_id:number){
    router.push({ 
            path: '/storeDetail', 
            query: { sto_id: sto_id ,cus_id:user_id.value} 
        })
}

function ex_color(expiration_date:string){
    var expirationDate = new Date(expiration_date.replace(/-/g,"/"));
    var dateNow = new Date();
    var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
    var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向下取整
    var type;
    if(dayDiff<1)
        type="red";
    else if(dayDiff<3)
        type="#e67300";
    else if(dayDiff<7)
        type="#b88230";
    else
        type="green";
    return type
}

function favorClick(com_id){
    console.log('更改收藏状态',com_id)

    let favor_state=0;

    // let ori_index=historyList.historyList.findIndex((element)=>{
    //     return element.com_id==com_id
    // })
    historyList.historyList.forEach((element)=>{
        if(element.com_id==com_id){
            element.favor_state=element.favor_state==1?0:1
            favor_state=element.favor_state
        }
    })

    // historyList.historyList[ori_index].favor_state=historyList.historyList[ori_index].favor_state==1?0:1;

    axios.post(
        '/api/cus/favorite/setFavorState',
        JSON.stringify({
            com_id:com_id,
            cus_id:user_id.value,
            //此处指定收藏的用户，后续更改
            favor_state: favor_state
        }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(res =>{
        console.log(res.data.msg)
    }).catch(error => {
        console.error('收藏请求失败', error);
        // historyList.historyList[ori_index].favor_state==1?0:1;
        historyList.historyList.forEach((element)=>{
            if(element.com_id==com_id){
                element.favor_state=element.favor_state==1?0:1
            }
        })
    });

}

</script>