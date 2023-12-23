<template>
    <el-row>
    <el-col :span="16" :offset="4">
    <el-card>
        <el-carousel :interval="5000" arrow="hover" trigger="click" v-loading="car_loading">
            <el-carousel-item v-for="item in carousel" :key="item.commdation" @click="carNav(item)" :label="item.commdation">
                <el-row justify="center">
                    <el-image :src="item.image" fit="contain">
                        <template #error>
                            <div class="image-slot">加载错误</div>
                        </template>
                    </el-image>
                </el-row>
            </el-carousel-item>
        </el-carousel>
    </el-card>
    <el-divider></el-divider>
    <el-card>

        <el-row justify="center">
        <el-space wrap>
        <div v-for="item in TagArr" :key="item.tag">
            <el-check-tag   v-model:checked="item.checked" @change="checkChange(item)">{{ item.tag }}</el-check-tag>
        </div>
        </el-space>
        </el-row>
    </el-card>
    <el-divider></el-divider>
    <el-card>
        <div v-loading="loading">
            <div style="display: flex;justify-content: center;align-items: center;" v-show="List.length==0">
                <h1 class="bg-gray-900">{{ display_str }}</h1>
            </div>
            <div v-show="List.length!=0">

            <Waterfall :list="List" v-bind="options" >
                <template #item="{ item  }" >
                    <div  class="cardset"  >
                        <div style="padding: 2%;" @click="handleClickList(item)">
                            <img :src="item.com_firstImage" class="commodity-img" />
                            <!-- <LazyImg :url="item.com_firstImage" /> -->
                        </div>
                        <div>
                            
                            <el-row justify="space-between" > 
                                    <el-col :span="16" :push="2">
                                        <el-text  style="font-size: large;font-weight:500;color: black;">
                                        {{ item.com_name }}
                                        </el-text>
                                    </el-col>
                                    <el-col :span="4" :pull="2" style="display: flex;justify-content: center;align-items: center;padding-bottom: 4px;">
                                        <el-button type="warning" :icon="item.favor_state? StarFilled:Star" circle @click="favorClick(item)" size="small" />
                                    </el-col>
                            </el-row>
                            <!-- <el-divider></el-divider> -->
                            <el-row justify="space-between" style="margin-top: 10px;">
                                <el-col :span="14" :push="2">
                                    <el-text style="color: rgb(254, 7, 7);font-size:x-large; font-weight: bold;">¥ {{ item.com_price }}</el-text >
                                    <el-text style="text-decoration:line-through;font-size: medium; margin-left: 10px; color: grey;" >¥ {{ item.com_oriPrice }}</el-text>
                                </el-col>

                                <!-- <el-col :span="8">
                                    <el-link  style="font-size:x-small; display: inline-block; vertical-align::bottom"> {{ item.sto_name }}</el-link>
                                    
                                </el-col>  -->
                                
                            </el-row>
                            
                            <el-row justify="space-between" style="margin-top: 15px; padding-bottom: 10px">
                                <el-col :span="8" :push="1">
                                    
                                    <el-text v-if="item.com_status==0" style="color:red;border: solid 1px ; padding: 2px;">售罄</el-text>
                                    <el-text v-else-if="item.com_left<=5"  style="color:red;border: solid 1px ; padding: 2px;"> 库存紧张</el-text>
                                </el-col>
                                <el-col  :span="14" >
                                    <el-text :style="{ color: item.com_color } " style="border: solid 1px ; padding: 2px;" >
                                    下架倒计时：{{ item.dayDiff }}天  
                                    </el-text>
                                </el-col>
                                
                            </el-row>
                       
                        </div>
                    </div>
                </template>
            </Waterfall>
                    <!-- 分页组件 -->
            <el-pagination 
                v-model:current-page="queryInfo.pagenum" 
                :page-size="queryInfo.pagesize" 
                layout="total, prev, pager, next, jumper"
                :total="queryInfo.total" 
                @current-change="handleCurrentChange"
            >
            </el-pagination>
            </div>
        </div>
    </el-card>
    </el-col>
    </el-row>
</template>
<script setup lang="ts">
interface Commodity_tab {
  com_id: number;
  com_name: string;
  com_introduction: string;
  com_oriPrice: number;
  com_expirationDate: string;
  com_uploadDate: string;
  com_left: number;
  com_rating: number;
  sto_name: string;
  sto_id: number;
  com_categories: string[];
  com_firstImage:string;
  com_price:number;
  favor_state:number;
  com_status:number;
  com_color:string;// 显示的颜色
  dayDiff:number;// 距离过期的时间/天
}

