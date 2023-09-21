<template >
    <el-container style="background-color: #fef0f0;">
      <el-header >
        <el-menu
          mode="horizontal"
          router= true

          background-color="#aa0d0d"
          text-color="#fff"
          active-text-color="#ffd04b"


          :default-active="store.activePath"
        >
        <el-image
              :src="require('../../assets/logo_short.png')"
              style="height: 60px;"
              ></el-image>
          <div class="flex-grow" />
          <el-menu-item index='/home/recommendation'  class="menuItem" > <el-icon><Present /></el-icon> 推荐</el-menu-item>
          <el-menu-item index='/home/search' class="menuItem"><el-icon><Search /></el-icon> 搜索</el-menu-item>
          <el-menu-item index='/home/cart' class="menuItem" route="cart" > <el-icon><ShoppingCart /></el-icon>购物车 <el-badge :value="store.cartNum" style="display:flex;"></el-badge></el-menu-item>
          <el-menu-item index='/home/indent' class="menuItem"> <el-icon><MessageBox /></el-icon>我的订单</el-menu-item>
          <el-menu-item index='/ChatPage' class="menuItem"><el-icon><ChatLineRound /></el-icon> 聊天功能</el-menu-item>
          
          <el-menu-item index='/home/personalFavor' class="menuItem"> <el-icon><Star /></el-icon>个人收藏</el-menu-item>
          <el-menu-item index='/home/history' class="menuItem"> <el-icon><View /></el-icon>浏览记录</el-menu-item>
           <el-menu-item index='/UserInfoPage' class="menuItem"> <el-icon><User /></el-icon>个人信息</el-menu-item>
          <el-menu-item  @click="quit" class="menuItem"> 退出登录</el-menu-item>
        </el-menu>
      </el-header>
      <el-main style="min-height: 100vh;">
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

    import {useRouter} from 'vue-router'
    import {onActivated, onMounted,ref} from 'vue'
    import Cookies from 'js-cookie';
    import {
      Star,
      View,
      ShoppingCart,
      Search,
      User,
      MessageBox,
      ChatLineRound,
      Present
    } from '@element-plus/icons-vue'
    import {store}from '../../../router/store'
    const router=useRouter()
 
    
    const user_id=ref();
    onMounted(()=>{
      // console.log('当前顾客ID',route.query.user_id);
      user_id.value=sessionStorage.getItem("cus_id");
      console.log('homepage当前顾客ID',user_id.value);
      let cartname="cart"+user_id.value.toString()
      let cookie=Cookies.get();
      
      if (cartname in cookie){
          //有购物车数据
          let cookie = Cookies.get(cartname);
          let cart = JSON.parse(cookie);
          let cartNum=0;
          for( let item in cart){
            cartNum+=cart[item]
          }
          console.log(cartname,cart)
          store.cartNum=cartNum
      }
      else{
        store.cartNum=0
      }
      // recommendationNav();
    })
    
    function quit(){
      router.push({
        path:'/login'
      })
    }

    function recommendationNav(){
      router.push({
        path:'/home/recommendation'
      })
    }
  

    function personalFavorNav(){
      router.push({
        path:'/home/personalFavor',
        query:{user_id:user_id.value}
      })
    }
  
    
    function searchNav(){
      // console.log("search");
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
    function indentNav(){
      router.push({
        path:'/home/indent',
        query:{id:user_id.value}
      }
      );
    }
    
    function gotoChat(){
      router.push({
        path:'/ChatPage'
      })
    }
    </script>
    <style scoped>
    .flex-grow {
      flex-grow: 1;
    }

    .menuItem{
      color: white ;

    }
    .menuItem:hover{
      color: #409EFF ;
    }
    </style>