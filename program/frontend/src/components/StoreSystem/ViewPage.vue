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
       <!-- <div class="statistic-footer">
         <div class="footer-item">
           <span>与昨日相比</span>
           <span class="green">
             24%
             <el-icon>
               <CaretTop />
             </el-icon>
           </span>
         </div>
       </div> -->
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
       <!-- <div class="statistic-footer">
         <div class="footer-item">
           <span>与昨日相比</span>
           <span class="red">
             -30%
             <el-icon>
               <CaretBottom />
             </el-icon>
           </span>
         </div>
       </div> -->
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
     {{ oriprice}}
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
     <el-tag type="warning">{{ uploaddate }}</el-tag>
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
     <el-tag type="danger">{{ expirationdate }}</el-tag>
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
     <el-tag type="success" class="desTag" size="small" v-for="item in categories" :key="item">{{ item }}</el-tag>
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

 <el-button type="danger" @click="showCmt">评论入口</el-button>
</el-card>
</el-col>
</el-row>



<el-dialog title="商品评论" :modelValue="cmtVisible"  width="90%" @update:modelValue="cmtVisible = $event"
   >


   <el-card>



<!-- <el-collapse v-model="activeNames">
  <el-collapse-item v-for="(comment, index) in commodity.comments" :name="index.toString()" :key="comment.cmt_id">
    <template #title>
      <span>{{ comment.cmt_name }}</span>
      <span style="float: right; color: #8492a6; font-size: 12px">{{ comment.cmt_time }}</span>
    </template>
    {{ comment.cmt_content }}
  </el-collapse-item>
</el-collapse> -->
<!-- 注释开始：评论区的代码 -->
<!-- <el-select v-model="sortMethod" placeholder="选择排序方式" @change="sortComments">
<el-option label="按时间排序" value="time"></el-option>
<el-option label="按回复数量排序" value="replies"></el-option>
</el-select> -->
<!-- <el-button type="danger" @click="changeState('time')">按发布时间排序</el-button>
<el-button type="danger" @click="changeState('replies')">按回复数量排序</el-button> -->

<el-card v-for="(comment) in topComments" :key="comment.cmt_id" class="box-card"
  style="margin-bottom: 20px; background-color: #fef0f0;">


  <!-- 渲染顶级评论的代码 -->
  <el-row>
    <el-col :span="2">
      <!-- <el-avatar size="large" icon="el-icon-user" ></el-avatar> -->
      <div v-if="comment.user_type === 0">
      <el-avatar size="large" style="background-color: #aa0d0d;">{{comment.cmt_name.substring(comment.cmt_name.length-2,comment.cmt_name.length)}}</el-avatar>
    </div>
    <div v-if="comment.user_type === 1">
      <el-avatar size="large" style="background-color: #aa0d0d;"> {{comment.cmt_name.substring(comment.cmt_name.length-2,comment.cmt_name.length)}} </el-avatar>
    </div>
    </el-col>
    <el-col :span="22">
      <el-row>
        <el-col :span="18">
          <h3>{{ comment.cmt_name }}
            <el-tag v-if="comment.user_type === 0" type="success" size="mini">用户</el-tag>
            <el-tag v-if="comment.user_type === 1" type="warning" size="mini">商家</el-tag>
            <p style="font-size: 15px; color: #ac2a2a;">已购买次数：{{ comment.buying_times }}</p>
          </h3>

        </el-col>
        <el-col :span="6" style="text-align: right;">
          <p style="font-size: 12px; color: #999;">{{ comment.cmt_time }}</p>
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="24">
          <p>{{ comment.cmt_content }}</p>
        </el-col>
      </el-row>
      <el-row style="margin-top: 10px;">
        <el-col :span="24">
          <!-- <el-rate v-model="comment.user_type" disabled></el-rate> -->
        </el-col>
      </el-row>
      <el-row>
        <el-col :span="22" style="text-align: right;">
          <!-- 绑定 openReplyDialog 函数到回复图标的点击事件上 -->
          <el-icon @click="openReplyDialog(comment)">
            <ChatDotRound color="#cc9900"/>
          </el-icon>
          <!-- 申诉图标，我们暂时不绑定任何函数 -->

        </el-col>
        <el-col :span="2" style="text-align: right;">
          <el-icon @click="complain_cmt(comment)">
            <Bell color="#cc0000"/>
          </el-icon>
        </el-col>
      </el-row>
    </el-col>
  </el-row>

  <!-- 注释开始：折叠子评论的代码 -->
  <el-collapse v-model="activeNames">
    <el-collapse-item title="点击此处查看回复" :name="comment.cmt_id.toString()" class="custom-collapse-item">
      <!-- <el-card
