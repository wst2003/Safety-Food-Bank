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
                    <el-button @click="queryFavor" type="danger"><el-icon><search/></el-icon></el-button>
                    </template>
                </el-input>
            </el-col>
            <el-col :span="4">
                <!-- <el-button type="danger" @click="queryClearReset">显示所有</el-button> -->
            </el-col>

            <!-- <el-col :span="8">
                <el-text>点击筛选：</el-text>
                <el-button  color=" #aa0d0d" @click="noleftCom" >售罄</el-button>
                <el-button  color=" #b1b3b8" @click="expiredCom" >过期</el-button>
            </el-col> -->
        </el-row>
        <!-- 列表区域 -->
        <el-table 
            :data="favorListOnDisplay"  
            :row-class-name="tableRowClassName"
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
            <el-table-column label="简介" prop="com_introduction"></el-table-column>
            <el-table-column label="当前价格" prop="com_price"></el-table-column>
            <el-table-column label="过期日期" prop="com_expirationDate">
                <template  v-slot="scope">
                    <el-text type="danger" v-if="scope.row.com_status==-1">已过期 </el-text>
                    <el-text :style="{color:ex_color(scope.row.com_expirationDate)}" v-else>{{ scope.row.com_expirationDate }} </el-text>            
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
            :total="favorListAfterPick.favorListAfterPick.length" 
            @current-change="handleCurrentChange"
        >
        </el-pagination>

    </el-card>
</template>
<script setup lang="ts">
import {reactive,onMounted, computed,ref,onActivated} from 'vue';
import {useRouter} from 'vue-router'
import  baseURL  from "../../../../router/baseURL.js";
import {store}from '../../../../router/store'
import axios from 'axios';
import {
  Star,
  StarFilled
} from '@element-plus/icons-vue'
import { ElMessageBox } from 'element-plus';
const router=useRouter()

interface FavorInfo{
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
    com_status:number
}
//从后端拉取到的，收藏单品信息

const loading=ref(true)

const user_id=ref();
const favorListAfterPick=reactive({ favorListAfterPick:Array<FavorInfo>()})
//筛选后的收藏
const favorList=reactive({favorList:Array<FavorInfo>()})
//该用户的所有收藏

const queryInfo=reactive({
    query:'',//查询参数
    pagenum: 1,//当前页码
    pagesize:10//每页显示条数
})

const favorListOnDisplay= computed(()=>{
    return favorListAfterPick.favorListAfterPick.slice(queryInfo.pagesize*(queryInfo.pagenum-1),queryInfo.pagesize*queryInfo.pagenum);
})
//显示的收藏
onMounted(()=>{
    user_id.value=sessionStorage.getItem("cus_id")
})
onActivated(()=>{
    store.activePath='/home/personalFavor'
    loading.value=true;
    axios.get(
        baseURL+`/api/cus/favorite/getFavor`,
        {
            params: {
                cus_id: user_id.value
                //用户ID
            }
        }).then(res=>{
            favorList.favorList=res.data.favor_list;
            //这里可能需要对图片的相对路径进行处理
            favorList.favorList.forEach((item)=>{
                item.com_firstImage=baseURL+'/'+item.com_firstImage
            })
            console.log('收藏列表拉取成功',favorList.favorList)
            //这里可能需要对筛选条件进行处理
            favorListAfterPick.favorListAfterPick=favorList.favorList;
           
        }).catch(error => {
            console.error('收藏请求失败', error);
            ElMessageBox.alert('收藏数据请求失败!', '', {
                confirmButtonText: 'OK'
            })
        }).finally(()=>{
            loading.value=false;
        });
})

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


function noleftCom(){
    let res=favorList.favorList.filter((item)=>{
        if(item.com_status==0)
            return true;
        else
            return false;
    })
    favorListAfterPick.favorListAfterPick=res
}

function expiredCom(){
    // let res=favorList.favorList.filter((item)=>{
    //     let dateNow= new Date();
    //     let dateEx= new Date(item.com_expirationDate);
    //     if(dateNow>=dateEx)
    //         return true;
    //     else
    //         return false;
    // })
    let res=favorList.favorList.filter((item)=>{
        if(item.com_status==-1)
            return true;
        else
            return false;
    })
    favorListAfterPick.favorListAfterPick=res
}
function handleCurrentChange(){
    console.log('当前页数',queryInfo.pagenum)

}
function comClick(com_id:number){
    router.push({ 
            path: '/home/commodityDetail', 
            query: { com_id: com_id ,
                    cus_id:user_id.value} 
        })
}
function stoClick(sto_id:number){
    router.push({ 
            path: '/storeDetail', 
            query: { sto_id: sto_id,
                cus_id:user_id.value } 
        })
}
function favorClick(com_id){
    console.log('更改收藏状态',com_id)

    let pick_index=favorListAfterPick.favorListAfterPick.findIndex((element)=>{
        return element.com_id==com_id
    })
    let ori_index=favorList.favorList.findIndex((element)=>{
        return element.com_id==com_id
    })

    favorListAfterPick.favorListAfterPick[pick_index].favor_state==1?
        favorListAfterPick.favorListAfterPick[pick_index].favor_state=0:
        favorListAfterPick.favorListAfterPick[pick_index].favor_state=1;
    favorList.favorList[ori_index].favor_state=favorListAfterPick.favorListAfterPick[pick_index].favor_state;
    axios.post(
        baseURL+'/api/cus/favorite/setFavorState',
        JSON.stringify({
            com_id:com_id,
            cus_id:user_id.value,
            //此处指定收藏的用户，后续更改
            favor_state: favorList.favorList[ori_index].favor_state
        }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(res =>{
        console.log(res.data.msg)
    }).catch(error => {
        console.error('收藏请求失败', error);
        favorListAfterPick.favorListAfterPick[pick_index].favor_state==1?
            favorListAfterPick.favorListAfterPick[pick_index].favor_state=0:
            favorListAfterPick.favorListAfterPick[pick_index].favor_state=1;
        favorList.favorList[ori_index].favor_state=favorListAfterPick.favorListAfterPick[pick_index].favor_state;
    });

}

function tableRowClassName (row: FavorInfo) {
    //处理表格背景样式
    let dateNow= new Date();
    let dateEx= new Date(row.com_expirationDate);
    if(dateNow>=dateEx){
        return 'success-row'
    }
    if (row.com_left <= 0) {
        return 'warning-row'
    }
    return ''
}


function queryFavor(){
    console.log(queryInfo.query);
    //在表中显示满足搜索条件的商品或商家
    let res=favorList.favorList.filter((item)=>{
        return item.com_name.includes(queryInfo.query)||item.sto_name.includes(queryInfo.query)
    })
    favorListAfterPick.favorListAfterPick=res
}

function queryClearReset(){
    console.log(queryInfo.query);
    //重新显示所有收藏
    favorListAfterPick.favorListAfterPick=favorList.favorList;
}

</script>

<style scoped>
.el-table .warning-row {
  --el-table-tr-bg-color: var(--el-color-warning-light-9);
}
.el-table .success-row {
  --el-table-tr-bg-color: var(--el-color-success-light-9);
}
</style>
