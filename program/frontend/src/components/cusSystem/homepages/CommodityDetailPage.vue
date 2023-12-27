<template>
  <div class="common-layout">
    <el-container>
      <el-header>
        <!-- Header is left blank -->
      </el-header>
      <el-container>
        <el-aside width="200px"></el-aside>
        <el-main>
          <div v-if="commodity">
            <el-card class="box-card">

              <!-- <div style="width: 800px"> -->
                <!-- 使用flexbox布局来居中轮播图 -->
<div style="width: 800px display: flex; justify-content: center; align-items: center;">
                <el-carousel height="400px" width="800px">
                  <el-carousel-item v-for="(image, index) in commodity.com_images" :key="index" style="display: flex; justify-content: center; align-items: center;">
                    <img :src=" `/${image}`" alt="商品图片" style="object-fit: contain ;justify-content: center; align-items: center;">
                  </el-carousel-item>
                </el-carousel>
              </div>
              <div v-if="!isExpired">
                <h1 class="title item">{{ commodity.com_name }}</h1>
                <h2 class="price item">￥{{ present_price }}</h2>
              </div>
              <div v-else class="strikethrough">
                <h1 class="title item" style="">{{ commodity.com_name }}(已过期)</h1>
                <h2 class="price item">￥{{ present_price }}</h2>
            </div>
            </el-card>
            <el-card class="box-card">
              <p class="text item">{{ commodity.com_introduction }}</p>

              <div style="display: flex; align-items: center; color: #999;">
                <p style="margin-right: 10px;">平均评分</p>
                <el-rate v-model="commodity.com_rating" :colors="colors" disabled style="margin-right: 10px;">
                </el-rate>
                <p>[{{ commodity.com_rating }}]</p>
              </div>
            </el-card>
            <el-card class="box-card" style="display: flex; justify-content: center; align-items: center; ">
              <el-table :data="tableData" stripe style="width: 100%;z-index: 0;">
                <el-table-column prop="attr" label="属性" width="180" />
                <el-table-column prop="info" label="详情" width="180" />
              </el-table>
            </el-card>
            <el-card class="box-card">
              <line-chart :data="commodity.com_prices"></line-chart>
            </el-card>

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
                            <el-col :span="6" style="text-align: right;">
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
                            <el-col :span="22" style="text-align: right;">
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

            <el-card class="box-card">
              <div v-if="!isExpired" class="button-group">
                <div class="left-buttons">
                  <el-button  @click="addToCart" style="color:white;background-color: #aa0d0d; ">加入购物车</el-button>
                  <el-input-number v-model="quantity" :min="1" :max="999" label="购买数量"></el-input-number>

                  <el-button  style="color:#aa0d0d;background-color: white; " @click="buyNow">立即购买</el-button>
                  <el-tooltip content="点击切换收藏状态">
                    <el-button v-if="commodity.favor_state === 0" style="background-color: #ffcc00;"
                      @click="toggleFavorite(commodity)">收藏</el-button>
                    <el-button v-if="commodity.favor_state === 1"  style="background-color:#ffffe5;"
                      @click="toggleFavorite(commodity)">取消收藏</el-button>
                    <el-button type="info" @click="comment">评论</el-button>

                  </el-tooltip>
                </div>
                <div class="right-buttons">
                  <!-- <el-button style="background-color: #e5f9ff;color: #000099;" @click="goToChat">咨询商家</el-button> -->

                  <el-button style="background-color: #e5e5ff;color: #000099" @click="toStore">转到商家</el-button>
                  <el-button  type="danger" @click="complain_com">投诉</el-button>
                </div>
              </div>
            </el-card>
            <!-- The rest of your template code -->
          </div>
        </el-main>
        <el-aside width="200px"></el-aside>
      </el-container>
      <el-footer>
        <!-- Footer is left blank -->
      </el-footer>
    </el-container>
  </div>



  <el-dialog title="回复评论" :modelValue="dialogVisible" @update:modelValue="dialogVisible = $event" width="30%"
    :before-close="handleClose">
    <el-input type="textarea" v-model="replyContent" autosize placeholder="请输入评论内容..."></el-input>
    <template v-slot:footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="danger" @click="submitReply">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <el-dialog title="购物车" v-model="cartDialogVisible">
  <p>商品已成功添加到购物车！</p>
  <p>您的购物车中现有 {{ cartItemCount }} 件商品。</p>
  <template #footer>
    <el-button @click="cartDialogVisible = false">关闭</el-button>
    <el-button type="danger" @click="goToCart">查看购物车</el-button>
  </template>
