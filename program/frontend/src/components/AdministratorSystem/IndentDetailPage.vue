<template>
    <el-row>
 <el-page-header :icon="ArrowLeft" title="返回" @back="goBack" >
   <template #content>
     <span class="text-large font-600 mr-3"> 商品详情 </span>
   </template>
 </el-page-header>
 
 </el-row>
   <el-row :gutter="20">
     <el-col :span="6">
   <el-card>
 <div class="demo-image__lazy">
     <!-- <el-image v-for="url in urls" :key="url" :src="url" lazy /> -->
     <div style="display: flex; align-items: center">
           <el-image
             style="width: 300px; height: 300px"
             :src="url"
             :zoom-rate="1.2"
             :preview-src-list="srcList"
             :initial-index="0"
             fit="fill"
           />
         </div>
 </div>
 </el-card>
 </el-col>
 
 <el-col :span="18">
 <el-card>
   <div id="main" :style="{ width: '1000px', height: '300px' }"></div>
 </el-card>
 </el-col>
 </el-row>
 
 <el-row :gutter="20">
 <el-col :span="10">
 <!-- <el-card> -->
 
   <el-row :gutter="20">
     <el-col :span="12">
     <el-card>
       <div class="secondLine">
       <el-result
         :icon="resultIcon"
         :title="resultTitle"
       />
 
    <div class="countdown-footer">{{ timeValue.format('YYYY-MM-DD') }}</div>
    </div>
   </el-card>
 </el-col>
 
 <el-col :span="12">
   <el-card>
     <div class="secondLine">
    <div class="statistic-card">
         <el-statistic :value="rating" :precision="3">
           <template #title>
             <div style="display: inline-flex; align-items: center; font-size: 13px;">
               商品评分
               <el-tooltip
                 effect="dark"
                 content="该商品目前的评分以及评分的变化情况"
                 placement="top"
               >
                 <el-icon style="margin-left: 4px" :size="12">
                   <Warning />
                 </el-icon>
               </el-tooltip>
             </div>
           </template>
         </el-statistic>
         <div class="statistic-footer">
           <div class="footer-item">
             <span>与昨日相比</span>
             <span class="green">
               24%
               <el-icon>
                 <CaretTop />
               </el-icon>
             </span>
           </div>
         </div>
       </div>
       </div>
     </el-card>
   </el-col>
     </el-row>
 
     <el-row :gutter="20">
     <el-col :span="12">
     <el-card>
       <div class="secondLine">
   <el-countdown format="DD [天] HH:mm:ss" :value="timeValue.add(1,'day')">
         <template #title>
           <div class="cutdownStyle">
             <el-icon style="margin-right: 4px" :size="12">
               <Calendar />
               
             </el-icon>
             商品剩余保质期
           </div>
           
         </template>
       </el-countdown>
 
    <div class="countdown-footer">{{ timeValue.format('YYYY-MM-DD') }}</div>
    </div>
   </el-card>
 </el-col>
 
 <el-col :span="12">
   <el-card>
     <div class="secondLine">
    <div class="statistic-card">
         <el-statistic :value="left">
           <template #title>
             <div style="display: inline-flex; align-items: center; font-size: 13px;">
               商品余量
               <el-tooltip
                 effect="dark"
                 content="该商品目前的余量以及余量的变化情况"
                 placement="top"
               >
                 <el-icon style="margin-left: 4px" :size="12">
                   <Warning />
                 </el-icon>
               </el-tooltip>
             </div>
           </template>
         </el-statistic>
         <div class="statistic-footer">
           <div class="footer-item">
             <span>与昨日相比</span>
             <span class="red">
               -30%
               <el-icon>
                 <CaretBottom />
               </el-icon>
             </span>
           </div>
         </div>
       </div>
       </div>
     </el-card>
   </el-col>
     </el-row>
 
 
   <!-- </el-card> -->
 </el-col>
 
 <el-col :span="14">
 <el-card>
   <div class="descriptions">
 <el-row>
   <el-descriptions
     class="margin-top"
     :column="3"
     :size="size"
     border
   >
 
   <el-descriptions-item :class-name="id">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <Goods />
           </el-icon>
           商品ID
         </div>
       </template>
       <el-tag>{{ id }}</el-tag>
     </el-descriptions-item>
 
     <el-descriptions-item :class-name="name">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <Goods />
           </el-icon>
           商品名称
         </div>
       </template>
       <div class="textStyle">{{ name }}</div>
     </el-descriptions-item>
     <el-descriptions-item :class-name="oriprice">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <Coin />
           </el-icon>
           商品原价 /元
         </div>
       </template>
       <el-tag>{{ oriprice}}</el-tag>
     </el-descriptions-item>
     <el-descriptions-item :class-name="uploaddate">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <Timer />
           </el-icon>
           商品上传日期
         </div>
       </template>
       <el-tag>{{ uploaddate }}</el-tag>
     </el-descriptions-item>
 
     <el-descriptions-item :class-name="expirationdate">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <AlarmClock />
           </el-icon>
           商品预计过期日期
         </div>
       </template>
       <el-tag>{{ expirationdate }}</el-tag>
     </el-descriptions-item>
 
     <el-descriptions-item>
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <tickets />
           </el-icon>
           商品类别
         </div>
       </template>
       <el-tag class="desTag" size="small" v-for="item in categories" :key="item">{{ item }}</el-tag>
       <!-- <el-descriptions-item v-for="(item, key) in items" :key="key" :label="item.key">
         <template v-slot>
           <span>{{ item.val }}</span>
         </template>
       </el-descriptions-item> -->
     </el-descriptions-item>
     <el-descriptions-item :class-name="introduction">
       <template #label>
         <div class="cell-item">
           <el-icon :style="iconStyle">
             <office-building />
           </el-icon>
           商品简介
         </div>
       </template>
       <div class="textStyle">{{ introduction }}</div>
     </el-descriptions-item>
   </el-descriptions>
 </el-row>
 
   </div>
 
   <!-- <el-button>聊天接口</el-button> -->
 </el-card>
 </el-col>
 </el-row>
 
 </template>
 
     
 <script lang="ts" setup>
 import axios from 'axios';
 import { useRouter,useRoute} from 'vue-router';
 import {onMounted, ref,computed} from 'vue'
 import { ArrowLeft } from '@element-plus/icons-vue'
 import dayjs from 'dayjs'
 import * as echarts from 'echarts';
 const com_id=ref('');
 const router=useRouter();
 const route=useRoute();
 const items=ref([
       { key: "Label 1", val: "Description 1" },
       { key: "Label 2", val: "Description 2" },
       // more 
 ]);
 const resultIcon=ref('success');
 const resultTitle=ref('商品正常在售');
 const size=ref('default');
 const iconStyle = computed(() => {
   const marginMap = {
     large: '8px',
     default: '6px',
     small: '4px',
   }
   return {
     marginRight: marginMap[size.value] || marginMap.default,
   }
 })
 import {
 CaretTop,
 Coin,
   Goods,
   Iphone,
   Location,
   OfficeBuilding,
   Tickets,
   User,
 Warning,
 } from '@element-plus/icons-vue'
 
 function change(strr :string[]){
     return strr;
   // var arr :string[]=[];
   //   for(var i=0;i<strr.length;i++)
   //     arr.push(strr[i]);
   //   for(i=0;i<arr.length;i++){
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
   //   return arr;
 }
 
 const url =ref('');
 const srcList=ref([
   ''
 ]);
 
 var myChart;
 
 const data=ref({
     "com_id": 1,
     "com_name": "薯条",
     "com_introduction": "好好好",
     "com_oriprice": 14,
     "com_expirationdate": "2023-10-01",
     "com_uploaddate": "2023-07-20",
     "com_left": 3,
     "com_rating": 0.9,
     "com_categories": [
         "小食"
     ],
     "com_pc_time": [
         "2023-09-01"
     ],
     "com_pc_price": [
         5.6
     ],
     "com_image": [
       ".\\wwwroot\\commodity_image\\2\\com_image_0.png",
     ]
 });
 
 const trans=ref({
     "com_id": "商品ID",
     "com_name": "商品名称",
     "com_introduction": "商品简介",
     "com_oriprice": "商品原价",
     "com_expirationdate": "商品预计过期时间",
     "com_uploaddate": "商品上传时间",
     "com_left": "商品剩余量",
     "com_rating": "商品评级",
     "com_categories": "商品类别",
     "com_pc_time": "价值曲线时间",
     "com_pc_price": "价值曲线价格",
     "com_image": "图片地址"
 })
 
 const name=ref('薯条');
 const oriprice=ref(1.1);
 const uploaddate=ref('2023-07-01')
 const categories=ref(['苹果','面包','饮品']);
 const id=ref(1008611);
 const expirationdate=ref('2023-08-01')
 const introduction=ref('此处省略一万字');
 const rating=ref(7.783);
 const left=ref(666);
 
 const timeValue = ref(dayjs().add(1, 'month').startOf('month'))
 onMounted(()=>{
     com_id.value=route.query.com_id as string; 
     console.log(com_id.value);
     // console.log(trans.value['com_categories']);
     axios.get('/api/sto/StoreQueryCommodity/detail?com_id='+parseInt(com_id.value))
         .then(response => {
 
             console.log('Details Got successfully.');
             const keyValuePairs = Object.entries(JSON.parse(JSON.stringify(response.data)));
             data.value=JSON.parse(JSON.stringify(response.data));
 
             name.value=data.value.com_name;
             oriprice.value=data.value.com_oriprice;
             uploaddate.value=data.value.com_uploaddate;
             categories.value=data.value.com_categories;
             id.value=data.value.com_id;
             expirationdate.value=data.value.com_expirationdate;
             introduction.value=data.value.com_introduction;
             rating.value=data.value.com_rating;
             left.value=data.value.com_left;
             if(data.value.com_pc_time[0]!=data.value.com_uploaddate){
               data.value.com_pc_time.unshift(data.value.com_uploaddate);
               data.value.com_pc_price.unshift(data.value.com_oriprice);
             }
             data.value.com_pc_time.push(dayjs(expirationdate.value).add(1,'day').format('YYYY-MM-DD'))
             data.value.com_pc_price.push(0);
             timeValue.value=dayjs(expirationdate.value);
             if(left.value==0){
               resultIcon.value='error';
               resultTitle.value='商品已售完，请及时补货';
             }
             else{
               resultIcon.value='success';
               resultTitle.value='商品正常在售';
             }
 
            srcList.value=change(data.value.com_image);
            url.value=srcList.value[0];
             console.log(url.value);
 
             myChart=echarts.init(document.getElementById('main'));
             myChart.setOption({
             title: {
               text: '价格历史记录'
             },
             tooltip: {},
             legend: {
               data: ['价格']
             },
             xAxis: {
               data: data.value.com_pc_time
             },
             yAxis: {},
             series: [
               {
                 name: '价格',
                 type: 'line',
                 step: 'end',
                 data: data.value.com_pc_price
               }
             ]
           });
             // items.value = keyValuePairs.map(([key, value]) => ({ key: trans.value[key], val: value as string }));
         })
         .catch((error) => {
             console.log('An error occurred:', error);
         });
 });
 
 const goBack=()=>{
   // history.back();
   router.back();
 }
 </script>
 
 <!-- Add "scoped" attribute to limit CSS to this component only -->
 <style scoped>
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
 
 .descriptions{
   height: 350px;
 }
 .cutdownStyle{
   height: 100%;
   /* padding: 20px; */
   /* margin-top: 25px; */
   font-size: 13px;
   display: flex;
   justify-content: center;
   align-items: center;
   border-radius: 4px;
   background-color: var(--el-bg-color-overlay);
 }
 
 .desTag{
   margin-right: 5px;
 }
 .desTag:last-child{
   margin-right: 0px;
 }
 
 .textStyle{
   display: flex;
   justify-content: center;
 }
 
 .secondLine{
   flex-direction: column;
   height: 145px;
   margin-bottom: 0;
   display: flex;
   justify-content: center;
   align-items: center;
 }
 .el-row {
   margin-bottom: 13px;
 }
 .el-row:last-child {
   margin-bottom: 0;
 }
 .el-descriptions {
   margin-top: 20px;
 }
 .demo-image__lazy {
   width: 300px;
   height: 300px;
   overflow-y: auto;
 }
 .demo-image__lazy .el-image {
   display: block;
   min-height: 200px;
   margin-bottom: 10px;
 }
 .demo-image__lazy .el-image:last-child {
   margin-bottom: 0;
 }
 .box-card {
   width: 1300px;
 }
 
 .percentage-value {
   display: block;
   margin-top: 10px;
   font-size: 28px;
 }
 .percentage-label {
   display: block;
   margin-top: 10px;
   font-size: 12px;
 }
 
 :global(h2#card-usage ~ .example .example-showcase) {
   background-color: var(--el-fill-color) !important;
 }
 
 .el-statistic {
   --el-statistic-content-font-size: 28px;
 }
 .statistic-card {
   height: 100%;
   /* padding: 20px; */
   /* margin-top: 25px; */
   /* margin-left: 180px; */
   border-radius: 4px;
   background-color: var(--el-bg-color-overlay);
   display: flex;
   flex-direction: column;
   justify-content: center;
   align-items: center;
 }
 
 .statistic-footer {
   display: flex;
   justify-content: space-between;
   align-items: center;
   flex-wrap: wrap;
   font-size: 12px;
   color: var(--el-text-color-regular);
   margin-top: 16px;
 }
 
 .statistic-footer .footer-item {
   display: flex;
   justify-content: space-between;
   align-items: center;
 }
 
 .statistic-footer .footer-item span:last-child {
   display: inline-flex;
   align-items: center;
   margin-left: 4px;
 }
 
 .green {
   color: var(--el-color-success);
 }
 .red {
   color: var(--el-color-error);
 }
 
 .countdown-footer {
   margin-top: 8px;
 }
 
 .el-descriptions {
   /* display: flex; */
   margin-top: 20px;
 }
 .cell-item {
   display: flex;
   align-items: center;
   
   height: 50px;
 }
 .margin-top {
   margin-top: 20px;
   margin-bottom: 0px;
   
 }
 </style>
     