<template>
  <el-container>
    <el-header style="background-color: #aa1514;">
      <el-row justify="space-between">
        <el-col :span="5" style="display: flex; align-items: center;">
          <img src="../assets/shibaobao_logo.png" alt="商标" style="height: 100%; max-height: 50px; margin-right: 10px;"> <!-- 添加商标图片 -->
          <h3 style="  
              color:aliceblue;
              text-overflow:ellipsis;
              white-space:nowrap;
              overflow:hidden;">
            用户信息修改（商户）
          </h3>
        </el-col>
        <el-col :span="20" style="display: flex; justify-content: flex-end; align-items: center;">
          <el-link icon="el-icon-arrow-left" @click="goBack" style="color: aliceblue; font-size: large; margin-left: 15px;">返回主页</el-link>
        </el-col>
      </el-row>
    </el-header>
    <el-main style="background-color: #fef0f0; min-height: 100vh;">
      <el-form :model="userInfo" ref="form" @submit.prevent="modifyUser" style="max-width: 1100px; position: relative; margin: auto;">
        <div style="border-bottom: 1px solid gray; padding: 10px;">
          <div style="display: flex; align-items: center;">
            <img src="../assets/icons8-account-64.png" alt="关于账户">
            <h3 style="margin-left: 10px;">账号信息</h3>
          </div>
          <div style="clear: both;"></div>
        </div>
        <br><br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-id-64.png')" alt="用户ID图标" style="height: 1.1em; margin-right: 1px;">
              用户ID：
            </span>
          </el-col>
          <el-col :span="9">
            <span class="value">{{ basicInfo.user_ID }}</span>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-telephone-64.png')" alt="电话号码图标" style="height: 1.1em; margin-right: 1px;">
              电话号码：
            </span>
          </el-col>
          <el-col :span="9">
            <span class="value">{{ basicInfo.user_phone }}</span>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-password-64.png')" alt="密码图标" style="height: 1.1em; margin-right: 1px;" :disabled="flag!=null">
              新密码：
            </span>
          </el-col>
          <el-col :span="9">
            <el-input v-model="basicInfo.user_password" type="password" :disabled="flag!=null"></el-input>
          </el-col>
        </el-row>
        <br>
        <div style="border-bottom: 1px solid gray; padding: 10px;">
          <div style="display: flex; align-items: center;">
            <img src="../assets/icons8-store-64.png" alt="商户信息">
            <h3 style="margin-left: 10px;">商户信息</h3>
          </div>
        </div>
        <div style="clear: both;"></div>
        <br><br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-edit-user-64.png')" alt="商户名图标" style="height: 1.1em; margin-right: 1px;">
              新商户名：
            </span>
          </el-col>
          <el-col :span="9">
            <el-input v-model="userInfo.sto_name" :disabled="flag!=null"></el-input>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-goal-64.png')" alt="主营类型图标" style="height: 1.1em; margin-right: 1px;">
              主营类型：
            </span>
          </el-col>
          <el-col :span="9">
            <el-select v-model="userInfo.categories" multiple clearable placeholder="Select" filterable allow-create :disabled="flag!=null">
                <el-option v-for="item in categories" :key="item" :label="item" :value="item" :disabled="flag!=null"></el-option>
              </el-select>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-address-50.png')" alt="地址图标" style="height: 1.1em; margin-right: 1px;" >
              新地址：
            </span>
          </el-col>
          <el-col :span="18">
            <el-input v-model="addressInput" :disabled="flag!=null"></el-input>
          </el-col>
          <el-col :span="3">
            <el-button style="background-color: white; color: #aa1514;" @click="searchLocation" :disabled="flag!=null">搜索地址</el-button>
          </el-col>
        </el-row>
        <div id="baiduMap" style="width:100%; height: 300px; margin-top:10px;"></div>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-note-64.png')" alt="备注图标" style="height: 1.1em; margin-right: 1px;">
              商户简介：
            </span>
          </el-col>
          <el-col :span="21">
            <el-input v-model="userInfo.sto_introduction"></el-input>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-license-64.png')" alt="营业执照图标" style="height: 1.1em; margin-right: 1px;">
              营业执照：
            </span>
          </el-col>
          <el-col :span="21">
            <el-upload v-model:file-list='fileList' class="upload-demo"
              action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15" :auto-upload="false" :limit="1" :on-exceed="handleExceed" :disabled="flag!=null">
              <template #trigger>
                <el-button style="background-color: #aa1514; color: white;" :disabled="flag!=null">选择文件</el-button>
              </template>
            </el-upload>
          </el-col>
        </el-row>
        <br>
        <el-row :gutter="25">
          <el-col :span="3">
            <span class="label">
              <img :src="require('../assets/icons8-image-64.png')" alt="商家图片图标" style="height: 1.1em; margin-right: 1px;">
              商家图片：
            </span>
          </el-col>
          <el-col :span="21">
            <el-row :gutter="10">
              <el-col :xs="4" :sm="4" :md="4" :lg="4" v-for="(pic, index) in storedImages" :key="index">
                <div class="image-container">
                  <img :src="pic.fullUrl" alt="Stored Image" width="100" height="100" />
                  <el-button type="danger" @click="deleteStoredImage(index)" size="mini" :disabled="flag!=null">删除</el-button>
                </div>
              </el-col>
            </el-row>
            <el-upload v-model:file-list='fileList1' class="upload-demo"
              action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15" :auto-upload="false" :disabled="flag!=null">
              <template #trigger>
                <el-button style="background-color: #aa1514; color: white;" :disabled="flag!=null">选择文件</el-button>
              </template>
            </el-upload>
          </el-col>
        </el-row>
        <br>
        <el-button style="background-color: #aa1514; color: white;" native-type="submit">提交修改</el-button>
      </el-form>
    </el-main>
  </el-container>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useRoute, useRouter } from 'vue-router';

