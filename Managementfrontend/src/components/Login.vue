<!-- Login -->
<template>
    <div class="Login">
        <div class="card login-block">
            <div class="banner">管理员登录</div>
            <div class="line-item">
                <el-image class="username-icon" :src="require('@/assets/img/username.svg')"></el-image>
                <input class="input" type="text" v-model="username" placeholder="请输入用户名" />
            </div>
            <div class="line-item">
                <el-image class="password-icon" :src="require('@/assets/img/password.svg')"></el-image>
                <input class="input" type="text" v-model="password" placeholder="输入密码" />
            </div>

            <div class="submit" @click="login">登录</div>
        </div>
    </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;
import { Message } from "element-ui";
import axios from "axios";
export default {
    components: {},
    props: [],
    data() {
        return {
            username: "",
            password: "",
        }

    },
    //监听属性 类似于data概念
    computed: {},
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {
        login() {
            // console.log(">????");
            this.$api.AuthService.get_csrf();
            //axios.get("/api/csrf/") ;// Django接口地址
            if (this.username == "" || this.password == "") {
                Message.warning("账号或密码不能为空");
                return;
            }
            this.$api.AuthService.authorize(this.username, this.password).then((data) => {
                // console.log(data);
                if (data.status >= 400) {
                    Message.error("账号或密码错误");
                    return;
                }
                this.Success(data);
            }).catch((error) => {
                console.log(error);
            });
        },
        Success(data) {
            Message.success("登录成功");
            this.$router.replace({
                path: "/",
            });
        },
        // 初始化 判断是否登录
        init() {
            this.$api.AuthService.checklogin().then((data) => {
                // 登录成功
                //this.$router.replace({ path: "/" });
                console.log(data);
                if (data.status >= 400) {
                    console.log("未登录");
                }
                else { this.$router.replace({ path: "/" }); }
                return;

            }
            ).catch((error) => {
                // 登录失败
                console.log("未登录");
            });
        },
    },
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        this.init();
    },
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
.Login {
    display: block;
    position: relative;
    padding: 10px;
    height: 100%;
    width: 100%;
    background-color: #2d72cca1;
    user-select: none;
}

.line-item {
    margin: 10px 0;
}

.login-block {
    position: absolute;
    left: calc(50% - 170px);
    top: calc(50% - 210px);
    width: 340px;
    height: auto;
    border-radius: 10px;
    padding: 10px;
    background-color: #fff;

    .banner {
        margin-bottom: 20px;
        line-height: 60px;
        font-size: 25px;
        font-weight: 500;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    .username-icon {
        display: inline-block;
        position: absolute;
        width: 30px;
        top: 96px;
        left: 32px;
        user-select: none;
    }

    .password-icon {
        display: inline-block;
        position: absolute;
        width: 30px;
        top: 156px;
        left: 32px;
        user-select: none;
    }

    .input {
        display: inline-block;
        margin-left: 5%;
        padding-left: 40px;
        width: 90%;
    }

    .submit {
        margin: auto;
        margin-top: 20px;
        margin-bottom: 30px;
        width: 90%;
        height: 36px;
        line-height: 36px;
        text-align: center;
        background: #3370ffc0;
        color: #fff;
        border-radius: 6px;
        cursor: pointer;
    }
}
</style>
