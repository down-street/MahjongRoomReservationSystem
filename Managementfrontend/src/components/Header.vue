<!-- Header -->
<template>
    <div class="Header">
        <div class="web-title">棋牌室后台管理系统</div>

        <div class="avatar-block">


            <img class="avatar" :src="require('@/assets/logo.png')" alt="头像" />
            <div class="hover-avatar">
                <div class="hover-item" style="color: #ff7070">
                    {{ this.username}}
                </div>
                <div class="hover-item" style="color: #ff7070" @click="logout">
                    登出
                </div>
            </div>
        </div>

    </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;

export default {
    components: {},
    props: [],
    data() {
        //这里存放数据
        return {
            username:null
        };
    },
    //监听属性 类似于data概念
    computed: {
    },
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {
        logout() {
            this.$api.AuthService.logout();
            this.$router.push({
                path: "login",
            });
        },
        init() {
            // console.log("init");
            this.$api.AuthService.checklogin().then((data) => {
                 //console.log(data)
                if (data.status >= 400) {
                    this.$router.replace({ path: "/login" });
                }
                this.username = data.username;
            });
        },
    },
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() { this.init(); },
    beforeCreate() { }, //生命周期 - 创建之前
    beforeMount() { }, //生命周期 - 挂载之前
    beforeUpdate() { }, //生命周期 - 更新之前
    updated() { }, //生命周期 - 更新之后
    beforeDestroy() { }, //生命周期 - 销毁之前
    destroyed() { }, //生命周期 - 销毁完成
    activated() { }, //如果页面有keep-alive缓存功能，这个函数会触发
};
</script>

<style lang="less" scoped>
.Header {
    display: block;
    margin: auto;
    width: 100%;
    transition: 0.4s linear;
}

@media screen and (min-width: 1920px) {
    .Header {
        width: 90%;
        transition: 0.4s linear;
    }
}

@media screen and (min-width: 2222px) {
    .Header {
        width: 80%;
        transition: 0.4s linear;
    }
}

.web-title {
    float: left;
    margin-left: 20px;
    font-size: 20px;
    font-weight: 600;
    color: #fff;
}

.school-block {
    display: inline;
    width: 100px;
    float: right;
    color: #f2f2f2;
    font-weight: 600;
}

.avatar-block {
    position: relative;
    margin-top: 10rpx;
    margin-right: 10px;
    float: right;
    width: 100px;
    text-align: center;

    .avatar {
        position: relative;
        margin: auto;
        margin-top: 7px;
        width: 46px;
        border-radius: 50%;
        cursor: pointer;
    }

    .login-text {
        margin: auto;
        float: right;
        text-align: center;
        width: 50px;
        cursor: pointer;
    }

    .hover-avatar {
        margin: auto;

        width: 80px;
        line-height: 40px;
        background-color: #a0c5f6;
        display: none;
        color: #fff;
        font-weight: 500;
        cursor: pointer;
        border-bottom-right-radius: 5px;
        border-bottom-left-radius: 5px;
        z-index: 999;
    }
}

.avatar-block:hover .hover-avatar {
    display: block;
    z-index: 999;
}

.hover-item:hover {
    background-color: #2d72cc61;
}
</style>
