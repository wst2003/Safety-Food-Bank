<template>
    <el-row>
    <el-col :span="16" :offset="4">
    <el-card>
      
        <el-tabs 
            v-model="activeName"  
            @tab-click="handleClick"  
            type="card"
            @clear="handleClear"
        >
            <el-tab-pane label="商品" name="商品">
                <el-row justify="space-between">
                    <el-col :span="21">
                        <el-input v-model="search_str" placeholder="输入你想搜索的商品" clearable>
                            <template #prefix>
                            <el-select
                                    v-model="TagSelected"
                                    multiple
                                    collapse-tags
                                    collapse-tags-tooltip
                                    placeholder="选择标签"
                                    style="width: 150px"
                                    tag-type="success"
                                >
                                    <el-option
                                        v-for="item in TagArr"
                                        :key="item"
                                        :value="item"
                                    />
                                </el-select>
                            </template>
                            <!-- <template #append>
                                <el-button @click="onSearchCom" type="danger"><el-icon><search/></el-icon> </el-button>
                            </template> -->
                        </el-input>
                    </el-col>
                    <el-col :span="2">
                        <el-button @click="onSearchCom" type="danger"><el-icon><search/></el-icon> </el-button>
                    </el-col>
                </el-row>
            </el-tab-pane>
            <el-tab-pane label="商店" name="商店">
                <div id="baiduMap" style="width:100%; height: 300px; margin-top:10px;"></div>
                <el-row justify="space-between" style="margin-top: 5px;">
                    <el-col :span="21">
                        <el-input v-model="search_str" placeholder="输入你想搜索的商店" clearable>
                            
                            <template #prefix>
                                <el-select
                                    v-model="TagSelected"
                                    multiple
                                    collapse-tags
                                    collapse-tags-tooltip
                                    placeholder="选择标签"
                                    style="width: 150px"
                                    tag-type="success"
                                >
                                    <el-option
                                        v-for="item in TagArr"
                                        :key="item"
                                        :value="item"
                                    />
                                </el-select>
                            </template>
                            <!--<template #append>
                                <el-button @click="onSearchSto" type="danger"><el-icon><search/></el-icon> </el-button>
                            </template>-->
                        </el-input>
                    </el-col>
                    <el-col :span="2">
                        <el-button @click="onSearchSto" type="danger"><el-icon><search/></el-icon> </el-button>
                    </el-col>
                </el-row>
            </el-tab-pane>
        </el-tabs>

    </el-card>
    <el-divider />
    <el-card >
        <div >
        <el-row justify="space-between">
            <el-col :span="8">

                    <el-text>当前应用筛选：</el-text>
                    <el-text v-if="queryInfo.categories.length==0"> 无</el-text>
                    <el-tag 
                        v-for="cate in queryInfo.categories"
                        :key="cate"
                        type="danger"
                    >{{ cate }}</el-tag>      
            </el-col>
            <el-col :span="12">
                <div style="display: flex;justify-content: end;">
                <el-text>排序方式：</el-text>
                    <el-select
                        v-model="sortSelected"
                        placeholder="选择排序方式"
                        style="width: 250px;"
                        @change="sortChange"
                        >
                        <el-option
                            v-for="item in sortList"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value"
                        />
                    </el-select>
                </div>
            </el-col>
        </el-row>
        </div>
        <el-divider/>
        <div v-loading="loading">
            <div style="display: flex;justify-content: center;align-items: center;" v-show="List.length==0">
                <h1 class="bg-gray-900">{{ display_str }}</h1>
            </div>
            <div v-show="List.length!=0">

            <Waterfall :list="List" v-bind="options" v-if="listIsCom" >
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
            <Waterfall :list="List" v-bind="options" v-if="!listIsCom">
                <template #item="{ item  }" >
                    <div @click="handleClickList(item)" class="cardset">
                        <div style="padding: 2%;">
                            <img :src="item.sto_firstImage" class="commodity-img" />
                            <!-- <LazyImg :url="item.sto_firstImage"   /> -->
                        </div>
                        <div>
                            <el-row justify="center" > 
                                    <el-text  class="comName" >
                                    {{ item.sto_name }}
                                    </el-text>
                            </el-row>
                            <el-divider></el-divider>
                            <el-row>
                                <el-col :span="16" :offset="2">
                                <el-tag v-for="(tag, index) in item.com_categories" :key="index" type="danger">{{ tag }}</el-tag>
                                </el-col>
                            </el-row>
                            <br />
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
import { TabsPaneContext } from 'element-plus/es/components/tabs/src/constants';
import { ref, reactive, onMounted,watch, onActivated} from 'vue';
import { Waterfall } from "vue-waterfall-plugin-next";
import  baseURL  from "../../../../router/baseURL.js";
import {store}from '../../../../router/store'
import "vue-waterfall-plugin-next/dist/style.css";
import axios from 'axios';
import {  useRouter ,useRoute} from 'vue-router'
import {
  Star,
  StarFilled
} from '@element-plus/icons-vue'

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
}

