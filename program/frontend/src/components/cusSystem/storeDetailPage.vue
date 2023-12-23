<template>
  <el-container class="home_container">
    <!-- 头部区域 -->
    <el-header height="70px" style="background-color:#aa0d0d">
      <div>
        <img src="" alt="" />
        <span>{{ sto_name }}</span>
      </div>
      <div class="header-right">
      <el-button type="danger" @click="goToChat">聊天</el-button>
      <el-button type="danger"  plain @click="goToHome">回到主页</el-button>
    </div>
      </el-header>
    <el-container style="background-color:#fef0f0;" >
      <el-aside width="280px">
        <el-menu style="background-color:#d14545" text-color="#fff" active-text-color="#ffd04b" @select="handleMenuSelect"
          v-model="selectedMenu">
          <el-menu-item index="2" style="background-color:#d14545">
            <i class="el-icon-s-home"></i>
            <span>商家主页</span>
          </el-menu-item>
          <el-menu-item index="1" style="background-color:#d14545">
            <i class="el-icon-s-goods"></i>
            <span>所有商品</span>
          </el-menu-item>
          <!-- <el-menu-item index="3">
            <i class="el-icon-s-home"></i>
            <span>位置详情</span>
          </el-menu-item> -->
        </el-menu>
      </el-aside>
      <!-- 右侧主体区域 -->
      <el-main>
        <div v-if="selectedMenu === '1'">
          <el-breadcrumb separator-class="el-icon-arrow-right" style="font-size: 22px;">
            <el-breadcrumb-item :to="{ path: '/hello' }">商品列表</el-breadcrumb-item>
          </el-breadcrumb>
          <br>
          <el-row>
            <el-col :span="20">
              <el-input v-model="searchQuery" placeholder="请输入商品名称，搜索为空展示所有"></el-input>
            </el-col>
            <el-col :span="4">
              <el-button type="danger" @click="searchProducts">店内搜索</el-button>
            </el-col>
          </el-row>
          <br>
          <!-- 商品列表内容 -->
          
          <el-row :gutter="20">
            <el-col :xs="24" :sm="12" :md="8" :lg="6" :xl="4" v-for="(commodity, index) in pagedCommodities" :key="index">
              <el-card class="box-card">
                <div v-if="commodity.com_status === 0" class="sold-out-overlay">
    <span>已售罄</span>
  </div>
                <img :src="`${baseURL_obs}${commodity.com_firstImage}`" alt="商品图片" class="commodity-img"
                  @click="jumptoCom(commodity.com_id,cus_id)">
                <div class="commodity-details" @click="jumptoCom(commodity.com_id,cus_id)">
                  <div class="commodity-name">{{ commodity.com_name }}</div>
                  <div class="commodity-price">￥{{ commodity.com_price }}</div>
                </div>


                <el-text :style="{color:ex_color(commodity.com_expirationDate)}" >{{ commodity.com_expirationDate }}</el-text>
                <!-- <el-button type="text" class="commodity-expiration">{{ commodity.com_expirationDate }}</el-button> -->
                <!-- <div v-if="commodity.com_status === 0" class="sold-out">已售罄</div> -->
                
                <div class="favorite-icon">
                  <el-tooltip content="点击切换收藏状态">
                    <el-icon @click="toggleFavorite(commodity)">
                      <Star v-if="commodity.favor_state === 0" />
                      <StarFilled v-else />
                    </el-icon>
                  </el-tooltip>
                </div>
              </el-card>
            </el-col>
          </el-row>
          <el-pagination @current-change="handlePageChange" :current-page="currentPage" :page-size="8"
            layout="prev, pager, next" :total="commodities.length">
          </el-pagination>
        </div>
        <div v-else>
          <!-- 商家主页内容 -->
          <el-card class="box-card" v-if="store">
            <!-- <el-row>
              <el-col :span="20">
                <el-input v-model="searchQuery" placeholder="请输入商品名称"></el-input>
              </el-col>
              <el-col :span="4">
                <el-button type="primary" @click="searchProducts">店内搜索</el-button>
              </el-col>
            </el-row>
            <br> -->
            <div style="width: 1000px">
              <el-carousel height="400px" width="400px">
                <el-carousel-item v-for="(image, index) in store.sto_imageList" :key="index">
                  <img :src="baseURL_obs + `${image}`" alt="商家图片" style="width: 100%; height: 100%;">
              
                  <!-- <img :src="testURL + `/${image}`" alt="商家图片" style="width: 100%; height: 100%;"> -->

                </el-carousel-item>
              </el-carousel>
            </div>
            <div class="store-details">
              <h2>{{ store.sto_name }}</h2>
              <p>{{ store.sto_introduction }}</p>
              <p><strong>地址：</strong>{{ store.user_address }}</p>
              <h3><strong>主营类别：</strong></h3>
              <el-tag v-for="(category, index) in store.com_categories" :key="index">
                {{ category }}
              </el-tag>
            </div>
            <el-divider></el-divider>
            <h3><strong>公告：</strong></h3>
            <el-timeline>
              <el-timeline-item v-if="store.sto_notice.length > 0">
                {{ store.sto_notice[0].ntc_time }}：{{ store.sto_notice[0].ntc_content }}
              </el-timeline-item>
              <el-timeline-item v-else>
                空
              </el-timeline-item>
            </el-timeline>
            <el-divider></el-divider>
            <!-- <el-button type="primary" @click="goToCommodity">所有商品</el-button> -->
            <el-button type="danger" @click="dialogVisible = true">
              查看证书
            </el-button>
            <el-button type="info" @click="complain">投诉</el-button>
            <!-- <el-button type="primary" @click="goToCertificate">查看证书</el-button> -->
            <!-- 新增的对话框代码 -->
            <el-dialog v-model="dialogVisible" title="经营许可证" width="50%" :before-close="handleClose">
              <img :src="baseURL_obs + `${store.sto_licenseImg}`" alt="经营许可证" style="width: 100%;">
              <template #footer>
                <span class="dialog-footer">
                  <el-button @click="dialogVisible = false">Cancel</el-button>
                  <el-button type="danger" @click="dialogVisible = false">
                    Confirm
                  </el-button>
                </span>
              </template>
            </el-dialog>
          </el-card>
        </div>
      </el-main>
    </el-container>
  </el-container>
  
