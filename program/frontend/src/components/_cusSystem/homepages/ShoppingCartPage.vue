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
                    <el-button @click="queryFuc" type="primary"><el-icon><search/></el-icon></el-button>
                    </template>
                </el-input>
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="queryClearReset">显示所有</el-button>
            </el-col>

            <!-- <el-col :span="8">
                <el-text>颜色标识：</el-text>
                <el-text>售罄 </el-text>
                <el-button  color=" #eebe77"  ></el-button>
                <el-text> 过期 </el-text>
                <el-button  color=" #95d475"  ></el-button>
            </el-col> -->
        </el-row>
        <!-- 列表区域 -->
        <div v-if="comList.comList.length>0">
        <el-table 
            :data="comListOnDisplay"  
            :row-class-name="tableRowClassName"
            height="80vh"
            @selection-change="handleSelectionChange"
            v-loading="loading"
            >
            <el-table-column type="selection" width="55" />
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
            <el-table-column label="当前价格" prop="com_price"></el-table-column>
            <el-table-column label="过期日期" prop="com_expirationDate">
                <template  v-slot="scope">
                    <el-text type="danger" v-if="scope.row.com_status==-1">已过期 </el-text>
                    <el-text :type="ex_color(scope.row.com_expirationDate)"    v-else>{{ scope.row.com_expirationDate }} </el-text>            
                 </template> 
            </el-table-column>
            <el-table-column label="余量" prop="com_left">
                <template  v-slot="scope">
                    <el-text type="danger" v-if="scope.row.com_status==0">售罄 </el-text>
                    <el-text  v-else>{{ scope.row.com_left }} </el-text>
                </template> 
            </el-table-column>
            <el-table-column label="购买数量" prop="quantity">
                <template  v-slot="scope">
                    <el-input-number v-model="scope.row.quantity" :min="1" :max="scope.row.com_left"  :disabled="scope.row.com_status==-1||scope.row.com_status==0"/>

                    <!-- <el-text type="danger" v-if="scope.row.quantity>scope.row.com_left">{{ scope.row.quantity }} </el-text>
                    <el-text  v-else>{{ scope.row.quantity }} </el-text> -->
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
        <el-row justify="space-between">
            <el-pagination 
            v-model:current-page="queryInfo.pagenum" 
                :page-size="queryInfo.pagesize" 
                layout="total, prev, pager, next, jumper"
                :total="comListAfterPick.comListAfterPick.length" 
                @current-change="handleCurrentChange"
            >
            </el-pagination>
            <div>
                <el-button type="success" @click="comfirmIndent" :disabled="multiSelected_row.length==0">购买</el-button>
                <el-button type="danger" @click="deleteItem" :disabled="multiSelected_row.length==0">删除</el-button>
            </div>
        </el-row>
        </div>
        <div v-if="comList.comList.length==0" style="display: flex;justify-content: center;align-items: center;">
            <h1>购物车为空</h1>
        </div>

    </el-card>


<!-- 确认下单页面 -->
    <el-dialog
        v-model="indentVisible"
        title="下单"
    >
    
    <el-card v-for="indent in indent_arr" :key="indent.sto_id " style="margin-top: 10px;">
        <h2>{{ indent.sto_name }}</h2>
        <el-table
            :data="indent.com_arr"
        >
            <el-table-column label="名称" prop="com_name"></el-table-column>
            <el-table-column label="购买数量" prop="ind_quantity"></el-table-column>
            <el-table-column label="所需金额" prop="ind_money"></el-table-column>
        </el-table>
        <el-input 
            placeholder="请输入订单备注" 
            v-model="indent.ind_notes" 
            clearable
            style="margin-top: 5px;"
            type="textarea"
            
        >
        </el-input>
    </el-card>
  
    
    <h4>您的余额：{{ balance }} 本单价格：{{ indent_price }} 您的余额将剩余：<el-text :type="balance-indent_price<0?'danger':'success'">{{ balance-indent_price }} </el-text></h4>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="indentVisible = false">取消</el-button>
        <el-button type="primary" @click="createIndent">
          确定下单
        </el-button>
      </span>
    </template>
  </el-dialog>
</template>
<script setup lang="ts">
import {reactive,ref, computed,onActivated,onMounted} from 'vue';
import {useRouter} from 'vue-router'
import  baseURL  from "../../../../router/baseURL.js";
import axios from 'axios';
import {
  Star, 
  StarFilled
} from '@element-plus/icons-vue'
import Cookies from 'js-cookie';
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
    com_status:number,//当前商品状态，-1过期，0售罄，1在售
    quantity:number,//购买数量
}
//从后端拉取到的，单品信息

interface com_arr_item{
    com_id:string,
    com_name?:string,//商品名称，不应该传入接口
    ind_quantity:number,
    ind_money:number
}