v-for="(childComment) in childComments[comment.cmt_id]"


:key="childComment.cmt_id"
class="box-card"
style="margin-bottom: 10px"
> -->
      <el-card v-for="(childComment) in comment.children" :key="childComment.cmt_id"
        class="box-card child-comment-card" style="margin-bottom: 10px;">
        <!-- 渲染子评论的代码 -->
        <el-row>
          <el-col :span="2">
            <div v-if="comment.user_type === 0">
      <el-avatar size="large" style="background-color: #aa0d0d;"> {{childComment.cmt_name.substring(childComment.cmt_name.length-2,childComment.cmt_name.length)}} </el-avatar>
    </div>
    <div v-if="comment.user_type === 1">
      <el-avatar size="large" style="background-color: #aa0d0d;"> {{childComment.cmt_name.substring(childComment.cmt_name.length-2,childComment.cmt_name.length)}} </el-avatar>
    </div>
          </el-col>
          <el-col :span="22">
            <el-row>
              <el-col :span="18">
                <h3>{{ childComment.cmt_name }}
                  <el-tag v-if="childComment.user_type === 0" type="success" size="mini">用户</el-tag>
                  <el-tag v-if="childComment.user_type === 1" type="warning" size="mini">商家</el-tag>
                </h3>
                <p style="font-size: 12px; color: #ac2a2a;">购买次数：{{ childComment.buying_times }}</p>
              </el-col>
              <el-col :span="4" style="text-align: right;">
                <p style="font-size: 12px; color: #999;">{{ childComment.cmt_time }}</p>
              </el-col>
            </el-row>
            <el-row>
              <el-col :span="24">
                <p>
                  <!-- 这里我们检查子评论是否有父评论，并决定是否显示 @xxx -->
                  <span v-if="childComment.cmt_father !== 0" style="color: blue;">
                    @{{ getParentContent(childComment.cmt_father) }}
                  </span>
                  {{ childComment.cmt_content }}
                </p>
              </el-col>
            </el-row>
            <el-row style="margin-top: 10px;">
              <el-col :span="24">
                <!-- <el-rate v-model="childComment.user_type" disabled></el-rate> -->
              </el-col>
            </el-row>




            <el-row>
              <el-col :span="20" style="text-align: right;">
                <!-- 绑定 openReplyDialog 函数到回复图标的点击事件上 -->
                <el-icon @click="openReplyDialog(childComment)">
                  <ChatDotRound color="#cc9900"/>
                </el-icon>
                <!-- 申诉图标，我们暂时不绑定任何函数 -->

              </el-col>
              <el-col :span="2" style="text-align: right;">
                <el-icon  @click="complain_cmt(comment)">
                  <Bell color="#cc0000"/>
                </el-icon>
              </el-col>
            </el-row>
          </el-col>
        </el-row>
      </el-card>
    </el-collapse-item>
  </el-collapse>
  <!-- 注释结束：折叠子评论的代码 -->
</el-card>
<!-- 注释结束：评论区的代码 -->

</el-card>




   <template v-slot:footer>
     <span class="dialog-footer">
       <el-button @click="cmtVisible = false" type="danger">确 认</el-button>
     </span>
   </template>
 </el-dialog>



 <el-dialog title="回复评论" :modelValue="replyVisible" @update:modelValue="replyVisible = $event" width="30%"
   >
   <el-input type="textarea" v-model="replyContent" autosize placeholder="请输入评论内容..."></el-input>
   <template v-slot:footer>
     <span class="dialog-footer">
       <el-button @click="replyVisible = false">取 消</el-button>
       <el-button type="danger" @click="submitReply">确 定</el-button>
     </span>
   </template>
 </el-dialog>


  
<el-dialog
 title="提交投诉"
 v-model="isComplaintDialogVisible"
 :before-close="handleClose">
 <div>
   <el-select v-model="appMatters" placeholder="（必填）请选择投诉事项">
     
     <el-option label="多次恶意评论" value="6"></el-option>

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
import axios from 'axios';
import { ElCard, ElRow, ElCol, ElAvatar, ElRate, ElTag, ElCollapse, ElCollapseItem,ElMessage } from 'element-plus';  // 导入新增的组件

import { useRouter,useRoute} from 'vue-router';
import {onMounted, ref,computed,watchEffect, watch} from 'vue'
import { ArrowLeft } from '@element-plus/icons-vue'
import dayjs from 'dayjs'
import * as echarts from 'echarts';
import baseURL from '../../../router/baseURL.js';
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
import { tr } from 'element-plus/es/locale';