const route = useRoute();
const router = useRouter();
const basicInfo = ref({});
const userInfo = ref({});
const categories = ref([]);
const fileList = ref([]);
const fileList1 = ref([]);
const storedImages = ref([]);
//加入百度地图组件
/* eslint-disable */
let map: BMapGL.Map;
let geoc: BMapGL.Geocoder;
const addressInput = ref('');     //地址搜索框绑定变量
const flag=route.query.flag;

onMounted(async () => {
  //const sto_ID = route.query.id;
  const sto_ID = flag==null? sessionStorage.getItem('sto_id'):route.query.id;
  const basic_response = await axios.get('/api/pub/getinformation/user', { params: { user_ID:sto_ID } });
  if (basic_response.status === 200) {
    basicInfo.value = basic_response.data;
    console.log(basicInfo.value);
    } else {
    console.error(`Error: HTTP status code ${basic_response.status}`);
  }


    map = new BMapGL.Map("baiduMap"); 
    geoc = new BMapGL.Geocoder();
    //const map = new BMapGL.Map("baiduMap"); 
    const point = new BMapGL.Point(116.404, 39.915);  // 创建点坐标
    map.centerAndZoom(point, 15);                     // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(true);                  // 开启鼠标滚轮缩放
    addressInput.value = basicInfo.value.user_address;
    // 创建地址解析器实例
    const myGeo = new BMapGL.Geocoder();
    // 将地址解析结果显示在地图上，并调整地图视野
    myGeo.getPoint(basicInfo.value.user_address, function(point) {
      if (point) {
        map.centerAndZoom(point, 16);
        map.addOverlay(new BMapGL.Marker(point));
      } else {
        alert("您选择地址没有解析到结果!");
      }
    });

    // 添加地图点击事件监听
    map.addEventListener("click", function (e: any) {
      const pt = e.latlng;
      //alert('点击的经纬度：' + e.latlng.lng + ', ' + e.latlng.lat);
      geoc.getLocation(pt, function (rs: any) {
        console.log('Complete geocoding result:', rs);
        const addComp = rs.addressComponents;
        addressInput.value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
        //alert(form.user_address);
        //form.sto_lng = pt.lng.toString();
        //form.sto_lat = pt.lat.toString();
        //alert('点击的经纬度：' + pt.lng.toString() + ', ' + pt.lat.toString());
        basicInfo.value.user_address = addressInput.value;
        var marker = new BMapGL.Marker(pt);  // 创建标注
        map.clearOverlays(); // 清除所有覆盖物
        map.addOverlay(marker); // 将标注添加到地图中
        //marker.enableDragging(); // 可拖拽
      });
    });
  
  const response = await axios.get('/api/pub/getinformation/store', { params: { sto_ID: sto_ID } });
  if (response.status === 200) {
    userInfo.value = response.data;
  } else {
    console.error(`Error: HTTP status code ${response.status}`);
  }
    // 获取已有的商家图片
  const imgResponse = await axios.get('/api/pub/getinformation/storeimg', { params: { sto_ID: sto_ID } });
  if (imgResponse.status === 200) {
    storedImages.value = imgResponse.data.imageURL.map(pic => ({
      fullUrl: 'http://localhost:5000\\' + pic,
      relativePath: pic
    }));
    console.log(storedImages.value);
  } else {
    console.error(`Error: HTTP status code ${imgResponse.status}`);
  }


  const response_categoty = await axios.get('/api/pub/category/getcategories');
    if (response_categoty.status === 200) {
      categories.value = response_categoty.data.categorylist;
    } else {
      console.error(`Error: HTTP status code ${response_categoty.status}`);
    }
});

