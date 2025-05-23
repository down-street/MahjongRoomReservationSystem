import Vue from "vue";
//引入VueRouter
import VueRouter from "vue-router";
// 我的子router
import routers from "./routers";
Vue.use(VueRouter); // 应用插件

//创建router实例对象，去管理一组一组的路由规则
const router = new VueRouter({
    // mode:"history",
    routes: [
        {
            path: "/",
            component: (resolve) => require(["@/components/Index"], resolve),
            children: routers,
        },
        {
            path: "/login",
            name: "login",
            component: (resolve) => require(["@/components/Login"], resolve),
        },

        {
            path: "/404",
            name: "page404",
            component: (resolve) => require(["@/components/NotFound"], resolve),
        },
    ],
});

//暴露router
export default router;

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
    return originalPush.call(this, location).catch(err => err)
}