<el-dialog
  title="提交投诉"
  v-model="isComplaintDialogVisible"
  :before-close="handleClose">
  <div>
    <el-select v-model="appMatters" placeholder="（必填）请选择投诉事项">
      
      <el-option label="商家资质不全" value="3"></el-option>

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
import axios from 'axios'
import { ElMessageBox } from 'element-plus'
import { defineComponent, onMounted, ref, computed, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElIcon, ElTooltip,ElMessage } from 'element-plus'
import  baseURL  from "../../../router/baseURL.js";
import  baseURL_obs  from "../../../router/baseURL.js";



// 修改接口 Store，添加商品列表和公告列表
interface Store {
  sto_licenseImg: string;
  sto_imageList: string[];
  sto_notice: StoNotice[];
  sto_id: number;
  sto_name: string;
  sto_introduction: string;
  com_categories: string[];
  user_address: string;
  com_list: ComList[];
}

interface ComList {
  com_expirationDate: string;
  com_firstImage: string;
  com_name: string;
  com_price: number;
  favor_state: number;
}

interface StoNotice {
  ntc_content: string;
  ntc_time: Date;
}

interface Commodity {
  com_expirationDate: string;
  com_firstImage: string;
  com_name: string;
  com_price: number;
  favor_state: number;
  com_id:number;
  com_status: number; // 这里添加com_status字段

}