const deleteStoredImage = async (imageIndex) => {
  try {
    const relativePathToDelete = storedImages.value[imageIndex].relativePath;
    const response = await axios.post('/api/pub/modify/delstoreimg', {
      sto_ID: basicInfo.value.user_ID, 
      url: relativePathToDelete
    }, {
      params: {
        sto_ID: basicInfo.value.user_ID
      }
    });

    if (response.status === 200 && response.data.message === 'success') {
      // 删除图片在storedImages中的引用
      storedImages.value.splice(imageIndex, 1);
      alert('图片删除成功');
    } else {
      alert('删除失败');
    }
  } catch (error) {
    console.error(error);
  }
};

const goBack = () => {
    if(flag==null)
      router.push({ path: '/store' });
    else
      router.push('/administrator');
  };

const searchLocation = () => { // 搜索地点
    const local = new BMapGL.LocalSearch(map, {
      renderOptions: { map: map, autoViewport: true, selectFirstResult: false },
      pageCapacity: 8,
    });
    // 搜索回调
    local.setSearchCompleteCallback(results => {
      if (local.getStatus() === BMAP_STATUS_SUCCESS) {
        const pt = results.getPoi(0).point;
        //form.sto_locationPoint = `${pt.lng},${pt.lat}`;
        // 更新输入框地址
        geoc.getLocation(pt, rs => {
          const addComp = rs.addressComponents;
          addressInput.value = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
          basicInfo.value.user_address = addressInput.value;
          //form.sto_lng = pt.lng.toString();
          //form.sto_lat = pt.lat.toString();
        });

      } else {
        ElMessage.error('未找到相关地址！');
      }
    });

    local.search(addressInput.value);
  };
const handleExceed = (files, fileList) => {
  alert('只能上传一张图片！');
  };
const modifyUser = async () => {
  try {
    if (fileList1.value.length + storedImages.value.length < 1 || fileList1.value.length + storedImages.value.length > 9) {
    alert('商家图片数量必须在1-9张之间！');
    return;
  }
    const userResponse = await axios.post('/api/pub/modify/user', {
        user_ID: basicInfo.value.user_ID,
        user_phone: basicInfo.value.user_phone,
        user_password: basicInfo.value.user_password,
        user_address: basicInfo.value.user_address,
      });

    const formData = new FormData();

    fileList.value.forEach((file) => {
        formData.append('sto_licenseImg', file.raw); // 将文件添加到FormData中
    });


    fileList1.value.forEach((file) => {
        formData.append('sto_picture', file.raw); // 将文件添加到FormData中
    });


    formData.append('sto_ID', userInfo.value.sto_ID);
    formData.append('sto_name', userInfo.value.sto_name);
    formData.append('sto_introduction', userInfo.value.sto_introduction);
    userInfo.value.categories.forEach((category: string) => {
      formData.append('categories', category);
    });

    const storeResponse = await axios.post('/api/pub/modify/store', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });

    if (userResponse.data.message === 'success' && storeResponse.data.message === 'success') {
      alert('修改成功');
      if(flag==null)
          router.push({ name: 'UserInfoPage'});
        else
        router.push({ name: 'UserInfoPage',query:{id:userInfo.value.sto_ID,flag:1}});
    } else {
      alert('修改失败');
    }
  } catch (error) {
    console.error(error);
  }
};

</script>

<style scoped>
.form-layout{
  display: flex;
  flex-direction:column;
  width:300px;
  margin-left: 620px;
  justify-content: center;
}
.header{
    display: flex;
    justify-content: center;
    align-items: center;
    
}
.form-item {
  display: flex;
  align-items: center;
}
.label {
  color: grey;
  margin-right: 10px;
}
.value {
  color: black;
  font-size: larger;
}
.image-container {
    text-align: center;
    margin-bottom: 15px;
  }
</style>