interface carousel_item{
    image:string,
    id,
    type:number,// 0 商品 1 商家
    commdation:string
}

const options = reactive({
     // WaterFall属性设置
    hasAroundGutter: true,
    gutter:10,
    lazyload: true,
    //backgroundColor:'#c7edf5',
    //width:'250px',
    breakpoints: {
        1200: { //当屏幕宽度小于等于1200
            rowPerView: 4,
        },
        800: { //当屏幕宽度小于等于800
            rowPerView: 3,
        },
        500: { //当屏幕宽度小于等于500
            rowPerView: 2,
        }
    },
})

import { ref, reactive, onMounted,computed, watchEffect,onDeactivated, onActivated} from 'vue';
import { Waterfall } from "vue-waterfall-plugin-next";
import  baseURL  from "../../../../router/baseURL.js";
import  baseURL_obs  from "../../../../router/baseURL.js";

import {store}from '../../../../router/store'
import "vue-waterfall-plugin-next/dist/style.css";
import axios from 'axios';
import {  useRouter } from 'vue-router'
import {
  Star,
  StarFilled
} from '@element-plus/icons-vue'

const router = useRouter();
const loading=ref(false);
const car_loading=ref(false);
const user_id=ref();

const display_str=ref("");//用于错误提示

const TagArr=ref<Array<{
    tag:string,
    checked:boolean
}>>([]);//全部标签
const TagSelected=computed(()=>{
    let arr=Array<string>()
    TagArr.value.forEach(item =>{
        if(item.checked){
            arr.push(item.tag)
        }
    })
    return arr;
});//被选中的标签


watchEffect(onSearchCom)

const List=reactive<Array<Commodity_tab>>([]);//展示的列表

const queryInfo=reactive({
    pagenum: 1,//当前页码
    pagesize:10,//每页显示条数
    total:0,//共计条目数
    type:"商品", //暂时只能查看商品，这里不动
    categories:[] as Array<string>
})

const carousel=ref<Array<carousel_item>>([]);

