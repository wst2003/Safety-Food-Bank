import { createRouter, createWebHistory } from 'vue-router';
import DetailPage from '../src/components/StoreSystem/DetailPage.vue'; // 导入相应的路由组件
import ViewPage from '../src/components/StoreSystem/ViewPage.vue'; // 导入相应的路由组件
import UploadCommodityPage from '../src/components/StoreSystem/UploadCommodityPage.vue'; // 导入相应的路由组件
import StorePage from '../src/components/StoreSystem/StorePage.vue'
import AdministratorPage from '../src/components/AdministratorSystem/AdministratorPage.vue';
import UpdateCommodityPageVue from '@/components/StoreSystem/UpdateCommodityPage.vue';
import VerificationPage from '@/components/StoreSystem/VerificationPage.vue';
import RefundPage from '@/components/StoreSystem/RefundPage.vue'
import OperatePage from '@/components/AdministratorSystem/OperatePage.vue';
import StoreCommodityPage from '@/components/AdministratorSystem/StoreCommodityPage.vue'
import StoreIndentPage from '@/components/AdministratorSystem/StoreIndentPage.vue'
import IndentDetailPage from '@/components/AdministratorSystem/IndentDetailPage.vue';
import AppealPage from '@/components/AdministratorSystem/AppealPage.vue';
import LoginPage from '../src/components/LoginPage.vue';
import IDLoginPage from '../src/components/IDLoginPage.vue'
import PhoneLoginPage from '../src/components/PhoneLoginPage.vue'
import FindPasswordPage from '../src/components/FindPasswordPage.vue'
import StoreRegister from '@/components/StoreRegister.vue';
import UserRegister from '@/components/UserRegister.vue';
import CustomerRegister from '@/components/CustomerRegisterPage.vue';
import UserInfo from '@/components/UserInfoPage.vue'
import ModifyCustomerInfo from '@/components/ModifyCustomerInfoPage.vue';
import ModifyStoreInfo from '@/components/ModifyStoreInfoPage.vue';
import ChatPage from '@/components/ChatPage.vue';
import MiddleTestPage from '@/components/MiddleTestPage.vue';
import SearchPage from '../src/components/cusSystem/homepages/SearchPage.vue';
import CommodityDetailPage from '../src/components/cusSystem/homepages/CommodityDetailPage.vue';
import storeDetaillPage from '../src/components/cusSystem/storeDetailPage.vue';
import PersonalFavorPage from '../src/components/cusSystem/homepages/PersonalFavorPage.vue'
import HistoryPage from '../src/components/cusSystem/homepages/HistoryPage.vue'
import ShoppingCartPage from '../src/components/cusSystem/homepages/ShoppingCartPage.vue'
import RecommendationPage from '../src/components/cusSystem/homepages/RecommendationPage.vue'
import IndentPage from '../src/components/cusSystem/homepages/IndentPage.vue'
import BlockUserPage from '../src/components/BlockUserPage.vue';
import HomePage from '../src/components/cusSystem/HomePage.vue';


const router = createRouter({
    history: createWebHistory(),
    routes: [
        {
            path: '/',
            redirect: "/login",
            meta: {
                keepAlive: true
            }
        },
        {
            path: '/home',
            component: HomePage,
            redirect: '/home/recommendation',
            children: [
                {
                    path: '/home/recommendation',
                    name: 'recommendation',
                    component: RecommendationPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
                {
                    path: '/home/search',
                    name: 'search',
                    component: SearchPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
                {
                    path: '/home/personalFavor',
                    name: 'personalFavor',
                    component: PersonalFavorPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
                {
                    path: '/home/commodityDetail',
                    name: 'commodityDetail',
                    component: CommodityDetailPage,
                },
                {
                    path: '/home/history',
                    name: 'history',
                    component: HistoryPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
                {
                    path: '/home/cart',
                    name: 'cart',
                    component: ShoppingCartPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
                {
                    path: '/home/indent',
                    name: 'indent',
                    component: IndentPage,
                    meta: {
                        keepAlive: true //需要被缓存
                    }
                },
            ]
        },
        {
            path: '/storeDetail',
            name: 'storeDetail',
            component: storeDetaillPage
        },
        {
            path: '/store',
            redirect: '/detail',
            component: StorePage,
            children: [
                {
                    path: '/detail',
                    component: DetailPage,
                    meta: {
                        keepAlive: true
                    }
                },
                {
                    path: '/view',
                    component: ViewPage
                },
                {
                    path: '/upload',
                    component: UploadCommodityPage
                },
                {
                    path: '/updateCommodity',
                    component: UpdateCommodityPageVue
                },
                {
                    path: '/verification',
                    component: VerificationPage
                },
                {
                    path: '/refund',
                    component: RefundPage
                }
            ]
        },
        {
            path: '/administrator',
            component: AdministratorPage,
            children: [
                {
                    path: '/operate',
                    component: OperatePage
                },
                {
                    path: '/commodity',
                    component: StoreCommodityPage,
                    meta: {
                        keepAlive: true
                    }
                },
                {
                    path: '/indent',
                    component: StoreIndentPage
                },
                {
                    path: '/indDetail',
                    component: IndentDetailPage
                },
                {
                    path: '/appeal',
                    component: AppealPage
                },

            ]
        },
        {
            path: '/login',
            component: LoginPage
        },
        {
            path: '/IDLogin',
            name: 'IDlogin',
            component: IDLoginPage
        },
        {
            path: '/phonelogin',
            name: 'phonelogin',
            component: PhoneLoginPage
        },
        {
            path: '/findpassword',
            name: 'findpassword',
            component: FindPasswordPage
        },
        {
            path: '/storeregister',
            name: 'storeregister',
            component: StoreRegister
        },
        {
            path: '/userregister',
            name: 'userregister',
            component: UserRegister
        },
        {
            path: '/customerregister',
            name: 'customerregister',
            component: CustomerRegister
        },
        {
            path: "/UserInfoPage",
            name: 'UserInfoPage',
            component: UserInfo
        },
        {
            path: '/ModifyCustomerInfoPage',
            name: 'ModifyCustomerInfoPage',
            component: ModifyCustomerInfo
        },
        {
            path: '/ModifyStoreInfoPage',
            name: 'ModifyStoreInfoPage',
            component: ModifyStoreInfo
        },
        {
            path: '/ChatPage',
            name: 'ChatPage',
            component: ChatPage
        },
        {
            path: '/BlockUserPage',
            name: 'BlockUserPage',
            component: BlockUserPage
        },
        {
            path: '/MiddleTest',
            name: 'MiddleTest',
            component: MiddleTestPage
        },
    ]
});

export default router;