</el-dialog>
<el-dialog
  title="购买商品"
  v-model="purchaseDialogVisible"
  width="30%"
  :before-close="handleClose">
  <div>
    <el-input-number v-model="quantity" :min="1" :max="999" label="购买数量">购买数量</el-input-number>

    <!-- <el-input v-model="quantity" placeholder="请输入购买数量"></el-input> -->
    <br>

    <!-- <el-input v-model="totalPrice" placeholder="请输入总价"></el-input> -->
    <br>
    <el-input v-model="purchaseNotes" type="textarea" placeholder="请输入购买备注"></el-input>
    <el-text>
      当前余额：{{ balance.toFixed(2) }}
      <br>
      本次购买将消费：{{ quantity}} * {{ present_price.toFixed(2) }} = {{(quantity * present_price).toFixed(2)}}元
      <br>
      消费后剩余：<el-text :type="balance - quantity * present_price<0?'danger':'success'">{{  (balance - quantity * present_price).toFixed(2) }}元 </el-text>
    </el-text>
  </div>  
  <template v-slot:footer>
    <el-button @click="purchaseDialogVisible = false">取消</el-button>
    <el-button type="danger" @click="handlePurchase">确认购买</el-button>
  </template>
</el-dialog>

<el-dialog
  title="提交投诉"
  v-model="isComplaintDialogVisible"
  :before-close="handleClose"
  >
  <div>
    <el-select v-model="appMatters" placeholder="（必填）请选择投诉事项">
    <div v-if="complainState===0">
      <el-option label="商品信息不全" value="1"></el-option>
      <el-option label="食品安全问题" value="2"></el-option>
    </div>

    <div v-else>
      <el-option label="恶意评论" value="4"></el-option>
    </div>
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
    <el-button @click="submitForm">提交</el-button>
  </template>
</el-dialog>



</template>


<script lang="ts">
import LineChart from '../LineChart.vue'
import { defineComponent, onMounted, ref, watchEffect, onBeforeUnmount, watch} from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import baseURL from "../../../../router/baseURL.js";
import  baseURL_obs  from "../../../../router/baseURL.js";
import Cookies from 'js-cookie';
import {store}from '../../../../router/store'
import { computed } from 'vue';
import { ElMessage ,ElCard, ElRow, ElCol, ElAvatar, ElRate, ElTag, ElCollapse, ElCollapseItem } from 'element-plus';  // 导入新增的组件
import { UserFilled } from '@element-plus/icons-vue'
// import { Baseball } from '@element-plus/icons-vue/dist/types';
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
interface TableData {
  attr: string;
  //info: string | number;
  info: string | undefined;

}
interface Cart {
  [key: string]: number;
}

