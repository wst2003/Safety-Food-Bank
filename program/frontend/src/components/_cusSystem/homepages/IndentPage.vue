<template>
    <div>


      <el-row :gutter="20" align="middle">
    
    
    <el-col :span="6">
        <el-select v-model="selectedState" @change="fetchIndents" placeholder="选择订单状态">
            <el-option label="待核销" value='0'></el-option>
            <el-option label="已完成" value='1'></el-option>
            <el-option label="已退款" value='2'></el-option>
            <el-option label="过期未核销" value="3"></el-option>
        </el-select>
    </el-col>
    <el-col :span="6">
        <el-input v-model="searchString" placeholder="搜索订单..."></el-input>
    </el-col>
    <el-col :span="2">
        <el-button type="primary" @click="Search">搜索</el-button>
    </el-col>
    <el-col :span="6">
        <el-select v-model="sortOrder" placeholder="选择排序方式">
            <el-option label="按地理位置排序" value="0"></el-option>
            <el-option label="按订单创建时间排序" value="1"></el-option>
        </el-select>
    </el-col>
</el-row>
    
        <el-card v-for="element in indentData.element_arr" :key="element.ind_verificationCode">
            <template v-slot:header>
              <div class="header-content">
                <div v-if="selectedState==='1'||selectedState==='2'||selectedState==='3'" class="strikethrough ">
                    订单核销码: {{ element.ind_verificationCode }}(已失效)
                </div>
                <div v-else class="card-header">
                    订单核销码: {{ element.ind_verificationCode }}

                </div>
                <el-link @click="stoClick(element.sto_id)"  class="store-link">商铺：{{ element.sto_name }}</el-link>

                </div>
            </template>
      

      <el-card>
        <template v-slot:header>
                    <div>
                        订单商品预览
                    </div>

                </template>



                <el-row :gutter="20">
        <el-col :xs="24" :sm="12" :md="8" :lg="6" :xl="4" v-for="(indent, index) in element.indent_arr" :key="index">
            <el-card class="box-card" >
                <!-- 商品图片，您可能需要根据实际数据结构进行修改 -->
                <!-- <img :src="baseURL + `/${indent.com_firstImg}`" alt="商品图片" class="commodity-img"> -->
                <img :src="baseURL + `/${indent.com_firstImg}`" alt="商品图片" class="commodity-img" @click="jumptoCom(indent.com_ID)">

                <div class="commodity-details">
                    <el-link class="commodity-name" @click="jumptoCom(indent.com_ID)" >{{ indent.com_name }}</el-link>
                    
                    <div class="commodity-price">已支付￥{{ indent.ind_money }}</div>
                </div>
                <el-button type="text" class="commodity-purchaseTime">购买于{{ element.ind_creationTime }}</el-button>
        
                <div v-if="selectedState === '0'" class="refund-button">
                    <el-button v-if="!indent.isRefunded" @click="showRefundDialog(indent.ind_ID,indent.com_ID)" type="text" size="small">退款</el-button>
                    <el-button v-else disabled type="text" size="small">已退款</el-button>
                </div>
                <div v-if="selectedState === '1'" class="refund-button">
                  <el-button @click="showEvaluation(indent)">评分</el-button>
                </div>
            </el-card>
        </el-col>
    </el-row>

        
      </el-card>
      <el-collapse>
        <el-collapse-item title="点击查看订单详情">
          <h3>订单创建时间: {{ element.ind_creationTime }}</h3>
          <p>备注: {{ element.ind_notes }}</p>
          <div v-if="selectedState === '2'">
          <el-table :data="element.indent_arr" style="width: 100%">
            <el-table-column prop="ind_ID" label="订单ID"></el-table-column>
                <el-table-column prop="ind_quantity" label="购买数量"></el-table-column>
                <el-table-column prop="ind_money" label="支付金额"></el-table-column>
                <el-table-column prop="com_ID" label="商品ID"></el-table-column>
                <el-table-column prop="com_name" label="商品名称"></el-table-column>
                <el-table-column prop="ind_rating" label="订单评分"></el-table-column>
               
                    <el-table-column prop="ind_rtime" label="退款时间"></el-table-column>
                    <el-table-column prop="ind_rnotes" label="退款原因"></el-table-column>
                    <el-table-column prop="ind_rmoney" label="退款金额"></el-table-column>
                
          </el-table>
        </div>
        <div v-else>
          <el-table :data="element.indent_arr" style="width: 100%">
            <el-table-column prop="ind_ID" label="订单ID"></el-table-column>
                <el-table-column prop="ind_quantity" label="购买数量"></el-table-column>
                <el-table-column prop="ind_money" label="支付金额"></el-table-column>
                <el-table-column prop="com_ID" label="商品ID"></el-table-column>
                <el-table-column prop="com_name" label="商品名称"></el-table-column>
                <el-table-column prop="ind_rating" label="订单评分"></el-table-column>                
          </el-table>
        </div>
        </el-collapse-item>
      </el-collapse>
    </el-card>



       
    </div>

    <el-pagination 
            v-model:current-page="queryInfo.pagenum" 
            :page-size="queryInfo.pagesize" 
            layout="total, prev, pager, next, jumper"
            :total="queryInfo.total" 
            @current-change="handleCurrentChange"
        >
        </el-pagination>

    <el-dialog v-model="refundDialogVisible" title="退款" @closed="resetRefundForm">
      <div>
        <el-form  :rules="refundRules" ref="refundForm">
          <el-form-item label="退款原因" prop="ind_rnotes">
            <el-input v-model="ind_rnotes" auto-complete="off"></el-input>
          </el-form-item>
          <el-form-item label="当前单价">
            <div>{{ refundAmount }}</div>
          </el-form-item>
          <!-- <line-chart :data="prices"></line-chart> -->
        </el-form>
        <el-button @click="confirmRefund" type="primary">确认退款</el-button>
      </div>
    </el-dialog>

    <el-dialog v-model="successDialogVisible" title="退款成功">
      <div>
        <p>退款金额：{{ refundResult.price_return }}</p>
        <p>当前余额：{{ refundResult.balance }}</p>
      </div>
    </el-dialog>


    <el-dialog
    title="评价商品"
    :modelValue="showEvaluationDialog"
    width="30%"
    @close="resetEvaluation"