export default defineComponent({
  components: {
    ElIcon,
    ElTooltip
  },

  setup() {
    //const router = useRouter()
    const commodities = ref<Commodity[]>([])
    const originalCommodities = ref<Commodity[]>([]);
    const currentPage = ref(1)
    const  sto_id= ref('')
    const sto_name = ref('')
    const selectedMenu = ref('1'); // 默认选中商家主页

    const router = useRouter()
    const route = useRoute()
    const store = ref<Store | null>(null);
    const searchQuery = ref('');  // 新增的搜索查询变量
    //const showDialog = ref(false);  // 新增的对话框显示控制变量
    const dialogVisible = ref(false)
    const cus_id = ref<number>(0);
    const testURL="http://localhost:5000";
    


    onMounted(async () => {
      try {
        //const commoditiesData = route.query.commodities as string
        //sto_id.value=route.query.sto_id
        //sto_id.value = route.query.sto_id as string


        //commodities.value = JSON.parse(commoditiesData)
      
        // const cur_page=sessionStorage.setItem("cur_page")
        const sto_id = route.query.sto_id
        if(sessionStorage.getItem(sto_id+"curPage")!==null)
          currentPage.value=Number(sessionStorage.getItem(sto_id+"curPage"))
        
        // cus_id.value = Number(route.query.cus_id);
        cus_id.value=Number(sessionStorage.getItem("cus_id"))
        console.log("cus_id.value:"+cus_id.value)
        const response = await axios.get(`/api/cus/store/detail`, {
          params: {
            sto_id: sto_id,
            cus_id:cus_id.value
          }
        });

        console.log(response.data)

        // commodities.value = response.data.com_list
        // originalCommodities.value = response.data.com_list
        let currentDate = new Date();
        currentDate.setDate(currentDate.getDate() - 1); // Push currentDate one day forward
        commodities.value = response.data.com_list.filter((commodity: ComList) => {
      const expirationDate = new Date(commodity.com_expirationDate);
      // Compare the expiration date with the current date
      return expirationDate >= currentDate;
    });

    originalCommodities.value = commodities.value;
        // 对公告进行排序
        // response.data.sto_notice.sort((a: StoNotice, b: StoNotice) => {
        //   return new Date(b.ntc_time).getTime() - new Date(a.ntc_time).getTime();
        // });
        store.value = response.data;
        sto_name.value = response.data.sto_name;
        console.log("sto_name:" + sto_name.value)


      } catch (error) {
        console.error(error);
      }
    });

    const handleMenuSelect = (index: string) => {
      selectedMenu.value = index;
    };

    const goToCommodity = () => {
      if (store.value) {
        const commodities = JSON.stringify(store.value.com_list);
        console.log("即将跳转")
        router.push({ path: 'CommodityList', query: { commodities: commodities, sto_id: store.value.sto_id, sto_name: store.value.sto_name } });
      }
    }

    const jumptoCom = (com_id,cus_id) => {
      router.push({
        path: '/home/commodityDetail',
        //    name: 'commodityDetail', 
        query: { com_id: com_id ,cus_id:cus_id}
      })
    }
    const isComplaintDialogVisible = ref<boolean>(false);  // 切换投诉对话框的可见性

    watch(isComplaintDialogVisible, (newValue, oldValue) => {
    if (newValue === false) {
      sctImages.value = [];
      complaintText.value = '';
      appMatters.value = -1;
     }
  });
    const complain = (comment) => {
      console.log("isComplaintDialogVisible.value:"+isComplaintDialogVisible.value)
      // 打开投诉对话框
      isComplaintDialogVisible.value = true;
      //
    }
    const handleClose = (done: () => void) => {
      ElMessageBox.confirm('Are you sure to close this dialog?')
        .then(() => {
          done()
        })
        .catch(() => {
          // catch error
        })
    }
    // const goToCertificate = () => {  // 修改的查看证书方法
    //   console.log("开始显示")
    //   showDialog.value = true;  // 显示对话框
    //   console.log("结束显示")
    // }
    const searchProducts = () => {
      if (searchQuery.value.trim() === '') {
        // 如果搜索框为空，则恢复到原始商品列表
        commodities.value = originalCommodities.value;
        return;
      }

      // 从原始商品列表中过滤出匹配的商品
      commodities.value = originalCommodities.value.filter((commodity) => {
        return commodity.com_name.toLowerCase().includes(searchQuery.value.toLowerCase());
      });
    };


    const toggleFavorite = async (commodity: Commodity) => {
      commodity.favor_state = 1 - commodity.favor_state;

      // 发送 POST 请求到后端
      try {
        const response = await axios.post( '/api/cus/favorite/setFavorState', {
          com_id: commodity.com_id,
          cus_id: sessionStorage.getItem('cus_id'),
          favor_state: commodity.favor_state
        });

        // 处理响应，打印返回的数据
        console.log(response.data);
      } catch (error) {
        // 处理错误，例如打印错误信息
        console.error(error);
      }
    };

    const goToHome = () => {
      router.push('/home/search')
      //router.push({ name: 'StoreDetail' })  // 请根据你的实际路由配置来调整这里的路由名称
    }
    const goToChat = () => {
      router.push({
        path: '/ChatPage', query: {
          sto_id: route.query.sto_id,
        }
      })
    }
    

    const handlePageChange = (page: number) => {
      currentPage.value = page
      sessionStorage.setItem(route.query.sto_id+"curPage",String(currentPage.value))
    }

    const pagedCommodities = computed(() => {
      const start = (currentPage.value - 1) * 8
      const end = start + 8
      return commodities.value.slice(start, end)
    })

    const ex_color=(expiration_date:string)=>{
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
          
            const response = await axios.post( `/api/cus/appeal/createAppeal`, {
              app_matters: appMatters.value,
              app_content: complaintText.value,
              sct_images: sctImages.value,
              app_userID: sessionStorage.getItem("cus_id"),
              user_ID:route.query.sto_id,
              cmt_ID:-1,
              com_ID:-1,
              // 其他需要发送的字段
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
    return {
      store,
      goToCommodity,
      searchQuery,  // 新增的搜索查询变量
      searchProducts,  // 新增的搜索商品方法
      handleClose,
      dialogVisible,
      complain,
      baseURL,
      baseURL_obs,
      commodities,
      sto_id,
      sto_name,
      goToHome,
      handlePageChange,
      currentPage,
      pagedCommodities,
      toggleFavorite,
      selectedMenu,
      handleMenuSelect,
      jumptoCom,
      originalCommodities,
      cus_id,
      goToChat,
      ex_color,
      submitComplaint,
  complaintText,
  isComplaintDialogVisible,
  fileList,
      appMatters,
      handleExceed,
      beforeUpload,
      submitForm,
      sctImages
      
    }
  }
})
</script>

<style scoped>
.store-header {
  display: flex;
  align-items: center;
}

.store-carousel {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.store-img {
  width: 400px;
  height: 400px;
  margin-right: 20px;
}

.store-details h2 {
  margin-bottom: 0.5em;
}

.store-details h3 {
  margin-top: 1em;
  margin-bottom: 0.5em;
}

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

.home_container {
  height: 100%;
  background-color:#fef0f0;
}

.el-header {
  background-color: #373d41;
  display: flex;
  justify-content: space-between;
  padding-left: 100px;
  align-items: center;
  color: #fff;
  font-size: 22px;

  >div {
    display: flex;
    align-items: center;

    span {
      padding-left: 15px;
    }
  }
}

.common-layout {
  padding: 20px;
  background-color: #f5f7fa;
}

.box-card {
  /* height: 320px; */
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.favorite-icon {
  text-align: right;
  margin-top: -10px;
}

.commodity-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.commodity-name {
  font-weight: bold;
}

.commodity-price {
  color: #ff6f61;
}

.commodity-expiration {
  color: #999;
}

/* 分页器样式 */
.el-pagination {
  text-align: center;
  margin-top: 20px;
}

.commodity-img {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.header-right {
  display: flex;
  gap: 10px; /* 添加间隔 */
}

.sold-out {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: rgba(255, 0, 0, 0.7);
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
  font-size: 16px;
}

.sold-out-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(255, 0, 0, 0.4 );  /* 透明度可以根据需要调整 */
  display: flex;
  align-items: center;
  justify-content: center; /* 这三行确保文字在遮罩层中居中 */
  z-index: 10;  /* 确保遮罩层在卡片的顶部 */
  color: white;
  font-size: 18px;
  pointer-events: none;  /* 确保用户可以与卡片下方的元素互动 */
}
</style>
