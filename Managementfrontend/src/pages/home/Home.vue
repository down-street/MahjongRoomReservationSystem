<!-- Home -->
<template>
    <div class="Home" id="home">
        <div class="layout1" v-if="chartData1">
            <chart1 :data="chartData1" />
        </div>
        <div class="layout2" v-if="chartData2">
            <chart2 :data="chartData2" />
        </div>
        <div class="layout3" v-if="chartData3">
            <chart3 :data="chartData3" />
        </div>
    </div>
</template>


<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;
import axios from "axios";
import chart1 from "./chart1.vue";
import chart2 from "./chart2.vue";
import chart3 from "./chart3.vue";
export default {
    name: "Home",
    components: {
        chart1,
        chart2,
        chart3,
    },
    props: [],
    data() {
        return {
            chartData: {},
            chartData1: null,
            chartData2: null,
            chartData3: null,
        };
    },

    //监听属性 类似于data概念
    computed: {},
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {
        fetchData() {
            axios.get("/api/hdata/") // Django接口地址
                .then((response) => {
                    this.chartData = response.data;
                    //console.log(this.$store.state.user.hasLogin);
                    //console.log("获取数据成功：", this.chartData);
                    this.chartData1 = this.chartData['chart1'];
                    // console.log(this.chartData1);

                    this.chartData2 = {
                        chart2: this.chartData['chart2'],
                        chart3: this.chartData['chart3']
                    };
                    this.chartData3 = this.chartData['chart4'];
                })
                .catch((error) => {
                    console.error("获取数据失败：", error);
                });
        },
        checklogin() {
            console.log("checklogin");
            this.$api.AuthService.checklogin().then((data) => {
                console.log(data)

                //this.$router.replace({ path: "/login" });
                if (data.status >= 400) {
                    console.log("未登录");
                    this.$router.replace({ path: "/login" });
                }
                // } else {
                //     console.log("登录成功", res);
                // }
            }
            ).catch((error) => {
                // 登录失败
                console.log("未登录");
                this.$router.replace({ path: "/login" });
            });
        },
    },
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        
        this.checklogin();
        this.fetchData();
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
.Home {
    width: calc(100% - 100px);
    height: 100%;
    margin: 0;
    padding: 0;
    float: left;

    .layout1 {
        width: 100%;
        height: 30%;
        // background-color: #fff;
    }

    .layout2 {
        width: 100%;
        height: 40%;
        // background-color: #fff;
    }

    .layout3 {
        width: 100%;
        height: 30%;
        background-color: #eee;
    }
}
</style>