function change(strr :string[]){
 var arr :string[]=[];
   for(var i=0;i<strr.length;i++)
     arr.push(strr[i]);
   for(i=0;i<arr.length;i++){
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
   return arr;
}

const url =ref('');
const srcList=ref([
 ''
]);
const changeState = (newState: string) => {
  console.log("test")
    sortMethod.value = newState;
    sortComments();  
  };
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
           else if(dayjs().isAfter(dayjs(expirationdate.value).add(1,'day'))){
            resultIcon.value='error';
            resultTitle.value='商品已过期'
           }
           else{
             resultIcon.value='success';
             resultTitle.value='商品正常在售';
           }

          //  srcList.value=data.value.com_image;
          //  url.value=change(srcList.value)[0];
            srcList.value=change(data.value.com_image);
            url.value=srcList.value[0];
            console.log("new : "+ url.value);
          //  console.log(url.value);

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
               color:'rgb(255, 0, 0)',
               data: data.value.com_pc_price
             }
           ]
         });
           // items.value = keyValuePairs.map(([key, value]) => ({ key: trans.value[key], val: value as string }));
       })
       .catch((error) => {
           console.log('An error occurred:', error);
       });

       axios.get(baseURL + `/api/commodity/detail`, {
         params: {
           com_id: com_id.value,
           cus_id: Number(sessionStorage.getItem("sto_id")),
         }
       })
       .then(response=>{
         console.log(response.data)
         commodity.value = response.data;
       //初始化评论区所需数据
       if (commodity.value) {
         allComments.value = commodity.value.comments.reduce((obj, comment) => {
           comment.children = [];
           obj[comment.cmt_id] = comment;
           return obj;
         }, {});

         topComments.value = commodity.value.comments.filter(comment => comment.cmt_father === 0);
         const processedComments = new Set<number>();
         topComments.value.forEach(comment => {
           collectAllChildren(comment,comment, allComments.value, processedComments);
         });
         for (const comment of topComments.value) {
           console.log("Parent Comment:", comment);
           console.log("Child Comments:", comment.children);
         }
         sortComments();
       }
       console.log("topComments.value"+topComments.value)
       })
       ;
       
       
});

const goBack=()=>{
 // history.back();
 router.back();
}


//======================scz  modify=================
const cmtVisible=ref(false);
const replyContent = ref("");

const topComments = ref<Comment[]>([]);
   const childComments = ref<Record<number, Comment[]>>({});
   const activeNames = ref<number[]>([]);  // 将 activeNames 的类型改为 number[]
     const currentComment = ref<Comment | null>(null);
       const allComments = ref<Record<number, Comment>>({});
     const commodity = ref<Commodity | null>(null);

const showCmt=()=>{
 // history.back();
 cmtVisible.value=true;
}
const sortMethod = ref<string>('time');  // 默认按时间排序
interface Comment {
 cmt_id: number;
 cmt_father: number;
 cmt_content: string;
 cmt_time: Date;
 user_id: number;
 cmt_name: string;
 user_type: number;
 buying_times: number;
 children: Comment[];  // 新增：用于存放子评论的数组
}

interface Commodity {
 com_images: string[];
 com_prices: { com_pc_time: string; com_pc_price: number }[];
 comments: Comment[];
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
 favor_state: number;
 //present_price:number;
}
// 新增：排序评论的函数
const sortComments = () => {
 if (sortMethod.value === 'time') {
   // 按时间排序
   topComments.value.sort((a, b) => new Date(b.cmt_time).getTime() - new Date(a.cmt_time).getTime());
 } else if (sortMethod.value === 'replies') {
   // 按回复数量排序
   topComments.value.sort((a, b) => b.children.length - a.children.length);
 }
};
   watchEffect(() => {
     activeNames.value = topComments.value.map(comment => comment.cmt_id);
   });

   const collectAllChildren = (Topcomment: Comment,comment: Comment, allComments: Record<number, Comment>, processedComments: Set<number>) => {
     for (const childCommentId in allComments) {
       const child = allComments[childCommentId];
       if (child.cmt_father === comment.cmt_id && !processedComments.has(child.cmt_id)) {
         Topcomment.children.push(child);
         processedComments.add(child.cmt_id);
         collectAllChildren(Topcomment,child, allComments, processedComments);
       }
     }
   };
   // const openReplyDialog = (comment) => {
   //   currentComment.value = comment;
   //   dialogVisible.value = true;
   // };