onMounted(()=>{
    user_id.value=sessionStorage.getItem("cus_id")
    console.log("user_id.value:"+user_id.value);

    // 首先获得轮播图信息、全部标签和无筛推荐列表

    // 轮播图信息
    car_loading.value=true
    // 最新开业商家
    
    axios.post(
            '/api/cus/search/storeList',
              JSON.stringify({
                cus_id:user_id.value,
                search_str:"",
                com_categories:[],
                begin_pos:0,
                end_pos:queryInfo.pagesize,
                sort_order: 2,
              }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }).then((response)=>{
            console.log('按开业时间排序的商家列表为',response.data.sto_list);
            let new_sto= response.data.sto_list[0]
            let carousel_item :carousel_item={
                image: '',
                id: undefined,
                type: 0,
                commdation: ''
            };
            carousel_item.image=baseURL_obs+new_sto.sto_firstImage;
            carousel_item.id=new_sto.sto_id;
            carousel_item.type=1;
            carousel_item.commdation="最新开业："+new_sto.sto_name;
            carousel.value?.push(carousel_item)
            car_loading.value=false
        }).catch(error => {
            console.error('最新商家拉取失败', error);
            display_str.value='最新商家拉取失败'
        })

    // 最热门商家
    axios.post(
            '/api/cus/search/storeList',
              JSON.stringify({
                cus_id:user_id.value,
                search_str:"",
                com_categories:[],
                begin_pos:0,
                end_pos:queryInfo.pagesize,
                sort_order: 0,
              }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }).then((response)=>{
            console.log('最热门的商家列表为',response.data.sto_list);
            let new_sto= response.data.sto_list[0]
            let carousel_item :carousel_item={
                image: '',
                id: undefined,
                type: 0,
                commdation: ''
            };
            carousel_item.image=baseURL_obs+new_sto.sto_firstImage;
            carousel_item.id=new_sto.sto_id;
            carousel_item.type=1;
            carousel_item.commdation="最热门商家："+new_sto.sto_name;
            carousel.value?.push(carousel_item)
            car_loading.value=false
        }).catch(error => {
            console.error('最热门商家拉取失败', error);
            display_str.value='最热门商家拉取失败'
        })

    // 最受好评商品
    axios.post(
        '/api/cus/search/commodityList',
            JSON.stringify({
            cus_id: user_id.value,
            search_str:"",
            sort_order: 0,
            com_categories:[],
            begin_pos:0,
            end_pos:queryInfo.pagesize
            }), {
        headers: {
            'Content-Type': 'application/json'
        }
    }).then((response)=>{
        console.log('最受好评的商品列表为',response.data.com_list);
        let new_com= response.data.com_list[0]
        let carousel_item :carousel_item={
            image: '',
            id: undefined,
            type: 0,
            commdation: ''
        };
        carousel_item.image=baseURL_obs+new_com.com_firstImage;
        carousel_item.id=new_com.com_id;
        carousel_item.type=0;
        carousel_item.commdation="最受好评商品："+new_com.com_name;
        carousel.value?.push(carousel_item)
        car_loading.value=false
    }).catch(error => {
        console.error('最受好评商品拉取失败', error);
        display_str.value='最受好评商品拉取失败'
    })
    
    

    //无筛推荐列表
    loading.value=true;
    axios.post( '/api/cus/search/commodityList',
            JSON.stringify({
                cus_id: user_id.value,
                search_str: '',
                sort_order: 4,
                com_categories:[],
                begin_pos:0,
                end_pos:queryInfo.pagesize
                
            }), {
                headers: {
                    'Content-Type': 'application/json'
                }
        }).then(response => {
            if("msg" in response.data){
                queryInfo.type="商品";
                console.log(response.data.msg)
                display_str.value=response.data.msg
                List.splice(0,List.length);
            }
            else if( response.data.com_list.length==0){
                queryInfo.type="商品";
                console.log('结果为空')
                display_str.value='结果为空'
                List.splice(0,List.length);
            }
            else{
                console.log('列表为',response.data.com_list);
                queryInfo.total=response.data.total;
                //queryInfo.type="商品";
                //queryInfo.categories=[];

                var len=List.length;
                List.splice(0,len+1, ...response.data.com_list)
                //处理商品颜色
                List.forEach((item)=>{
                    var expirationDate = new Date(item.com_expirationDate.replace(/-/g,"/"));
                    var dateNow = new Date();
                    var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
                    var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向下取整
                    if(dayDiff<1)
                        item.com_color="red";
                    else if(dayDiff<3)
                        item.com_color="#e67300";
                    else if(dayDiff<7)
                        item.com_color="#b88230";
                    else
                        item.com_color="green";
                    //设置显示颜色
                
                    item.dayDiff=dayDiff
                    //设置距离过期相差天数
                    item.com_firstImage=baseURL_obs+item.com_firstImage;
                    //设置图片相对路径
                })
            }
        }).catch(error => {
                console.error('搜索失败', error);
                display_str.value='搜索失败'
        }).finally(()=>{
                loading.value=false;
        });


    // 全部标签
    axios.get('/api/cus/search/categories')
    .then((res)=>{
        for(let item of res.data.com_categories as Array<string> ){
            TagArr.value.push({
                tag:item,
                checked:false
            })
        }
        console.log(TagArr.value)
    })
    .catch(()=>{
        console.log('标签数组请求失败')
    })
})

onActivated(()=>{
    store.activePath='/home/recommendation'
})

onDeactivated(()=>{
    axios.post('/api/cus/recommendation',
    {
        user_id:user_id.value as string
    }).then(res=>{
        console.log('推荐算法启动成功',res)
    }).catch(()=>{
        console.log('推荐算法启动失败')
    })
})

function checkChange(item){
    console.log(item.checked)
}