export default defineComponent({
  components: {
    'line-chart': LineChart,  // 假设你有一个名为 LineChartComponent 的组件
    // 'comments': CommentsComponent,  // 假设你有一个名为 CommentsComponent 的组件


    ElCard,
    ElRow,
    ElCol,
    ElAvatar,
    ElRate,
    ElTag,
    ElCollapse,
    ElCollapseItem,  // 注册新增的组件
  },
  setup() {
    const router = useRouter()
    const route = useRoute()
    const commodity = ref<Commodity | null>(null);
    const tableData = ref<TableData[]>([]);  // 创建一个响应式的 tableData 变量

    const topComments = ref<Comment[]>([]);
    const childComments = ref<Record<number, Comment[]>>({});
    const activeNames = ref<number[]>([]);  // 将 activeNames 的类型改为 number[]
    const dialogVisible = ref(false);
    const replyContent = ref("");
    const currentComment = ref<Comment | null>(null);
    const startTime = ref<Date | null>(null);
    const comId = ref<number | null>(null);
    const cus_id = ref<number>(0);
    const allComments = ref<Record<number, Comment>>({});
    const quantity = ref(1);  // 默认购买数量为1
    const cartDialogVisible = ref(false);
const cartItemCount = ref(0);
const totalPrice = ref<number>(0);
const purchaseNotes = ref<string>('');
  const purchaseDialogVisible = ref(false);
const present_price=ref(0);
const complaintReason = ref<string>('');  // 存储选中的投诉原因
const complaintText = ref<string>('');  // 存储投诉文本
const complaintImages = ref<FileList | null>(null);  // 存储选中的图片
const isComplaintDialogVisible = ref<boolean>(false);  // 切换投诉对话框的可见性
const balance=ref(0);
const complainState=ref(0);

watch(isComplaintDialogVisible, (newValue, oldValue) => {
    if (newValue === false) {
      sctImages.value = [];
      complaintText.value = '';
      appMatters.value = -1;
     }
  });

  async function openPurchaseDialog() {
    const response = await axios.get( `/api/cus/balance/getBalance`, {
          params: {
            cus_id: sessionStorage.getItem("cus_id")
          }
        });
        console.log(response.data.balance);
        balance.value=response.data.balance;
  purchaseDialogVisible.value = true;
}

async function handlePurchase() {
  if (!commodity.value) return;

  const requestData = {
    cus_id: sessionStorage.getItem("cus_id"),
    indent_arr: [
      {
        sto_id: commodity.value.sto_id.toString(),
        com_arr: [
          {
            com_id: commodity.value.com_id.toString(),
            ind_quantity: quantity.value,
            ind_money: (quantity.value)*(present_price.value),
          }
        ],
        ind_notes: purchaseNotes.value
      }
    ]
  };

  try {
    
    console.log("requestData:"+requestData)


    if(quantity.value>commodity.value.com_left){
      ElMessage({
        message: '您购买数量超过库存，请重新选择购买数量',
        type: 'warning',
      })
      return;
    }



    if((quantity.value)*(present_price.value)<=balance.value){
        const response = await axios.post( `/api/cus/indent/generateIndent`, requestData);
        // Handle the response here
        console.log(response.data);
        purchaseDialogVisible.value = false; // close the dialog after successful purchase
        ElMessage({
        message: '您已经成功下单',
        type: 'success',
      })

      commodity.value.com_left=commodity.value.com_left-quantity.value;
      console.log("当前的commodity.value.com_left："+commodity.value.com_left)

      tableData.value = [
            {
              attr: '名称',
              info: commodity.value?.com_name,
            },
            {
              attr: '简介',
              info: commodity.value?.com_introduction,
            },
            {
              attr: '原始价格',
              info: commodity.value?.com_oriPrice.toString(),
            },
            {
              attr: '到期日期',
              info: commodity.value?.com_expirationDate,
            },
            {
              attr: '上传日期',
              info: commodity.value?.com_uploadDate,
            },
            {
              attr: '剩余量',
              info: commodity.value?.com_left.toString(),
            },
            {
              attr: '评分',
              info: commodity.value?.com_rating.toString(),
            },
            {
              attr: '商家名称',
              info: commodity.value?.sto_name,
            },
          ];

    }
    else{
      ElMessage({
        message: '您的余额不足',
        type: 'warning',
      })
    }
  } catch (error) {
   
    console.error('Error purchasing item:', error);
  }
}


    onMounted(async () => {
      try {
        // 当组件挂载时记录开始时间
        startTime.value = new Date();
        // 从路由查询中获取com_id
        comId.value = Number(route.query.com_id);
        cus_id.value = Number(sessionStorage.getItem("cus_id"));

        const com_id = route.query.com_id
        console.log("已经接收到com_id=" + com_id)
        console.log("已经接收到cus_id" + cus_id.value)

        const response = await axios.get(`/api/cus/commodity/detail`, {
          params: {
            com_id: com_id,
            cus_id: cus_id.value
          }
        });
            
        console.log("name：" + response.data.com_name)
        console.log(response.data)
        commodity.value = response.data;
        console.log("commodity.value?.favor_state:"+commodity.value?.favor_state)
        if (commodity.value && commodity.value.com_prices) {
        commodity.value.com_prices = processComPrices(commodity.value.com_prices);
        console.log(commodity.value.com_prices)
    }
    const formattedRating = response.data.com_rating.toFixed(1);
if (commodity.value) {
  commodity.value.com_rating = formattedRating;
}
            // 在这里初始化 tableData
        tableData.value = [
          {
            attr: '名称',
            info: commodity.value?.com_name,
          },
          {
            attr: '简介',
            info: commodity.value?.com_introduction,
          },
          {
            attr: '原始价格',
            info: commodity.value?.com_oriPrice.toString(),
          },
          {
            attr: '到期日期',
            info: commodity.value?.com_expirationDate,
          },
          {
            attr: '上传日期',
            info: commodity.value?.com_uploadDate,
          },
          {
            attr: '剩余量',
            info: commodity.value?.com_left.toString(),
          },
          {
            attr: '评分',
            info: commodity.value?.com_rating.toString(),
          },
          {
            attr: '商家名称',
            info: commodity.value?.sto_name,
          },
        ];

   
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


        axios.get("/api/cus/commodity/getCurve", {
            params: {
                com_id: commodity.value?.com_id
            }
        })
          .then(response => {
          const com_prices = response.data.com_prices;
          //prices.value=com_prices;
          calculateRefundAmount(com_prices);
      })
      .catch(error => {
          console.error("获取价格曲线失败:", error);
      });



      } catch (error) {
        console.error(error);
      }
    });

    onBeforeUnmount(() => {
      const endTime = new Date();
      if (comId.value) {
        const start = startTime.value!;
        const end = endTime;
        const browserId = cus_id.value;
        const whetherBuy = 0;

        sendBrowsingData(start, end, comId.value, browserId, whetherBuy);
      }

    });

    const calculateRefundAmount = (com_prices) => {
      const today = new Date();
      let previousPricePoint = com_prices[0];
      for (let i = 1; i < com_prices.length; i++) {
          const pricePoint = com_prices[i];
          const pricePointDate = new Date(pricePoint.com_pc_time);
          if (today < pricePointDate) {
              break;
          }
          previousPricePoint = pricePoint;
      }
      present_price.value = previousPricePoint.com_pc_price;
    };
    
    // 一个帮助函数，将字符串转换为日期
    function stringToDate(dateStr: string): Date {
        return new Date(dateStr);
    }

// 一个帮助函数，将日期转换为字符串
function dateToString(date: Date): string {
    return date.toISOString().split('T')[0];
}

// 一个帮助函数，添加天数到指定的日期
function addDays(date: Date, days: number): Date {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

// 根据给定的 `com_prices` 数据，处理并返回连续的日期和价格列表
function processComPrices(comPrices: { com_pc_time: string; com_pc_price: number }[]) {
    // 首先，根据日期对价格列表进行排序
    comPrices.sort((a, b) => stringToDate(a.com_pc_time).getTime() - stringToDate(b.com_pc_time).getTime());

    const result: typeof comPrices = [];

    for (let i = 0; i < comPrices.length; i++) {
        const currentPriceObj = comPrices[i];
        result.push(currentPriceObj); // 将当前价格对象添加到结果列表

        // 如果不是最后一个价格对象，则检查下一个日期与当前日期之间是否有日期的缺失
        if (i < comPrices.length - 1) {
            const currentDate = stringToDate(currentPriceObj.com_pc_time);
            const nextDate = stringToDate(comPrices[i + 1].com_pc_time);
            let tmpDate = addDays(currentDate, 1);

            // 插入缺失的日期
            while (tmpDate < nextDate) {
                result.push({
                    com_pc_time: dateToString(tmpDate),
                    com_pc_price: currentPriceObj.com_pc_price // 使用当前价格作为默认值
                });
                tmpDate = addDays(tmpDate, 1);
            }
        }
    }

    return result;
}

    // const sendBrowsingData = async (comId: number, duration: number) => {
    //   try {
    //     const response = await axios.post(add + '/api/commodity/browsing', {
    //       com_id: comId,
    //       duration: duration,
    //     });
    //     console.log(response.data); // 可根据需要处理响应数据
    //   } catch (error) {
    //     console.error(error);
    //   }
    // };
    const sendBrowsingData = async (start: Date, end: Date, comId: number, browserId: number, whetherBuy: number) => {
      const formatDate = (date: Date): string => {
        const year = date.getFullYear().toString().padStart(4, '0');
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const day = date.getDate().toString().padStart(2, '0');
        const hours = date.getHours().toString().padStart(2, '0');
        const minutes = date.getMinutes().toString().padStart(2, '0');
        const seconds = date.getSeconds().toString().padStart(2, '0');
        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
      };

      const data = {
        bro_time_start: formatDate(start),
        bro_time_end: formatDate(end),
        com_id: comId,
        browser_id: browserId,
        whether_buy: whetherBuy,
      };

      try {
        console.log("data:", data.bro_time_start, data.bro_time_end, data.browser_id, data.com_id)
        // const response = await axios.post(baseURL + '/api/cus/history/setBrowsingHistory', data, {
        const response = await axios.post( '/api/cus/history/setBrowsingHistory', data, {
          headers: {
            'Content-Type': 'application/json'
          }
        });
        console.log("response.data.msg:" + response.data.msg);
      } catch (error) {
        console.error(error);
      }
    };
    const getParentContent = (fatherId) => {
      // const parentComment = topComments.value.find(comment => comment.cmt_id === fatherId);
      const parentComment = allComments.value[fatherId];
      console.log("当前的father_name:" + parentComment.cmt_name)
      return parentComment ? parentComment.cmt_name : '';
    };


     // 新增：定义排序方式的响应式变量
     const sortMethod = ref<string>('time');  // 默认按时间排序

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

    const openReplyDialog = (comment) => {
      currentComment.value = comment;
      dialogVisible.value = true;
    };

    const submitReply = async () => {
      try {
        console.log("当前的父评论id是："+currentComment.value?.cmt_id)

        const response = await axios.post( '/api/cus/commodity/comment', {
          // const response = await axios.post('http://127.0.0.1:4523/m1/3026709-0-default/api/cus/commodity/comment', {
          user_id: cus_id.value,  // 这里使用固定的用户ID，你可以按需修改
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
          
          // 子评论
          cus_id.value = Number(sessionStorage.getItem("cus_id"));

          const com_id = route.query.com_id
          console.log("已经接收到com_id=" + com_id)
          console.log("已经接收到cus_id" + cus_id.value)

          const response = await axios.get(`/api/cus/commodity/detail`, {
            params: {
              com_id: com_id,
              cus_id: cus_id.value
            }
          });
          commodity.value = response.data;
          const formattedRating = response.data.com_rating.toFixed(1);
if (commodity.value) {
  commodity.value.com_rating = formattedRating;
}
if (commodity.value && commodity.value.com_prices) {
        commodity.value.com_prices = processComPrices(commodity.value.com_prices);
        console.log(commodity.value.com_prices)
    }
            // 在这里初始化 tableData
        tableData.value = [
          {
            attr: '名称',
            info: commodity.value?.com_name,
          },
          {
            attr: '简介',
            info: commodity.value?.com_introduction,
          },
          {
            attr: '原始价格',
            info: commodity.value?.com_oriPrice.toString(),
          },
          {
            attr: '到期日期',
            info: commodity.value?.com_expirationDate,
          },
          {
            attr: '上传日期',
            info: commodity.value?.com_uploadDate,
          },
          {
            attr: '剩余量',
            info: commodity.value?.com_left.toString(),
          },
          {
            attr: '评分',
            info: commodity.value?.com_rating.toString(),
          },
          {
            attr: '商家名称',
            info: commodity.value?.sto_name,
          },
        ];

   
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
        dialogVisible.value = false;
        replyContent.value = "";
        router.push({ 
           path: '/home/commodityDetail', 
           query: { com_id: commodity.value?.com_id } 
       })
      // window.location.reload();
      } catch (error) {
        console.error(error);
      }
    };


    //     const collectAllChildren = (comment: Comment, allComments: Record<number, Comment>, processedComments: Set<number>) => {
    //     for (const childCommentId in allComments) {
    //         const child = allComments[childCommentId];
    //         if (child.cmt_father === comment.cmt_id && !processedComments.has(child.cmt_id)) {
    //             comment.children.push(child);
    //             processedComments.add(child.cmt_id);
    //             collectAllChildren(child, allComments, processedComments);
    //         }
    //     }
    // };
    
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
// 计算属性，判断商品是否已过期
const isExpired = computed(() => {
      if (commodity.value?.com_expirationDate) {
        // 获取商品的过期日期，并设置时间为当天的结束时刻
        const expirationDate = new Date(commodity.value.com_expirationDate);
        expirationDate.setHours(23, 59, 59, 999);

        // 获取当前日期
        const currentDate = new Date();

        // 比较日期
        return currentDate > expirationDate;
      }
      return false;
    });


    // const goToStore = () => {
    //   // 假设你有一个名为 storeDetail 的路由，你可以将商家ID作为参数传递
    //   router.push({ name: 'storeDetail', params: { store_id: commodity.value.store_id } })
    // }

    // const addToCart = () => {
    //   // 这里你需要实现将商品添加到购物车的逻辑
    //   let cookie = Cookies.get();
    //   let cookieArr;
    //   if ("com_id" in cookie) {
    //     let cookie = Cookies.get("com_id");
    //     cookieArr = cookie.split("|");
    //   }
    //   else {
    //     cookieArr = [];
    //   }
    //   let new_id = (commodity.value as Commodity).com_id.toString();
    //   if (cookieArr.indexOf(new_id) == -1) {
    //     //这里保证购物车中没有重复商品
    //     cookieArr.push(new_id);
    //     cookie = cookieArr.join("|");
    //     if (cookie[-1] == '|') {	//删除最后的|
    //       cookie = cookie.substring(0, cookie.length - 1);
    //     }

    //     let num = 2 //失效时间是几小时
    //     let time = new Date(new Date().getTime() + num * 60 * 60 * 1000);
    //     console.log(time)
    //     Cookies.set("com_id", cookie, {
    //       expires: time
    //     })
    //   }
    //   else {
    //     console.log('购物车中已有该商品')
    //   }
    // }
  const updateCartItemCount = () => {
    // 更新购物车中的商品数量
    let cartname="cart"+cus_id.value.toString()
    let cookieData = Cookies.get(cartname) || "{}";
    let cart = JSON.parse(cookieData) as Cart;
    cartItemCount.value = Object.values(cart).reduce((total, quantity) => total + Number(quantity), 0);
  }
  
  const addToCart = () => {
    let cartname="cart"+cus_id.value.toString()
    let cookieData = Cookies.get(cartname) || "{}";
    let cart = JSON.parse(cookieData);
    
    let comId = (commodity.value as Commodity).com_id.toString();
    let left= (commodity.value as Commodity).com_left;
    let currentQuantityInCart = 0;
    if(comId in cart){
      currentQuantityInCart=cart[comId];
    }
   
    console.log("currentQuantityInCart:"+currentQuantityInCart)
    if (currentQuantityInCart +  quantity.value> left) {
      ElMessage({
        message: '您购买数量超过库存！',
        type: 'warning',
      })
      return;
    }
    // 检查购物车中是否已有该商品
    if (cart[comId]) {
      console.log('购物车中已有该商品，更新数量');
      cart[comId] += quantity.value;  // 更新购买数量
    } else {
      cart[comId] = quantity.value;  // 新增商品和购买数量
    }

    let num = 2;  // 失效时间是几小时
    let time = new Date(new Date().getTime() + num * 60 * 60 * 1000);
    Cookies.set(cartname, JSON.stringify(cart), { expires: time });

      
    let cartNum=0;
    for( let item in cart){
      cartNum+=cart[item]
    }
    store.cartNum=cartNum
    
    // 更新购物车中的商品数量
    updateCartItemCount();
    
    // 显示对话框
    cartDialogVisible.value = true;
  };

    const goToCart = () => {
  // 前往购物车页面的逻辑
  router.push({
        path:'/home/cart',
      })}
    const buyNow = () => {
      // 这里你需要实现立即购买商品的逻辑

      let left= (commodity.value as Commodity).com_left;

      
      openPurchaseDialog();
    }
    const selectedCmt=ref<Comment>();
 
    
    const complain_cmt = (comment) => {
      
      complainState.value=1;
      selectedCmt.value=comment;
      console.log("当前申诉的评论id是:"+selectedCmt.value?.cmt_id)
      console.log("isComplaintDialogVisible.value:"+isComplaintDialogVisible.value)
      // 打开投诉对话框
      isComplaintDialogVisible.value = true;
      //
    }
    const complain_com = () => {
      
      complainState.value=0;
      console.log("isComplaintDialogVisible.value:"+isComplaintDialogVisible.value)
      // 打开投诉对话框
      isComplaintDialogVisible.value = true;
      //
    }

    const comment = () => {
      //
    }

    const toStore = () => {
      router.push({
        path: '/storeDetail', query: {
          sto_id: commodity.value?.sto_id,
          cus_id: cus_id.value
        }
      })
      //ee
    }
    const toggleFavorite = async (commodity: Commodity) => {
      commodity.favor_state = 1 - commodity.favor_state;

      // 发送 POST 请求到后端
      try {
        const response = await axios.post('/api/cus/favorite/setFavorState', {
          com_id: commodity.com_id,
          cus_id: cus_id.value,/* 这里后续需要修改 */
          favor_state: commodity.favor_state
        });

        // 处理响应，打印返回的数据
        console.log(response.data);
      } catch (error) {
        // 处理错误，例如打印错误信息
        console.error(error);
      }
    };
    const goToChat = () => {
      router.push({
        path: '/ChatPage', query: {
          sto_id: commodity.value?.sto_id,
        }
      })
    }


    async function submitComplaint() {
  // 提交投诉的逻辑

  
  // 这里添加发送到后端 API 的代码
  // ...

  // 关闭投诉对话框
  isComplaintDialogVisible.value = false;
}




    
    const appMatters = ref<number | null>(null);
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

    // 处理图片上传数量超过限制
    const handleExceed = () => {
      alert('最多只能上传三张图片');
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
          if (appMatters.value!=4) {
            const response = await axios.post( `/api/cus/appeal/createAppeal`, {
              app_matters: appMatters.value,
              app_content: complaintText.value,
              sct_images: sctImages.value,
              app_userID: sessionStorage.getItem("cus_id"),
              com_ID: commodity.value?.com_id,
              user_ID:-1,
              cmt_ID:-1,
              // 其他需要发送的字段
            },{
            headers: {
                'Content-Type': 'application/json'
            }});
            console.log('Server response:', response.data);

          }
          else{

            const response = await axios.post(`/api/cus/appeal/createAppeal`, {
              app_matters: appMatters.value,
              app_content: complaintText.value,
              sct_images: sctImages.value,
              app_userID: sessionStorage.getItem("cus_id"),
              com_ID: commodity.value?.com_id,
              cmt_ID:selectedCmt.value?.cmt_id,
              user_ID:-1,
              // 其他需要发送的字段
            });
            console.log('Server response:', response.data);
           
            

          }
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
    const changeState = (newState: string) => {
    sortMethod.value = newState;
    sortComments();  
  };

    return {
      commodity,
      //呃呃，这一步也很重要
      tableData,
      //goToStore,
      addToCart,
      buyNow,
      toStore,
      toggleFavorite,
      complain_com,
      complain_cmt,
      comment,
      baseURL,
      baseURL_obs,
      colors: ['#99A9BF', '#F7BA2A', '#FF9900'],
      activeNames,  // 新增：返回当前展开的评论的数组
      topComments,  // 新增：返回顶级评论的数组
      childComments,  // 新增：返回子评论的对象
      dialogVisible,
      replyContent,
      openReplyDialog,
      submitReply,
      getParentContent,
      sortMethod,
      sortComments,
      quantity,
      isExpired,
      cartDialogVisible,
      cartItemCount,
      goToCart,
     totalPrice,
     purchaseNotes,
     purchaseDialogVisible,
     openPurchaseDialog,
     handlePurchase,
     present_price,
     goToChat,
  submitComplaint,
  complaintReason,
  complaintText,
  complaintImages,
  isComplaintDialogVisible,
  fileList,
      appMatters,
      
      handleExceed,
      beforeUpload,
      submitForm,
      sctImages,
      balance,
      complainState,
      changeState
      
    }
  }
})
</script>

<style scoped>
.title {
  font-size: 24px;
}

.price {
  color: red;
  text-align: right;
}

.text {
  color: #999;
}

.button-group {
  position: fixed;
  bottom: 0;
  left: 300px;
  right: 300px;
  background: #fff;
  display: flex;
  padding: 10px 0;
  border-top: 1px solid #ccc;
}

.button-group .left-buttons {
  justify-content: flex-start;

}

.button-group .right-buttons {
  display: flex;
  justify-content: flex-end;
  width: 50%;
  padding: 0 10px;
}

.child-comment-card {
  margin-left: 50px;
  /* 或你想要的任何其他值来实现向右的偏移 */
  padding: 10px 15px;
  /* 减少内边距使卡片看起来更小 */
  font-size: 0.9em;
  /* 减少字体大小 */
}
.strikethrough {
    text-decoration: line-through;
    color: #999;
}
.custom-collapse-item {
  background-color: #ec0a0a !important; /* 替换#your-color为您想要的背景颜色 */
}
</style>