const replyVisible=ref(false)
   const openReplyDialog = (comment) => {
     currentComment.value = comment;
     replyVisible.value = true;
   };
   const submitReply = async () => {
     try {
       console.log("当前的父评论id是："+currentComment.value?.cmt_id)

       const response = await axios.post(baseURL + '/api/commodity/comment', {
         // const response = await axios.post('http://127.0.0.1:4523/m1/3026709-0-default/api/commodity/comment', {
         user_id: sessionStorage.getItem("sto_id"),  // 这里使用固定的用户ID，你可以按需修改
         cmt_content: replyContent.value,
         cmt_father: currentComment.value?.cmt_id,
         com_id: commodity.value?.com_id
       });

       console.log("response.data.msg:" + response.data.msg)
       // 添加新评论到评论列表中或处理响应
       //  response.data.comment 包含了新评论的详细信息
       console.log(response.data.comment)
       const newComment = response.data.comment;

       // 判断这是一个顶级评论还是子评论
       if (newComment.cmt_father === 0) {
         // 顶级评论
         topComments.value.push(newComment);
       } else {
         

         const com_id = route.query.com_id
         console.log("已经接收到com_id=" + com_id)
     

         const response = await axios.get(baseURL + `/api/commodity/detail`, {
           params: {
             com_id: com_id,
             cus_id: sessionStorage.getItem("sto_id")
           }
         });
         commodity.value = response.data;
      

  
       //初始化评论区所需数据
       if (commodity.value) {
         allComments.value = commodity.value.comments.reduce((obj, comment) => {
           comment.children = [];
           obj[comment.cmt_id] = comment;
           return obj;
         }, {});

         topComments.value = commodity.value.comments.filter(comment => comment.cmt_father === 0);
         const processedComments = new Set<number>();
         topComments.value.forEach(comment => {
           collectAllChildren(comment,comment, allComments.value, processedComments);
         });
         for (const comment of topComments.value) {
           console.log("Parent Comment:", comment);
           console.log("Child Comments:", comment.children);
         }
         sortComments();
       }
         // if (currentComment.value) {
         //   currentComment.value.children.push(newComment);
         // }
         
         // const processedComments = new Set<number>();
         // topComments.value.forEach(comment=>{
         //   comment.children=[];
         // })
         // topComments.value.forEach(comment => {
         //   collectAllChildren(comment,comment, allComments.value, processedComments);
         // });
         // for (const comment of topComments.value) {
         //   console.log("Parent Comment:", comment);
         //   console.log("Child Comments:", comment.children);
         // }
         // sortComments();
         
       }
       replyVisible.value = false;
       replyContent.value = "";
       
     // window.location.reload();
     } catch (error) {
       console.error(error);
     }
   };
   // const submitReply = async () => {
   //   try {
   //     console.log("当前的父评论id是："+currentComment.value?.cmt_id)

   //     const response = await axios.post(baseURL + '/api/commodity/comment', {
   //       user_id: sessionStorage.getItem("sto_id"), 
   //       cmt_content: replyContent.value,
   //       cmt_father: currentComment.value?.cmt_id,
   //       com_id: commodity.value?.com_id
   //     });

   //     console.log("response.data.msg:" + response.data.msg)
   //     // 添加新评论到评论列表中或处理响应
   //     //  response.data.comment 包含了新评论的详细信息
   //     console.log(response.data.comment)
   //     const newComment = response.data.comment;

   //     // 判断这是一个顶级评论还是子评论
   //     if (newComment.cmt_father === 0) {
   //       // 顶级评论
   //       topComments.value.push(newComment);
   //     } else {
   //       // 子评论
   //       if (currentComment.value) {
   //         currentComment.value.children.push(newComment);
   //       }
   //     }
   //     replyVisible.value = false;
   //     replyContent.value = "";
   //   } catch (error) {
   //     console.error(error);
   //   }
   // };
   const getParentContent = (fatherId) => {
     // const parentComment = topComments.value.find(comment => comment.cmt_id === fatherId);
     const parentComment = allComments.value[fatherId];
     console.log("当前的father_name:" + parentComment.cmt_name)
     return parentComment ? parentComment.cmt_name : '';
   };



   //============0829
   const selectedCmt=ref<Comment>();
   const complain = (comment) => {
     selectedCmt.value=comment;
     console.log("当前申诉的评论id是:"+selectedCmt.value?.cmt_id)
     console.log("isComplaintDialogVisible.value:"+isComplaintDialogVisible.value)
     // 打开投诉对话框

     isComplaintDialogVisible.value = true;
     //
   }
   const isComplaintDialogVisible = ref<boolean>(false);  // 切换投诉对话框的可见性

    watch(isComplaintDialogVisible, (newValue, oldValue) => {
    if (newValue === false) {
      sctImages.value = [];
      complaintText.value = '';
      appMatters.value = -1;
     }
  });

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
             user_ID:-1,
             // 其他需要发送的字段
             cmt_ID:selectedCmt.value?.cmt_id,
             com_ID:-1,
             
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
   