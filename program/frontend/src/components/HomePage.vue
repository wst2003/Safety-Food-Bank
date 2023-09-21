<template>
    <el-container>
      <el-header style="background-color: #337ecc;">
        <el-row justify="space-between">
          <el-col :span="4">
            <h3 style="
              color:aliceblue;
              text-overflow:ellipsis;
              white-space:nowrap;
              overflow:hidden;"
            >
              临期食品销售网站
            </h3>
          </el-col>
          <el-col :span="8" style="display: flex;justify-content: space-around;align-items: center;">
            <el-link :icon="Search" @click="searchNav" style="color: aliceblue;font-size: large;">搜索</el-link>
            <el-link :icon="Star" @click="personalFavorNav" style="color: aliceblue;font-size: large;">个人收藏</el-link>
            <el-link :icon="View" @click="historyNav" style="color: aliceblue;font-size: large;">浏览记录</el-link>
            <el-link :icon="ShoppingCart" @click="cartNav" style="color: aliceblue;font-size: large;">购物车</el-link>
            <el-link :icon="User" @click="personalNav" style="color: aliceblue;font-size: large;">个人信息</el-link>
            <el-button @click="quit">退出登录</el-button>
          </el-col>
        </el-row>
      </el-header>
      <el-main>
        <router-view v-slot="{ Component }"> 
        <keep-alive>
            <component
            v-if="$route.meta.keepAlive"
            :is="Component"
            :key="$route.name"
            ></component>
        </keep-alive>
        <component
            v-if="!$route.meta.keepAlive"
            :is="Component"
            :key="$route.name"
        ></component>
        </router-view>
      </el-main>
      <el-footer>
      </el-footer>
    </el-container>
    </template>
    
    <script lang="ts" setup>

    import {useRouter,useRoute} from 'vue-router'
    import {onMounted,ref} from 'vue'
    import axios from 'axios'; // 确保您已经安装了axios
    //axios.defaults.baseURL = 'http://localhost:5000';//网址基址
    //axios.defaults.baseURL = 'http://localhost:5000';//网址基址
    /*地址修改此处*/ 
    const base = 'http://localhost:5000';
    import {
      Star,
      View,
      ShoppingCart,
      Search,
      User
    } from '@element-plus/icons-vue'
    const router=useRouter()
    const route=useRoute()
    const user_id=ref();



    onMounted(()=>{
      console.log('当前顾客ID',sessionStorage.getItem('cus_id') as string);
      user_id.value=sessionStorage.getItem('cus_id') as string;

    })
    

    function quit(){
      router.push({
        path:'/login'
      })
    }

    function personalFavorNav(){
      router.push({
        path:'/home/personalFavor',
        query:{user_id:user_id.value}
      })
    }
  
    
    function searchNav(){
      router.push({
        path:'/home/search',
        query:{user_id:user_id.value}
      })
    }
    function historyNav(){
      router.push({
        path:'/home/history',
        query:{user_id:user_id.value}
      })
    }
    function cartNav(){
      router.push({
        path:'/home/cart',
        query:{user_id:user_id.value}
      })
    }
    function personalNav(){
      router.push({
        path:'/UserInfoPage',
        query:{id:user_id.value}
      }
      );
    }
    
    </script>
    