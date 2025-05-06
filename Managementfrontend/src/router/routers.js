export default [
    // home
    {
        path: "/home",
        component: (resolve) => require(["@/pages/home/Home"], resolve),
    },
    {
        path: "/",
        component: (resolve) => require(["@/pages/home/Home"], resolve),
    },
    // user
    {
        path: "staff",
        component: (resolve) => require(["@/pages/user/Staff"], resolve),
    },
    {
        path: "customer",
        component: (resolve) => require(["@/pages/user/Customer"], resolve),
    },
    // info
    {
        path: "roominfo",
        component: (resolve) => require(["@/pages/infomanagement/roominfo"], resolve),
    },
    {
        path: "goodsinfo",
        component: (resolve) => require(["@/pages/infomanagement/goodsinfo"], resolve),
    },

    // order
    {
        path: "goodsorder",
        component: (resolve) =>require(["@/pages/order/goodsorder"], resolve),
    },
    {
        path: "cleanorder",
        component: (resolve) => require(["@/pages/order/cleanorder"], resolve),
    },
    // billboard
    {
        path: "billboard",
        component: (resolve) => require(["@/pages/announcement/announcement"], resolve),
    },
    // settings
    {
        path: "settings",
        component: (resolve) => require(["@/pages/setting/Settings"], resolve),
    },
];