interface indent_arr_item{
    sto_id:string,
    sto_name?:string,//商家名称，不应该传入接口
    ind_notes:string,
    com_arr:Array<com_arr_item>
}

const loading=ref(true);
const balance=ref(0);//账户余额
const indent_price=ref(0);//下单的价格

const indent_arr=ref<indent_arr_item[]>([]);//按照商店分类后的订单数组

const indentVisible = ref(false);

const multiSelected_row = ref<ComInfo[]>([]);//被选中的列信息

const comListAfterPick=reactive({ comListAfterPick:Array<ComInfo>()})
//筛选后的浏览记录
const comList=reactive({comList:Array<ComInfo>()})
//该用户的全部浏览记录
const queryInfo=reactive({
    query:'',//查询参数
    pagenum: 1,//当前页码
    pagesize:10//每页显示条数
})
const comListOnDisplay= computed(()=>{
    return comListAfterPick.comListAfterPick.slice(queryInfo.pagesize*(queryInfo.pagenum-1),queryInfo.pagesize*queryInfo.pagenum);
})
//显示的记录
onMounted(()=>{
    if(sessionStorage.getItem("cus_id")!==undefined)
        user_id.value=sessionStorage.getItem("cus_id")
    else 
        user_id.value=12
    console.log("user_id:",user_id.value)

})

