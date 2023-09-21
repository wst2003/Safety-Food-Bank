import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import VForm3 from 'vform3-builds'  //引入VForm3库
import 'element-plus/dist/index.css'
import App from './App.vue'
import * as echarts from 'echarts/core';
import { TitleComponent } from 'echarts/components';

import router from '../router/index.js'; // 导入路由实例
const app = createApp(App)
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import 'vform3-builds/dist/designer.style.css'  //引入VForm3样式
echarts.use([TitleComponent]);

window.addEventListener('unhandledrejection', event => {
  // 阻止默认的处理方式（即将错误信息输出到控制台）
  event.preventDefault();

  // 打印错误详情
  console.error('Unhandled promise rejection:', event.reason);
});

for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }

  app.config.errorHandler = function(err) {
    console.log("global", err);
  };
  

app.use(router)
app.use(ElementPlus)
app.use(VForm3)
app.mount('#app')
window.onerror = function (errorMessage, scriptURI, lineNumber, columnNumber, error) {
  return true;
};

