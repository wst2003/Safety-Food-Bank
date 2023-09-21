# 项目开发环境

* Windows 系统
* 后端：Visual Studio 2022、`C#` + `.NET 6.0`
* 前端：Visual Studio Code、Vue-cli3、node.js
* 请务必确保启动项目时，启动设备具备上述环境

# 项目结构

* 本项目的项目结构如下图所示：

```bash
/release
├── AlipayServe/
|  ├── alipay.js
|  ├── app.js
|  ├── node_modules/
|  ├── package-lock.json
|  ├── package.json
|  └── readme.txt
├── backend/
|  ├── Backup/
|  └── DBproject/
|     ├── Algorithms/
|     ├── Controllers/
|     |  └── xxx.cs
|     ├── Hubs/
|     ├── LocationSort/
|     ├── Models/
|     ├── Properties/
|     ├── bin/
|     |  └── Debug/  
|     ├── obj/
|     └── wwwroot/
└── frontend/
   ├── node_modules/
   ├── public/
   ├── router/
   └── src/
      ├── assets/
      ├── components/
      |  ├── AdministratorSystem/
      |  	└── xxx.vue
      |  ├── StoreSystem/
      |  |  └── xxx.vue
      |  └── cusSystem/
      |     └── homepages/
      └── dist/
```

* 其中 `AlipayServe` 文件夹中保存着支付宝付款的相关组件；`backend` 文件夹下保存着后端的代码，其中 `wwwroot` 文件夹中保存着静态资源，`Algorithm` 文件夹下保存着推荐算法的各个文件，`Controllers` 文件夹中保存着各个系统的后端 `controller` ；`frontend` 文件夹下保存着所有的前端代码，其中`router` 文件夹中包含着本项目关于页面跳转的路由文件， `src` 文件夹中包含着三个子系统的前端文件，`assets` 文件夹中包含着页面背景图片在内的前端图片资源，`AdministratorSystem` 文件夹中包含着管理员系统的代码，`StoreSystem` 文件夹中包含着商家系统的代码，`cusSystem` 文件夹中包含着顾客系统的代码。

# 如何运行本项目

* 修改 frontend/router/baseURL、frontend/vue.config.js 中的 url 路径，确保其与服务器地址一致。
* 使用 Visual Studio 2022 打开 backend 文件夹中的 `.sln` 文件，启动后端项目，点击运行按钮运行本项目从而启动后端
* 进入 AlipayServe 文件夹，打开命令提示符（cmd窗口），输入`node app.js` 启动支付宝组件
* 在命令提示符中进入 frontend 文件夹，输入 `npm run serve` 启动前端代码。
* 至此，项目已经可以正常使用。

# 项目截图

* 登录页面：

![image-20230909165912170](image\image-20230909165912170.png)

* 注册页面：

![image-20230909165930480](image\image-20230909165930480.png)

* 管理员页面：

![image-20230909165951623](image\image-20230909165951623.png)

* 顾客页面：

![image-20230909170013061](image\image-20230909170013061.png)

* 商户页面：

![image-20230909170031009](image\image-20230909170031009.png)