//引入百度地图
/* eslint-disable */
let map: BMapGL.Map;
/* eslint-disable */
let geoc: BMapGL.Geocoder;

const user_address = ref('');
const router = useRouter()
const route = useRoute()

const display_str=ref("");

const TagArr=ref(Array<string>());//全部标签
const TagSelected=ref(Array<string>());//被选中的标签

const loading=ref(false)

const sortCom=[
    {label:"按评分排序",value:0},
    {label: "按地理位置远近排序",value:1},
    {label: "按到期日期排序",value:2},
    {label: "按价格排序",value:3},
];
const sortSto=[
    {label:"按热度排序",value:0},
    {label: "按地理位置远近排序",value:1}
];
const sortList=ref(Array<{label:string,value:number}>()); 
const sortSelected=ref(0); 

const listIsCom=ref(true);
const List=reactive(Array<object>() );
const activeName=ref("商品");
const search_str=ref("");

const user_id=ref();
const queryInfo=reactive({
    pagenum: 1,//当前页码
    pagesize:10,//每页显示条数
    total:0,//共计条目数
    type:"商品",
    query:"",
    categories:Array<string>()
})

const nearestShops = ref([]);

watch(()=>queryInfo.type,()=>{
    if(queryInfo.type=="商品"){
        sortList.value=sortCom;
        sortSelected.value=0;
    }else{
        sortList.value=sortSto;
        sortSelected.value=0;
    }
})
watch(activeName,()=>{
    if(List.length==0){
        if(activeName.value=="商品"){
            sortList.value=sortCom;
            sortSelected.value=0;
        }else{
            sortList.value=sortSto;
            sortSelected.value=0;
        }
    }
})

const options = reactive({
     // 是否有周围的gutter 
    hasAroundGutter: true,
    gutter:10,
    lazyload: true
})

onMounted(()=>{
    console.log("route.query.user_id"+route.query.user_id)
    user_id.value=sessionStorage.getItem("cus_id")
    console.log("user_id.value:"+user_id.value);
    sortList.value=sortCom;

    axios.get(baseURL+'/api/pub/information/user', { params: {user_ID: String(user_id.value) } })
    .then((res) => {
        user_address.value = res.data.user_address;
        console.log(user_address.value);

        map = new BMapGL.Map("baiduMap"); 
        geoc = new BMapGL.Geocoder();
        const point = new BMapGL.Point(116.404, 39.915);  
        map.centerAndZoom(point, 15);                     
        map.enableScrollWheelZoom(true);                  

        const myGeo = new BMapGL.Geocoder();
        myGeo.getPoint(user_address.value, function(point) {
            if (point) {
                map.centerAndZoom(point, 16);
                map.addOverlay(new BMapGL.Marker(point));
            } else {
                alert("您选择地址没有解析到结果!");
            }
        });
    })
    .catch(() => {
        console.log('用户地址请求失败')
    });

    axios.get(baseURL+'/api/cus/search/categories')
    .then((res)=>{
        TagArr.value= res.data.com_categories as Array<string>
        console.log(TagArr.value)
    })
    .catch(()=>{
        console.log('标签数组请求失败')
    })
})

onActivated(()=>{
    store.activePath='/home/search'
})

