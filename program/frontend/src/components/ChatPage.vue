<template>
  <!-- 头部区域 -->
  <el-header height="80px">
    <div>
      <img src="StoreLogo.jpg" alt="" style="width: 150px; padding-right: 10px;"/>
      <span>聊天系统</span>
      
    </div>
    <!-- <el-button type="info"  @click="dialogVisible = true">发布公告</el-button> -->
    <el-button type="danger" style="background-color:#c45656;"  @click="goBacktoPer">返回</el-button>
  </el-header>
  <br>
  <el-container>
        <el-aside width="350px" style="background-color: #fde2e2;">
          <br>
          <span class="chat-list"> 消息列表 </span>
          <!-- <el-button :icon="House" style="display: flex; margin-top:-27px;" @click="goBacktoPer">返回</el-button> -->
          <br>
          <el-menu
          active-text-color="000000"
          background-color="fafafa"
          text-color="000000"
          :default-active="chat_member">
          <div v-for="v in chatlist" :key="v.user">
            <el-menu-item class="chatmember"  v-if="v.user" @click="exchange_chat_member(v.user)" :index=v.user>
                <!-- <div>
                  <el-row>
                    <el-col :span="14">
                      
                  <span style="display: flex; font-size: large;">{{v.name}}</span>
                  <div v-if="v.chat_type" style="margin-top: 10px;">
                  <span style="display: flex; margin-top: 20px;">[图片]</span>
                  </div>
                  <div v-else>
                  <span style="display: flex; margin-top: 50px;">{{v.message}}</span>
                  </div>
                </el-col>
                <el-col :span="10"><img v-if="v.sto_image!=''" style="display:flex; margin-top: 20px;n width: 140px;height: 100px;" :src="'http://localhost:5000/'+v.message"/></el-col>
                </el-row>
                <el-row>
                  
                  
                </el-row>
                  <span v-if="v.receive" class="dot"></span>
                   <img v-if="v.sto_image!=''" style="margin-left: 140px;margin-top: -50px;max-width: 70px;max-height: 70px;" :src="'http://localhost:5000/'+v.message" class="image"/>
                </div>
              <br> -->
              <div style="display: flex; align-items: center;">
              <div style="flex: 1; margin-right: 20px;">
                  <span style="font-size: large;">{{v.name}}</span>
                  <br>
                  <span>{{v.chat_time}}</span>
                  <br>
                  <span>{{ "  " }}</span>
                  <div v-if="v.chat_type" style="margin-top: -20px;">
                      <span>[图片]</span>
                  </div>
                  <div v-else style="margin-top: -10px;width: 70px;">
                      <span>{{v.message}}</span>
                  </div>
              </div>
              <div>
                  <span v-if="v.receive" class="dot"></span>
                  <img v-if="v.sto_image!=''" style="width: 140px;height: 100px;" :src="'http://localhost:5000/'+v.sto_image"/>
              </div>
          </div>
            </el-menu-item>
          </div>
        </el-menu>
        </el-aside>
        <!-- <el-main style="background-color: #fef0f0;height: 750px;background-image: url('../assets/background2.png');"> -->
        <el-main style="height: 750px; max-width:1200px" class="main-card">
      
    <el-card v-if="chat_member!=''" class="box-card" :body-style="{ padding: '0px' }">
      <template #header>
        <div class="card-header">
          <span style="color: aliceblue;font-size: 20px;width: 400px;">{{chat_member_name}}</span>
          <span style="display:flex; color:lime;margin-left: -120%;font-size: 10px;margin-top: 5%;">在线</span>
          <span style="color:blanchedalmond;">友善发言，和平上网</span>
        </div>
      </template>
      <el-scrollbar class="scrollbar" ref="scrollbarRef" always>
        <div ref="innerRef">
      <div v-for="v in messages" :key="v.id">
        <div v-if="v.user===user_id">
          <el-button v-if="v.id!=''" style="border-radius: 50%;margin-top: 40px;margin-left: 92%; height: 70px;width: 70px;background-color: #c45656;color: #fef0f0;" type="warning" plain>{{ my_name }}</el-button>
          <div v-if="v.chat_type">
            <el-card v-if="v.id!=''" class="my-chat-bubble" >
              <time class="time">{{ v.id }}</time>
              <img :src="'http://localhost:5000/'+v.message" class="image"/>
            </el-card>
          </div>
          <div v-else>
            <el-card v-if="v.id!=''" class="my-chat-bubble">
              <!--{{ v.id+" "+v.user + " : " + v.message }}-->
              <time class="time">{{ v.id }}</time>
              <br>
              {{ v.message }}
            </el-card>
          </div>
        </div>
        <div v-else>
          <el-button v-if="v.id!=''" style="border-radius: 50%;margin-top: 40px; height: 70px;width: 70px;background-color: #c45656;color: #fef0f0;" type="warning" plain>{{ chat_member_name }}</el-button>
          <div v-if="v.chat_type">
            <el-card v-if="v.id!=''" class="chat-bubble" >
              <time class="oppo-time">{{ v.id }}</time>
              <img :src="'http://localhost:5000/'+v.message" class="image"/>
            </el-card>
          </div>
          <div v-else>
            <el-card v-if="v.id!=''" class="chat-bubble">
              <time class="oppo-time">{{ v.id }}</time>
              <br>
              {{ v.message }}
            </el-card>
          </div>
        </div>
      </div>
    </div>
      </el-scrollbar>
    </el-card>
    <div v-if="chat_member!=''" style="width: 800px;">
      <el-row :gutter="20">
      <el-col>
            <el-upload
              ref="uploadRef"
              action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15"
              :auto-upload="false"
              v-model:file-list='fileList'
              limit="1"
            >
              <template #trigger>
                <el-button type="danger" class="image-input" :icon="UploadFilled">上传图片</el-button>
              </template>
            </el-upload>
      </el-col>
      <el-col>
            <el-input v-model="messageText" autosize type="textarea" class="chat-input">
            </el-input>
      </el-col>
            <el-button type="danger" plain class="chat-send" size="large" @click="sendMessage" :disabled="isdiabled" :icon="Promotion">发送</el-button>
      </el-row>
    </div>
    </el-main>
    </el-container>
  </template>
  
  <script setup lang="ts">
  import * as signalR from '@microsoft/signalr'
  import { ConsoleLogger } from '@microsoft/signalr/dist/esm/Utils';
  import { Message,ElScrollbar as ElScrollbarType } from 'element-plus';
  
  const innerRef = ref<HTMLDivElement>()
  const scrollbarRef = ref<InstanceType<typeof ElScrollbarType>>()
  
  import { onMounted, ref } from 'vue';
  import { toRaw } from'@vue/reactivity';
  import { UploadFilled ,Promotion,House} from '@element-plus/icons-vue'
  
      const connection = ref<any>(null);
      const messageText = ref('');
      const messages = ref([{
        id:"",
        user:"",
        message:"",
        chat_type:false
      }]);
  
      const chatlist = ref([{
        user:"",
        message:"",
        chat_type:false,
        name:"",
        receive:false,
        sto_image:'',
        chat_time:''
      }]);
      
    import { useRouter, useRoute } from 'vue-router';
  import axios from 'axios';
  import { fa } from 'element-plus/es/locale';
    const route = useRoute();
    const router = useRouter();
    
    //const user_ID=ref("")//ref(route.query.id as any)
    const user_id=ref("")
    const chat_member=ref("")
    const chat_member_name=ref('')
    const cus_ID=ref("")
    const sto_ID=ref("")
    const user_type=ref("")
    const isdiabled=ref(true)
    const fileList = ref([]);
    const receive_id=ref('')
    const my_name=ref('')
  
    const address='http://localhost:5000/api/pub/'
  
    type Chat= {
        chatTime: string;
        cusID: string;
        storeID: string;
        chatContent:string;
        chatSender:boolean;
        chatType:boolean;
      }
  onMounted(async () => {
      console.log(cus_ID.value)
      console.log(sto_ID.value)
      user_type.value=sessionStorage.getItem('user_type') as string
      if(user_type.value==="0"){
        cus_ID.value=sessionStorage.getItem('cus_id') as string
        user_id.value=cus_ID.value as any
        const response = await axios.get(address+'getinformation/customer', { params: {cus_ID:user_id.value } });
            if (response.status === 200) {
            my_name.value = response.data.cus_nickname;
            }
      }else{
        sto_ID.value=sessionStorage.getItem('sto_id') as string
        user_id.value=sto_ID.value as any
        const response = await axios.get(address+'getinformation/store', { params: {sto_ID:user_id.value} });
            if (response.status === 200) {
            my_name.value=response.data.sto_name
            }
      }
      console.log(user_id.value)
      connection.value = new signalR.HubConnectionBuilder()
        .withUrl('http://localhost:5000/chat?user_Id='+user_id.value,{
        skipNegotiation: true,
        transport: signalR.HttpTransportType.WebSockets
      }) // Use the Hub endpoint URL
      .build();
    
    const onReceiveMessage = async (message_:Chat) => {
        const obj=toRaw(message_)
        const user=ref('')
        if(obj.chatSender===false){
        user.value=obj.cusID
      }else{
        user.value=obj.storeID
      }
      
      if(chat_member.value==user.value){
        await messages.value.push({ id: obj.chatTime, user:user.value, message:obj.chatContent,chat_type:obj.chatType });
        scrollbarRef.value!.setScrollTop(innerRef.value!.clientHeight)
      }
      else{
        receive_id.value=user.value
      }
        connection.value.invoke('GetChatList',user_id.value)
      };
    const onGetChatHistory=async (chatHistory: Array<Chat>)=>{
        messages.value=[{
        id:"",
        user:"",
        message:"",
        chat_type:true
      }]
        const ChatList=toRaw(chatHistory)
        //console.log("ChatlistObj:  "+ChatList[1].chatType)
      await ChatList.forEach(content => {
        //console.log(content["ChatContent"].toString())
        if(content.chatSender===false)
          messages.value.push({ id: content.chatTime, user:content.cusID.toString(), message:content.chatContent,chat_type:content.chatType })
        else
          messages.value.push({ id: content.chatTime, user:content.storeID.toString(), message:content.chatContent,chat_type:content.chatType })
      });
      scrollbarRef.value!.setScrollTop(innerRef.value!.clientHeight)
      }
  
    const onGetChatList=async (chatList:Array<Chat>)=>{
        chatList=toRaw(chatList)
        console.log("Chatlist:  "+chatList)
        chatlist.value=[{
        user:"",
        message:"",
        chat_type:false,
        name:"",
        receive:false,
        sto_image:'',
        chat_time:''
      }]
        chatList.forEach(async content => {
        const if_receive=ref(false)
        //console.log(content["ChatContent"].toString())
        if(content.chatContent.length>8){
          content.chatContent=content.chatContent.slice(0,8)
          content.chatContent+='...'
              }
        if(user_type.value==="0")
          {
            if(content.storeID.toString()===receive_id.value){
              if_receive.value=true;
              receive_id.value=''
            }
            const name=ref('')
            const image=ref('')
            const response = await axios.get(address+'getinformation/store', { params: {sto_ID:content.storeID.toString() } });
            if (response.status === 200) {
              const response1=await axios.get('api/pub/getinformation/storeimg',{ params: {sto_ID:content.storeID.toString() } });
            image.value=response1.data.imageURL
            name.value = response.data.sto_name;
            }
            chatlist.value.push({ user:content.storeID.toString(), message:content.chatContent,chat_type:content.chatType,name:name.value,receive:if_receive.value,sto_image:image.value,chat_time:content.chatTime})
          }
        else
          {
            if(content.cusID.toString()===receive_id.value){
              if_receive.value=true;
              receive_id.value=''
            }
            const name=ref('')
            const response = await axios.get(address+'getinformation/customer', { params: {cus_ID:content.cusID.toString() } });
            if (response.status === 200) {
            name.value = response.data.cus_nickname;
            }
            chatlist.value.push({ user:content.cusID.toString(), message:content.chatContent ,chat_type:content.chatType,name:name.value,receive:if_receive.value,sto_image:'',chat_time:content.chatTime})
            
          }
      });
      
    }
  
    connection.value.on('ReceiveMessage', onReceiveMessage);
    connection.value.on('ReceiveChatHistory',onGetChatHistory);
    connection.value.on('ReceiveChatList',onGetChatList)
  
    connection.value.start()
      .then(async () => {
        console.log('Connected to SignalR Hub');
        await connection.value.invoke('GetChatList',user_id.value)
        console.log(chatlist.value)
        if(route.query.sto_id!=""){
          if(user_type.value==="0"){
            chat_member.value=route.query.sto_id as string
            sto_ID.value=chat_member.value
            const response = await axios.get(address+'getinformation/store', { params: {sto_ID:sto_ID.value } });
            if (response.status === 200) {
            chat_member_name.value = response.data.sto_name;
            }
            isdiabled.value=false
          }
            connection.value.invoke('GetChatHistory',cus_ID.value,sto_ID.value)
  
        }else if(chatlist.value.length>1){
          if(user_type.value==="0"){
            chat_member.value=chatlist.value[1].user
            sto_ID.value=chat_member.value
            const response = await axios.get(address+'getinformation/store', { params: {sto_ID:sto_ID.value } });
            if (response.status === 200) {
            chat_member_name.value = response.data.sto_name;
            }
            isdiabled.value=false
          }
          else if(user_type.value==="1"){
            chat_member.value=chatlist.value[1].user
            cus_ID.value=chat_member.value
            const response = await axios.get(address+'getinformation/customer', { params: {cus_ID:cus_ID.value } });
            if (response.status === 200) {
            chat_member_name.value = response.data.cus_nickname;
            }
            isdiabled.value=false
          }
            connection.value.invoke('GetChatHistory',cus_ID.value,sto_ID.value)
        }
        else{
          chat_member.value="您暂时还没有聊天对象！"
        }
  
      })
      .catch((error: any) => {
        console.error(error);
      });
  });
  
  
  
  const sendMessage = async () => {
    if(messageText.value!=''){
      const currentTimestamp = Math.floor(Date.now() / 1000);
  
      // 使用Date对象将时间戳转换为标准日期时间格式
      const date = new Date(currentTimestamp * 1000); // Multiply by 1000 to convert seconds to milliseconds
  
      // 使用toLocaleString()方法获取标准日期时间格式
      const formattedDateTime = date.toLocaleString('chinese',{ hour12: false });
      const sendmessage=ref(null as any)
      if(user_type.value==="1"){
        sendmessage.value=connection.value.invoke('SendMessage',formattedDateTime,cus_ID.value,sto_ID.value, messageText.value,true,false)
      }else{
        sendmessage.value=connection.value.invoke('SendMessage',formattedDateTime,cus_ID.value,sto_ID.value, messageText.value,false,false)
      }
      
      await messages.value.push({ id: formattedDateTime, user:user_id.value.toString(), message:messageText.value ,chat_type:false});
    }else if(fileList.value.length>0){
      const formData = new FormData();
      await fileList.value.forEach((file) => {
          formData.append('image', file.raw); // 将文件添加到FormData中
        });
      const response = await axios.post(address+'uploadchatimage', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
  
      if (response.status === 200) {
        const data = response.data;
        if (data.message === 'success') {
          messageText.value=data.url
        } 
      } else {
        console.error(`Error: HTTP status code ${response.status}`);
      }
      
      const currentTimestamp = Math.floor(Date.now() / 1000);
  
      // 使用Date对象将时间戳转换为标准日期时间格式
      const date = new Date(currentTimestamp * 1000); // Multiply by 1000 to convert seconds to milliseconds
  
      // 使用toLocaleString()方法获取标准日期时间格式
      const formattedDateTime = date.toLocaleString('chinese',{ hour12: false });
  
      if(user_type.value==="1"){
        connection.value.invoke('SendMessage',formattedDateTime,cus_ID.value,sto_ID.value, messageText.value,true,true)
      }else{
        connection.value.invoke('SendMessage',formattedDateTime,cus_ID.value,sto_ID.value, messageText.value,false,true)
      }
  
      await messages.value.push({ id: formattedDateTime, user:user_id.value.toString(), message:messageText.value,chat_type:true });
  
      fileList.value=[]
  
    }
      messageText.value = '';
      //messageText.value = '';
      await connection.value.invoke('GetChatList',user_id.value)
      scrollbarRef.value!.setScrollTop(innerRef.value!.clientHeight)
  };
  
  const exchange_chat_member=async (now_id:string)=>{
      console.log(user_type.value)
      if(user_type.value=="0"){
        sto_ID.value=now_id
        chat_member.value=now_id
        const response = await axios.get(address+'getinformation/store', { params: {sto_ID:sto_ID.value } });
            if (response.status === 200) {
            chat_member_name.value = response.data.sto_name;
            }
      }
      else{
        cus_ID.value=now_id
        chat_member.value=now_id
        const response = await axios.get(address+'getinformation/customer', { params: {cus_ID:cus_ID.value } });
            if (response.status === 200) {
            chat_member_name.value = response.data.cus_nickname;
            }
      }
      isdiabled.value=false
      console.log(cus_ID.value+"+"+sto_ID.value)
      receive_id.value=''
      chatlist.value.forEach(content => {
        //console.log(content["ChatContent"].toString())
        if(content.user===now_id)
        content.receive=false
      });
      connection.value.invoke('GetChatHistory',cus_ID.value,sto_ID.value)
  }
  
  const goBacktoPer=()=>{
    router.go(-1)
  }
  </script>
  
  <style scoped>
  .chat-list{
    display: flex;
    margin-left: 40%;
    font-size: 30px;
    color: #c45656;
    font-family:'KaiTi';
  }
  .el-menu-item.is-active {
    background: #fab6b6 !important;
  }
  
  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #A80E0E;
  }
  
  .box-card {
    background-color: #A80E0E;
    width: 1105px;
    height:605px;
  }
  
  .scrollbar{
    /* background-color:rgba(255, 229, 229,1.80); */
    background-image: url('../assets/background2.png');
    opacity: 0.6;
    background-size: cover;
    background-position: center;
    height: 500px;
  }
  
  .main-card{
    /* background-color:rgba(255, 229, 229,1.80); */
    background-image: url('../assets/background2.png');
    background-size: cover;
    background-position: center;
    height: 500px;
  }

  .chat-send{
    display: flex;
    margin-left: 120%;
    width: 70px;
    height:40px;
    margin-top: -45px;
    border-radius: 15%;
  }
  
  .chat-input{
    display:flex;
    margin-left: 15%;
    width: 820px;
    height: 10px;
    border-radius: 50%;
    margin-top: -42px;
  }
  
  .image-input{
    display: inline-block;
    margin-right: 0%;
    margin-top: 30%;
    border-radius: 20px;
    width:110px;
  }
  
  .chat-bubble {
    background-color: rgba(236, 245, 255,0.99);
    color: #7b7b51; /* 设置气泡文本的颜色 */
    padding: 2px;
    border-radius: 5px;
    max-width: 30%; /* 设置气泡的最大宽度 */
    margin-top: -75px;
    margin-left: 8%;
    font-size: 20px;
  }
  
  .my-chat-bubble {
    background-color: #A80E0E; /* 设置气泡的背景颜色 */
    color: #ffffff; /* 设置气泡文本的颜色 */
    padding: 2px;
    border-radius: 5px;
    max-width: 30%; /* 设置气泡的最大宽度 */
    margin-top: -75px;
    margin-left: 60%;
    font-size: 20px;
  }
  
  .image {
    width: 100%;
    display: block;
  }
  
  .time {
    font-size: 10px;
    color: #ffffff;
  }

  .oppo-time{
    font-size: 10px;
    color: #000000;
  }
  
  .chatmember{
    border-style:solid;
    border-color:rgb(198, 198, 198);
    padding: 15px;
    width: 100%; /* 设置气泡的最大宽度 */
    height: 130px;
  }
  
  .view:hover {
      background-color: #3f9eff;
      color: #fff;
      border-color: #3f9eff;
    }
    .view {
      color: #409eff;
      background: #ecf5ff;
      border-color: #b3d8ff;
    }
    :deep(.el-textarea__inner) {
      border-radius: 95px;
  }
  
  .dot {
  position: absolute;
  top: 0;
  right: 0;
  /* display: inline-block; */
  /* vertical-align: top; */
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: #ff4d4f;
  }
  
  .el-header {
    background-color: #A80E0E;
    display: flex;
    justify-content: space-between;
    /* padding-left: 100px; */
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
  </style>