onActivated(()=>{
    loading.value=true;
    let cookie=Cookies.get();
    if ("cart" in cookie){
        //有购物车数据
        let cookie = Cookies.get("cart");
        let cart = JSON.parse(cookie);
        let com_id_arr = Object.keys(cart).map(Number);
        axios.post(
        baseURL+`/api/commodity/shoppingCart`,
        {
            com_id_arr: com_id_arr,
            cus_id: user_id.value
            //cus_id: 12
        }, {
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(res=>{
            comList.comList=res.data.com_list;
            //这里可能需要对图片的相对路径进行处理
            comList.comList.forEach((item)=>{
                item.com_firstImage=baseURL+'/'+item.com_firstImage
                item.quantity=cart[ item.com_id.toString()]
            })
            console.log('购物车数据拉取成功',comList.comList)
            //这里可能需要对筛选条件进行处理
            comListAfterPick.comListAfterPick=comList.comList;
           
        }).catch(error => {
            loading.value=false;
            console.error('购物车数据请求失败', error);
            ElMessageBox.alert('购物车数据请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });
        axios.get(
            baseURL+`/api/balance/getBalance`,
            {
                params:{
                    cus_id:user_id.value
                }
            }
        ).then(res =>{
            loading.value=false;
            balance.value=res.data.balance
        }).catch(error => {
            loading.value=false;
            console.error('余额请求失败', error);
            ElMessageBox.alert('余额请求失败!', '', {
                confirmButtonText: 'OK'
            })
        });

    }
    else{
        console.log("没有购物车数据");
        comList.comList=[];
    }
})

function comfirmIndent(){
    // 此处调出弹窗
    let str=""
    let flag=2;//标识是否有不符合要求的订单
    for(let item of multiSelected_row.value){
        if(item.com_status==-1){
            flag=-1
            str="有已过期商品，不可购买"
            break;
        }else if (item.com_status==0){
            flag=0
            str="有售罄商品，不可购买"
            break;
        }else if(item.quantity>item.com_left){
            flag=1
            str="有下单数量大于余量，不可购买"
            break;
        }
    }

    
    if(flag!=2){
        ElMessageBox.alert(str, '下单失败', {
            confirmButtonText: 'OK'
        })
    }
    else{
        
        indent_price.value=0;//本单总价
        multiSelected_row.value.forEach(item=>{
            indent_price.value+=
                item.com_price*item.quantity
        })

        indent_arr.value.splice(0,indent_arr.value.length);//首先清空订单数组
        // 根据sto_id将订单分组
        const groupedByStoId = multiSelected_row.value.reduce((groups, item) => {
            const stoId = item.sto_id;
            
            if (!groups[stoId]) {
                groups[stoId] = [];
            }
            
            groups[stoId].push(item);
            
            return groups;
        }, {});

        for (const stoId in groupedByStoId) {
            const group = groupedByStoId[stoId];
            console.log(`sto_id: ${stoId}, group:`, group);
            let com_arr=Array<com_arr_item>();
            let sto_name;
            for (const item of group){
                let com_arr_item:com_arr_item={
                    com_id: item.com_id,
                    com_name:item.com_name,
                    ind_quantity:item.quantity,
                    ind_money:item.quantity*item.com_price
                }
                com_arr.push(com_arr_item)
                sto_name=item.sto_name
            }

            let indent_arr_item:indent_arr_item={
                sto_id:stoId,
                sto_name:sto_name,
                ind_notes:"",
                com_arr:com_arr
            };
            indent_arr.value.push(indent_arr_item);
        }
        // 创建订单数组
        indentVisible.value = true;
    }
}

function ex_color(expiration_date:string){
    var expirationDate = new Date(expiration_date.replace(/-/g,"/"));
    var dateNow = new Date();
    var dateDiff = expirationDate.getTime() - dateNow.getTime();//时间差的毫秒数
    var dayDiff = Math.ceil(dateDiff / (24 * 3600 * 1000));//计算出相差天数，向下取整
    var type;
    if(dayDiff<1)
        type="danger";
    else if(dayDiff<3)
        type="warning";
    else if(dayDiff<7)
        type="primary";
    else
        type="success";
    return type
}


function createIndent(){
    if (balance.value < indent_price.value ){
        ElMessageBox.alert('余额不足', '', {
            confirmButtonText: 'OK'
        })
        indentVisible.value = false;
        return ;
    }

    // 接口中不需要name字段
    for (let indent of indent_arr.value){
        delete indent["sto_name"];
        for(let item of indent.com_arr){
            delete item["com_name"];
        }
    }
    
    //创建订单
    axios.post(baseURL+'/api/indent/generateIndent',JSON.stringify({
        cus_id:user_id.value,
        indent_arr:indent_arr.value
    }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(()=>{
        //console.log(res)
        console.log("订单生成成功")
        deleteItem()
        ElMessageBox.alert('下单成功！', '', {
            confirmButtonText: 'OK'
        })
        balance.value=balance.value-indent_price.value//修改余额
    }).catch(()=>{
        console.log("订单生成失败")
        ElMessageBox.alert('下单失败', '', {
            confirmButtonText: 'OK'
        })

    }).finally(()=>{
        indentVisible.value = false
        //关闭对话框
    })
}

function deleteItem(){
    //删除购物车内选中物品
    comList.comList = comList.comList.filter(item => !multiSelected_row.value.includes(item));
    comListAfterPick.comListAfterPick = comListAfterPick.comListAfterPick.filter(item => !multiSelected_row.value.includes(item));
    //处理cookie
    let cookie = Cookies.get("cart");
    let cart = JSON.parse(cookie);
    multiSelected_row.value.forEach(item =>{
        delete cart[item.com_id];
    })
    let num = 2;  // 失效时间是几小时
    let time = new Date(new Date().getTime() + num * 60 * 60 * 1000);
    Cookies.set("cart", JSON.stringify(cart), { expires: time });
    console.log("删除成功")
}

const handleSelectionChange = (val: ComInfo[]) => {
  //多选对象改变
  multiSelected_row.value = val

}

function handleCurrentChange(){
    console.log('当前页数',queryInfo.pagenum)
}

function tableRowClassName (row: ComInfo) {
    //处理表格背景样式

    if(row.com_status==-1){
        return 'success-row'
    }
    if (row.com_status==0) {
        return 'warning-row'
    }
    return ''
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
            query: { sto_id: sto_id,cus_id:user_id.value } 
        })
}

function queryFuc(){
    console.log(queryInfo.query);
    //在表中显示满足搜索条件的商品或商家
    let res=comList.comList.filter((item)=>{
        return item.com_name.includes(queryInfo.query)||item.sto_name.includes(queryInfo.query)
    })
    comListAfterPick.comListAfterPick=res
}

function queryClearReset(){
    console.log(queryInfo.query);
    //重新显示所有记录
    comListAfterPick.comListAfterPick=comList.comList;
}

function favorClick(com_id){
    console.log('更改收藏状态',com_id)
    let pick_index=comListAfterPick.comListAfterPick.findIndex((element)=>{
        return element.com_id==com_id
    })
    let ori_index=comList.comList.findIndex((element)=>{
        return element.com_id==com_id
    })

    comListAfterPick.comListAfterPick[pick_index].favor_state==1?
        comListAfterPick.comListAfterPick[pick_index].favor_state=0:
        comListAfterPick.comListAfterPick[pick_index].favor_state=1;
    comList.comList[ori_index].favor_state=comListAfterPick.comListAfterPick[pick_index].favor_state;
    axios.post(
        baseURL+'/api/favorite/setFavorState',
        JSON.stringify({
            com_id:com_id,
            cus_id:user_id.value,
            //此处指定收藏的用户，后续更改
            favor_state: comList.comList[ori_index].favor_state
        }), {
            headers: {
                'Content-Type': 'application/json'
            }
        }
    ).then(res =>{
        console.log(res.data.msg)
    }).catch(error => {
        console.error('收藏请求失败', error);
        comListAfterPick.comListAfterPick[pick_index].favor_state==1?
            comListAfterPick.comListAfterPick[pick_index].favor_state=0:
            comListAfterPick.comListAfterPick[pick_index].favor_state=1;
        comList.comList[ori_index].favor_state=comListAfterPick.comListAfterPick[pick_index].favor_state;
    });

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