function sortChange(value:number){
    console.log(value)
    queryInfo.pagenum=1;
    if(List.length>0){
        loading.value=true;
        //当前列表中有内容时，触发axios
        if(queryInfo.type=="商品"){
            axios.post(
            baseURL+'/api/cus/search/commodityList',
            JSON.stringify({
                cus_id: user_id.value,
                search_str: queryInfo.query,
                sort_order: sortSelected.value,
                com_categories:queryInfo.categories,
                begin_pos:0,
                end_pos:queryInfo.pagesize
                
            }), {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then(response=>{
                console.log('列表为',response.data.com_list);
                queryInfo.pagenum=1;
                queryInfo.total = response.data.total;
                var len=List.length;
                List.splice(0,len+1, ...response.data.com_list)
                //处理商品颜色
                List.forEach((item)=>{
                    var expirationDate = new Date(item.com_expirationDate.replace(/-/g,"/"));
                    var dateNow = new Date();
                    var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
                    var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向上取整
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
                    item.com_firstImage=baseURL+'/'+item.com_firstImage;
                    //设置图片相对路径
                })
                
            }).catch(error => {
                console.error('排序失败', error);
                display_str.value='排序失败'
            }).finally(()=>{
                loading.value=false;
            });
            
        }
        else{
            axios.post(
            baseURL+'/api/cus/search/storeList',
              JSON.stringify({
                cus_id:user_id.value,
                search_str: queryInfo.query,
                com_categories:TagSelected.value,
                begin_pos:0,
                end_pos:queryInfo.pagesize,
                sort_order: sortSelected.value,
              }), {
            headers: {
                'Content-Type': 'application/json'
            }
          }
        ).then(response => {
            console.log('列表为',response.data)
                queryInfo.pagenum=1;
                queryInfo.total = response.data.total;
                var len=List.length;
                List.splice(0,len+1, ...response.data.sto_list)
                List.forEach((item)=>{
                    item.sto_firstImage = baseURL+"/"+item.sto_firstImage;
                })
        })
        .catch(error => {
            console.error('排序失败', error);
            display_str.value='排序失败'
        }).finally(()=>{
                loading.value=false;
            });
        }
    }
}

function handleCurrentChange(){
    console.log(JSON.stringify({
                search_str: queryInfo.query,
                com_categories:TagSelected.value,
                begin_pos:queryInfo.pagesize*(queryInfo.pagenum-1),
                end_pos:queryInfo.pagesize*queryInfo.pagenum,
                sort_order: sortSelected.value,
              }))
    
    loading.value=true;
    //触发axios
    if(queryInfo.type=="商品"){
            axios.post(
            baseURL+'/api/cus/search/commodityList',
            JSON.stringify({
                cus_id: user_id.value,
                search_str: queryInfo.query,
                sort_order: sortSelected.value,
                com_categories:queryInfo.categories,
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
                    item.com_firstImage=baseURL+'/'+item.com_firstImage;
                    //设置图片相对路径
                })
            }).catch(error => {
                console.error('分页失败', error);
                display_str.value='分页失败'
            }).finally(()=>{
                loading.value=false;
            });
            
        }
        else{
            axios.post(
            baseURL+'/api/cus/search/storeList',
              JSON.stringify({
                cus_id:user_id.value,
                search_str: queryInfo.query,
                com_categories:TagSelected.value,
                begin_pos:queryInfo.pagesize*(queryInfo.pagenum-1),
                end_pos:queryInfo.pagesize*queryInfo.pagenum,
                sort_order: sortSelected.value,
              }), {
            headers: {
                'Content-Type': 'application/json'
            }
          }
        ).then(response => {
            console.log('列表为',response.data)
            var len=List.length;
            List.splice(0,len+1, ...response.data.sto_list)

            List.forEach((item)=>{
                item.sto_firstImage=
                    
                    baseURL+"/"
                    +item.sto_firstImage;
                // item.com_list.forEach((item)=>{
                //     item.com_firstImage=
                    
                //     baseURL+"/"
                //     +item.com_firstImage;
                // })
            })
        })
        .catch(error => {
            console.error('分页失败', error);
            display_str.value='分页失败'
        }).finally(()=>{
                loading.value=false;
        });
        }

}

function handleClickList(item){
   
   if(listIsCom.value){
       //点击商品
       console.log(item)
       console.log("user_id.value:"+user_id.value)
       router.push({ 
           path: '/home/commodityDetail', 
           query: { com_id: item.com_id ,cus_id:user_id.value } 
       })
   }
   else{
       //点击商家
       console.log(item)
       router.push({ 
           path: '/storeDetail', 
           query: { sto_id: item.sto_id ,cus_id:user_id.value} 
       })
   }
}
function favorClick(item:Commodity_tab){
    console.log("点击收藏按钮") 
    
    item.favor_state==1?item.favor_state=0:item.favor_state=1
    axios.post(
        baseURL+'/api/cus/favorite/setFavorState',
       
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
const handleClick = (tab: TabsPaneContext, event: Event) => {
  console.log(activeName.value); 
    //切换标签
}
function onSearchCom(){
    console.log("搜索内容为：",search_str.value);
    if(search_str.value.length!=0||TagSelected.value.length!=0){
        listIsCom.value=true;
        loading.value=true;
        axios.post(
            baseURL+'/api/cus/search/commodityList',
            JSON.stringify({
                cus_id: user_id.value,
                search_str: search_str.value,
                sort_order: sortSelected.value,
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
                console.log('列表为',response.data.com_list);
                queryInfo.pagenum=1;
                queryInfo.total=response.data.total;
                queryInfo.type="商品";
                queryInfo.categories=TagSelected.value;
                queryInfo.query=search_str.value;

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
                    item.com_firstImage=baseURL+'/'+item.com_firstImage;
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
}

/*在地图上标记商店*/
function markShopsOnMap(shops) {
    // 清除之前的标记.
    map.clearOverlays();
                               
    const myGeo = new BMapGL.Geocoder();
    myGeo.getPoint(user_address.value, function(userPoint) {
        if (userPoint) {
            const marker = new BMapGL.Marker(userPoint);
            map.addOverlay(marker);
            map.centerAndZoom(userPoint, 16);
            shops.forEach(shop => {
            myGeo.getPoint(shop.user_address, function(shopPoint) {
                if (shopPoint) {
                    const distance = map.getDistance(userPoint, shopPoint).toFixed(2);
                    const marker = new BMapGL.Marker(shopPoint);
                    map.addOverlay(marker);
                    // 给标记添加点击事件
                    marker.addEventListener("click", () => {
                        const infoWindow = new BMapGL.InfoWindow(`
                            <div>
                                <h4>${shop.sto_name}</h4>
                                <p>${shop.user_address}</p>
                                <p>${shop.sto_introduction}</p>
                                <p>距离您：${distance}米</p>
                            </div>
                        `);
                        map.openInfoWindow(infoWindow, shopPoint);
                    });
                }
            });
        });
        } else {
            alert("您的地址没有解析到结果!");
        }
    });
}


function onSearchSto(){
    queryInfo.pagenum=1;
    console.log("搜索内容为：",search_str.value);
    if(search_str.value.length!=0||TagSelected.value.length!=0){
        loading.value=true;
        listIsCom.value=false;
        axios.post(
            baseURL+'/api/cus/search/storeList',
              JSON.stringify({
                cus_id:user_id.value,
                search_str: search_str.value,
                com_categories:TagSelected.value,
                begin_pos:0,
                end_pos:queryInfo.pagesize,
                sort_order: sortSelected.value,
              }), {
            headers: {
                'Content-Type': 'application/json'
            }
          }
        ).then(response => {
            if("msg" in response.data){
                queryInfo.type="商店";
                console.log(response.data.msg)
                display_str.value=response.data.msg
                List.splice(0,List.length);
            }
            else if( response.data.sto_list.length==0){
                queryInfo.type="商店";
                console.log('结果为空')
                display_str.value='搜索结果为空'
                List.splice(0,List.length);
                queryInfo.pagenum=1;
                queryInfo.total=response.data.total;
            }
            else{
                console.log('列表为',response.data)

                markShopsOnMap(response.data.sto_list);

                queryInfo.pagenum=1;
                queryInfo.total=response.data.total;
                queryInfo.type="商店";
                queryInfo.categories=TagSelected.value;
                queryInfo.query=search_str.value;
                var len=List.length;
                List.splice(0,len+1, ...response.data.sto_list)

                List.forEach((item)=>{
                    item.sto_firstImage=
                        baseURL+"/"
                        +item.sto_firstImage;
                    // item.com_list.forEach((item)=>{
                    //     item.com_firstImage=
                      
                    //    baseURL+"/"
                    //     +item.com_firstImage;
                    // })
                })
            }
        })
        .catch(error => {
            console.error('搜索失败', error);
            display_str.value='搜索失败'
        }).finally(()=>{
                loading.value=false;
        });
    }
}
function handleClear(){
    search_str.value="";
    console.log(search_str.value);
}
</script>
<style scoped>
.cardset{
    background-color: #fef0f0;
    border-radius:4%
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