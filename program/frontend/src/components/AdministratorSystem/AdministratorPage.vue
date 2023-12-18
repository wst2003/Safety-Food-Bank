<html class="dark">
  <head></head>
  <body></body>
</html>


<template>

<el-container>
    <!-- 头部区域 -->
    <el-header height="70px">
      <div>
        <img src="" alt="" />
        <span>管理员系统</span>
      </div>
      <!-- <el-button type="info"  @click="dialogVisible = true">发布公告</el-button> -->
      <el-button type="info"  @click="logout">退出登录</el-button>
    </el-header>
	<el-container >
    <div class="layout-container-demo">
    <el-aside>
          <el-menu
          background-color="#333744"
          text-color="#fff"
          active-text-color="#ffd04b"
        >
          <!-- 一级菜单 -->
          <el-menu
        active-text-color="#ffd04b"
        background-color="#545c64"
        class="el-menu-vertical-demo"
        default-active="2"
        text-color="#fff"
        @open="handleOpen"
        @close="handleClose"
      >
      <el-sub-menu index="1">
          <template #title>
            <el-icon><location /></el-icon>
            <span>管理信息</span>
          </template>
          <el-menu-item-group>
            <el-menu-item @click="router.push('/appeal'),view=false" index="1-2">申诉管理</el-menu-item>
            <el-menu-item @click="router.push({path:'/operate',query:{type:1}}),view=true" index="1-1">商户与顾客管理</el-menu-item>
            
          </el-menu-item-group>

        </el-sub-menu>
      </el-menu>
        </el-menu>

        </el-aside>
      </div>
        <!-- 右侧主体区域 -->
        <el-main>
      <el-tabs type="border-card" class="demo-tabs"  v-loading="loading">
      <el-tab-pane v-if="view">
        <template #label>
          <span class="custom-tabs-label"  @click="router.push({path:'/operate',query:{type:1}})">
            <el-icon><Warning /></el-icon>
            <span>商户</span>
          </span>
        </template>
      </el-tab-pane>

      <el-tab-pane v-if="view">
        <template #label>
          <span class="custom-tabs-label"  @click="router.push({path:'/operate',query:{type:0}})">
            <el-icon><CircleCheck /></el-icon>
            <span>顾客</span>
          </span>
        </template>
      </el-tab-pane>

      <div>
          
      <router-view v-slot="{ Component,route }">
        <keep-alive >
          <component v-if="route.meta.keepAlive" :is="Component" />
            </keep-alive>
            <component v-if="!route.meta.keepAlive" :is="Component" />
          </router-view>
      </div>

      
    </el-tabs>

        </el-main>
    
	</el-container>
</el-container>


</template>
  
  <script lang="ts" setup>
  import { Options, Vue } from 'vue-class-component';
  import{ref,onMounted}from 'vue';
  import { useRouter,useRoute } from 'vue-router';
  import { ArrowLeft } from '@element-plus/icons-vue'
  import { Action, ElMessage, ElMessageBox,ElNotification } from 'element-plus'
  import axios from 'axios';
  const goodsList=ref([]);
  const router=useRouter();
  const route=useRoute();
  const dialogVisible = ref(false)
  const text=ref('');
  const sto_id=ref('');
  const view=ref(true);
  import {
  Document,
  Menu as IconMenu,
  Location,
  Setting,
} from '@element-plus/icons-vue'
import { ConsoleLogger } from '@microsoft/signalr/dist/esm/Utils';

  onMounted(() => {
    //sto_id.value = route.query.sto_id as string;
    sto_id.value = sessionStorage.getItem('sto_id') as string;
    console.log(router.currentRoute.value.path);
    router.push({path:'/operate',query:{type:1}})
    
  });

  const logout=()=>{
    // router.push('/test');
    // getContent.value='录入商品'
    axios.post('/api/pub/login/quit',  JSON.stringify({ 
            user_ID:sessionStorage.getItem('sto_id') as string
          }), {
          headers: {
              'Content-Type': 'application/json'
          }
          })
          .then(response=>{
            const message=response.data.message==="success"?"success":"退出登录失败"
            ElMessageBox.alert(response.data.message, message, {
                  confirmButtonText: 'OK',
                  callback: (action: Action) => {
                    ElMessage({
                      type: 'info',
                      message: `action: ${action}`,
                    })
                  },
                })
          })
    router.push('/login');
    console.log('success jump');
  }

  </script>
  
  <!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.el-row {
  margin-bottom: 20px;
}
.el-row:last-child {
  margin-bottom: 0;
}
.el-col {
  border-radius: 4px;
}

/* .el-main{
  margin-top: 20px; */
  /* background-color: #F0F2F5;
} */
.grid-content {
  border-radius: 4px;
  min-height: 36px;
}
  .home_container {
      height:100%;
  }

  /* .el-sub-menu{
    background-color: #606266;
    color: #fff;
  } */
  .el-header {
  background-color: #373d41;
  display: flex;
  justify-content: space-between;
  padding-left: 100px;
  align-items: center;
  color: #fff;
  font-size: 22px;
  > div {
    display: flex;
    align-items: center;
    span {
      padding-left: 15px;
    }
  }
}

/* 
.aside{
  >el-aside{
    >el-menu{
    background-color:#fff;
    }
  }
} */
/* .aside{
  background-color: #606266;

  align-items: center;
}
.el-menu {
  background-color: #606266;
    height: 100%;
    color: #fff;
} 
.el-menu-item{
  background-color: #606266;

  align-items: center;
} */
.layout-container-demo{
  height: 100%;
}
.layout-container-demo .el-header {
  position: relative;
  background-color: var(--el-color-primary-light-8);
  color: var(--el-text-color-primary);
  border: #373d41;
}
.layout-container-demo .el-aside {
  margin-right: 5px;
  height: 820px;
  width: 250px;
  background-color: #606266;
}

.layout-container-demo .el-menu {
  border-right: none;
  background-color: #606266;
}
.layout-container-demo .toolbar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  right: 20px;
}

</style>

  
  