>
    <el-input
        v-model="evaluation.comment"
        type="textarea"
        :rows="4"
        placeholder="请输入评论内容"
    ></el-input>
    <el-rate v-model="evaluation.score"></el-rate>
    <template v-slot:footer>
      <span class="dialog-footer">
        <el-button @click="resetEvaluation">取消</el-button>
        <el-button type="primary" @click="confirmEvaluation">确定</el-button>
      </span>
    </template>
</el-dialog>

</template>

<script setup lang="ts">
import {reactive,ref,onActivated} from 'vue';
import {useRouter,useRoute} from 'vue-router'
import  baseURL  from "../../../../router/baseURL.js";
import axios from 'axios';

import { watch } from 'vue';
const router=useRouter()
interface IndentItem {
    ind_ID: number,
    ind_quantity: number,
    ind_money: number,
    ind_rating: number,
    com_ID: number,
    ind_rtime: string,
    ind_rnotes: string,
    ind_rmoney: number,
    com_firstImg:string,
    com_name:string,
    isRefunded :boolean,
}

interface IndentElement {
    indent_arr: Array<IndentItem>,
    ind_creationTime: string,
    ind_verificationCode: string,
    ind_notes: string,
    sto_id: string,  // 新增
    sto_name: string,  // 新增
}
const selectedState = ref('0');
const refundAmount=ref(0);
const selectedIndentID = ref(null);
const selectedComID = ref(null);
const indentData = reactive({ element_arr: Array<IndentElement>() });
    const refundDialogVisible = ref(false);
const successDialogVisible = ref(false);
const ind_rnotes=ref('');
const refundRules = ref({
  ind_rnotes: [{ required: true, message: '请输入退款原因', trigger: 'blur' }]
});
const refundResult = ref({ price_return: -1, balance: -1 });
const prices = ref([]);
const searchString = ref('');  // 用于存储搜索框的内容
const sortOrder = ref(0);  // 默认按地理位置排序
const queryInfo=reactive({
    pagenum: 1,//当前页码
    pagesize:2,//每页显示条数
    total:0,//共计条目数
    query:"",
    ind_state:0,

})

const evaluation = ref({
            comment: '',
            score: 5
        });
        const showEvaluationDialog = ref(false);
        const currentIndentForEvaluation = ref<IndentItem>();


const showRefundDialog = (ind_ID,com_ID) => {
  
    //这里还需要对refundAmount进行获取?
    selectedIndentID.value = ind_ID;
    selectedComID.value = com_ID;
    console.log(selectedComID.value)
    axios.get(baseURL + "/api/commodity/getCurve", {
        params: {
            com_id: selectedComID.value
        }
    })
    .then(response => {
        const com_prices = response.data.com_prices;
        prices.value=com_prices;
        calculateRefundAmount(com_prices);
    })
    .catch(error => {
        console.error("获取价格曲线失败:", error);
    });
   
    console.log("selectedIndentID.value:"+selectedIndentID.value)


  refundDialogVisible.value = true;
};

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
    refundAmount.value = previousPricePoint.com_pc_price;
};

const confirmRefund = () => {
  // Prepare the data for the POST request
  console.log("ind_rnotes:"+ind_rnotes.value)
  const requestData = {
    ind_ID: selectedIndentID.value, // Assuming you have this value
    ind_rnotes: ind_rnotes.value,
  };

  axios.post(baseURL+'/api/indent/refund', requestData,{
            headers: {
                'Content-Type': 'application/json'
            }
        })
    .then(response => {
        const order = indentData.element_arr.find(ele => ele.indent_arr.some(item => item.ind_ID === selectedIndentID.value));
            if (order) {
                const item = order.indent_arr.find(i => i.ind_ID === selectedIndentID.value);
                if (item) {
                    item.isRefunded = true;
                }
            }

      refundResult.value = response.data;
      successDialogVisible.value = true;



    })
    .catch(error => {
      console.error('退款失败:', error);
    });
    refundDialogVisible.value=false;
};