function onSearchCom(){
    console.log(TagSelected.value)
    loading.value=true;
    axios.post(
        '/api/cus/search/commodityList',
        JSON.stringify({
            cus_id: user_id.value,
            search_str: "",
            sort_order: 4,
            com_categories:TagSelected.value,
            begin_pos:0,
            end_pos:queryInfo.pagesize
            
        }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(response => {
        if("msg" in response.data){
            queryInfo.type="商品";
            console.log(response.data.msg)
            display_str.value=response.data.msg
            List.splice(0,List.length);
        }
        else if( response.data.com_list.length==0){
            queryInfo.type="商品";
            console.log('结果为空')
            display_str.value='搜索结果为空'
            List.splice(0,List.length);
            queryInfo.pagenum=1;
            queryInfo.total=response.data.total;
        }
        else{
            console.log('列表为',response.data);
            queryInfo.pagenum=1;
            queryInfo.total=response.data.total;

            var len=List.length;
            List.splice(0,len+1, ...response.data.com_list)
            //处理商品颜色
            List.forEach((item)=>{
                var expirationDate = new Date(item.com_expirationDate.replace(/-/g,"/"));
                var dateNow = new Date();
                var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
                var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向下取整
                if(dayDiff<1)
                    item.com_color="red";
                else if(dayDiff<3)
                    item.com_color="#e67300";
                else if(dayDiff<7)
                    item.com_color="#b88230";
                else
                    item.com_color="green";
                //设置显示颜色
            
                item.dayDiff=dayDiff
                //设置距离过期相差天数
                item.com_firstImage=baseURL_obs+item.com_firstImage;
                //设置图片相对路径
            })
        }
    }).catch(error => {
            console.error('搜索失败', error);
            display_str.value='搜索失败'
    }).finally(()=>{
            loading.value=false;
    });
}



function carNav(item:carousel_item){
    if(item.type===0){
        //点击商品
        router.push({ 
           path: '/home/commodityDetail', 
           query: { com_id: item.id ,cus_id:user_id.value } 
       })
    }
    else{
        //点击商家
        router.push({ 
           path: '/storeDetail', 
           query: { sto_id: item.id ,cus_id:user_id.value} 
       })
    }

}

function handleClickList(item){
    console.log(item)
    console.log("user_id.value:"+user_id.value)
    router.push({ 
        path: '/home/commodityDetail', 
        query: { com_id: item.com_id ,cus_id:user_id.value } 
    })
}

function favorClick(item:Commodity_tab){
    console.log("点击收藏按钮") 
    item.favor_state==1?item.favor_state=0:item.favor_state=1
    axios.post(
        '/api/cus/favorite/setFavorState',
        JSON.stringify({
            com_id:item.com_id,
            cus_id:user_id.value,
            //此处指定收藏的用户，后续更改
            favor_state: item.favor_state
        }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(res =>{
        console.log(res.data.msg)
    }).catch(error => {
        console.error('收藏请求失败', error);
        item.favor_state==1?item.favor_state=0:item.favor_state=1
    });
}

function handleCurrentChange(){
    console.log('分页信息：',JSON.stringify({
                com_categories:TagSelected.value,
                begin_pos:queryInfo.pagesize*(queryInfo.pagenum-1),
                end_pos:queryInfo.pagesize*queryInfo.pagenum
              }))
    
    loading.value=true;
    //触发axios
    axios.post(
    '/api/cus/search/commodityList',
    JSON.stringify({
        cus_id: user_id.value,
        search_str: "",
        sort_order: 4,
        com_categories:TagSelected.value,
        begin_pos:queryInfo.pagesize*(queryInfo.pagenum-1),
        end_pos:queryInfo.pagesize*queryInfo.pagenum
    }), {
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response=>{
        console.log('列表为',response.data.com_list);
        var len=List.length;
        List.splice(0,len+1, ...response.data.com_list)
        //处理商品颜色
        List.forEach((item)=>{
            var expirationDate = new Date(item.com_expirationDate.replace(/-/g,"/"));
            var dateNow = new Date();
            var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
            var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向下取整
            if(dayDiff<1)
                item.com_color="red";
            else if(dayDiff<3)
                    item.com_color="#e67300";
                else if(dayDiff<7)
                    item.com_color="#b88230";
                else
                    item.com_color="green";
            //设置显示颜色
        
            item.dayDiff=dayDiff
            //设置距离过期相差天数
            item.com_firstImage=baseURL_obs+item.com_firstImage;
            //设置图片相对路径
        })
    }).catch(error => {
        console.error('分页失败', error);
        display_str.value='分页失败'
    }).finally(()=>{
        loading.value=false;
    });
            
        
}

</script>
<style scoped>

el-image{
  padding: 0 5px;
  max-width: 300px;
  width: 100%;
  height: 200px;  
}

.image-slot {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: var(--el-fill-color-light);
  color: var(--el-text-color-secondary);
  font-size: 30px;
}

.cardset{
    background-color: #fef0f0;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
    border: 0.1px solid #81bbc7;
    border-radius: 2%;
    
}

.commodity-img {
    width: 100%;
    height: 200px;
    object-fit: contain;
  }

.comName{
    font-size:x-large;
}
</style>