const resetRefundForm = () => {
  ind_rnotes.value = '';
  refundDialogVisible.value = false;
};

const fetchIndents = () => {
    queryInfo.pagenum=1;
    queryInfo.ind_state=Number(selectedState.value);
    const user_id = sessionStorage.getItem("cus_id");  // 从 sessionStorage 中获取用户 ID
    console.log("selectedState.value:"+selectedState.value);
    console.log("sortOrder.value:"+sortOrder.value);
    axios.post(baseURL + "/api/indent/getIndentList", {
        cus_id: user_id,
        ind_state: queryInfo.ind_state,
        search_str: queryInfo.query,
        sort_order: sortOrder.value,
        begin_pos: 0,  
        end_pos: 2 
    },{
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response => {
        indentData.element_arr = response.data.element_arr;
        queryInfo.total=response.data.total;
        console.log(":queryInfo.total:"+queryInfo.total)
        console.log("订单数据已成功获取",response);
    }).catch(error => {
        console.error("获取订单数据失败:", error);
    });
};
const jumptoCom = (com_id) => {
    const cus_id=sessionStorage.getItem("cus_id");
      router.push({
        path: '/home/commodityDetail',
        query: { com_id: com_id ,cus_id:cus_id}
      })
    };
onActivated(() => {
  const user_id = sessionStorage.getItem("cus_id");  // 从 sessionStorage 中获取用户 ID
    console.log("selectedState.value:"+selectedState.value);
    console.log("sortOrder.value:"+sortOrder.value);
    axios.post(baseURL + "/api/indent/getIndentList", {
        cus_id: user_id,
        ind_state: queryInfo.ind_state,
        search_str: '',
        sort_order: sortOrder.value,
        begin_pos: 0,  
        end_pos: 2 
    },{
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response => {
        indentData.element_arr = response.data.element_arr;
        queryInfo.total=response.data.total;
        console.log(":queryInfo.total:"+queryInfo.total)
        console.log("订单数据已成功获取",response);
    }).catch(error => {
        console.error("获取订单数据失败:", error);
    });
});
watch([sortOrder, selectedState], () => {
  // 当排序方式或selectedState更改时，重新获取商品列表
  fetchIndents();
});
const handleCurrentChange = () => {
  const user_id = sessionStorage.getItem("cus_id");  // 从 sessionStorage 中获取用户 ID
    console.log("selectedState.value:"+selectedState.value);
    console.log("sortOrder.value:"+sortOrder.value);
    console.log("queryInfo:"+2*(queryInfo.pagenum-1)+2*queryInfo.pagenum)
    axios.post(baseURL + "/api/indent/getIndentList", {
        cus_id: user_id,
        ind_state: queryInfo.ind_state, 
        search_str: queryInfo.query,
        sort_order: sortOrder.value,
        begin_pos:2*(queryInfo.pagenum-1),
        end_pos:2*queryInfo.pagenum,
    },{
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response => {
        indentData.element_arr = response.data.element_arr;
        console.log("订单数据已成功获取",response);
    }).catch(error => {
        console.error("获取订单数据失败:", error);
    });

    };

    const Search = () => {

      queryInfo.query=searchString.value;
      queryInfo.ind_state=Number(selectedState.value)
      queryInfo.pagenum=1;
      console.log("queryInfo.query:"+queryInfo.query);

      fetchIndents();

    };
    const stoClick = (sto_id) => {

      router.push({
        path: '/storeDetail',
        query: { sto_id: sto_id }
      })

};


const showEvaluation = (indent: IndentItem) => {
    showEvaluationDialog.value = true;
    currentIndentForEvaluation.value = indent;
};

const resetEvaluation = () => {
    evaluation.value.comment = '';
    evaluation.value.score = 0;
    showEvaluationDialog.value = false;
};

const confirmEvaluation = async () => {
    try {
        await axios.post(baseURL+'/api/indent/evaluation', {
          ind_id: currentIndentForEvaluation.value?.ind_ID,
          cmt_content: evaluation.value.comment,
          ind_rating: evaluation.value.score
        });
        showEvaluationDialog.value = false;
    } catch (error) {
      //
    }
};
    


</script>

<style scoped>
    /* 这里你可以添加一些样式 */
    .box-card {
  width: 100%;
  /* padding-bottom: 100%;  */
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.commodity-img {
  width: 100%;
  height: 200px;
  object-fit: cover; /* 图片按比例缩放并覆盖容器 */
}

.commodity-details {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.commodity-name {
  font-weight: bold;
  color:blueviolet;
}

.commodity-price {
  color: #ff6f61;
}
.commodity-purchaseTime {
  color: #999;
}
.refund-button {
  float: right;
}
.strikethrough {
    text-decoration: line-through;
    color: #999;
}
/* 增大下拉框、搜索框和搜索按钮的样式 */
.el-select, .el-input, .el-button {
    font-size: 18px;  /* 调整为您喜欢的大小 */
    margin: 10px 0;   /* 增加上下边距 */
    height: 40px;     /* 调整高度 */
}



.store-link {
    margin-right: 10px;
    font-size: larger;
    color:blueviolet;
}
.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}

</style>
