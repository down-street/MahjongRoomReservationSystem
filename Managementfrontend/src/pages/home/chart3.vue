<!-- FirstLeftEnd -->
<template>
    <div class="chart3">
        <div class="card table fle2">
            <div class="fle-title">营业额统计</div>
            <div id="fle2"></div>
        </div>

    </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;
import * as echarts from "echarts";
import $ from "jquery";

// let myChart = echarts.init(document.getElementById("fle1"));
// let fle2 = echarts.init(document.getElementById("fle2"));

export default {
    name: "chart3",
    components: {},
    props: {
        data: {
            type: Object,
            default: () => ({}),
        },
    },
    data() {
        //这里存放数据
        return {
            opt1Data: [],
            optDataLength: 4,
            fle1: null,
            fle2: null,
            opt2: {
                tooltip: {
                    trigger: "axis",
                },
                legend: {
                    top: "bottom",
                    textStyle: {
                        //标题内容的样式
                        // color: "#666", //京东红
                        fontStyle: "normal", //lic主标题文字字体风格，默认normal，有italic(斜体),oblique(斜体)
                        fontWeight: "500", //可选normal(正常)，bold(加粗)，bolder(加粗)，lighter(变细)，100|200|300|400|500...
                        fontFamily: "san-serif", //主题文字字体，默认微软雅黑
                        fontSize: 10, //主题文字字体大小，默认为18px
                    },
                },
                grid: {
                    left: "3%",
                    right: "4%",
                    top: "3%",
                    bottom: "22%",
                    containLabel: true,
                },
                xAxis: {
                    type: "category",
                    boundaryGap: false,
                    data: ["8", "10", "12", "14", "16", "18", "20"],
                },
                yAxis: {
                    type: "value",
                },
                series: [
                    {
                        name: "商品",
                        type: "line",
                        data: this.data.item_income,
                    },
                    {
                        name: "棋牌室",
                        type: "line",
                        data: this.data.room_income,
                    },
                    {
                        name: "总计",
                        type: "line",
                        data: this.data.total_income,
                    },
                ],
            },
        };
    },
    //监听属性 类似于data概念
    computed: {},
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {
        // 初始化
        init() {
            let that = this;
            this.opt2.series[0].data = this.data.item_income;
            this.opt2.series[1].data = this.data.room_income;
            this.opt2.series[2].data = this.data.total_income;
            this.opt2.xAxis.data = this.data.date;
            this.fle2 = echarts.init(document.getElementById("fle2"));
            this.fle2.setOption(this.opt2);

        }
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
.chart3 {
    padding: 0 20px;
    width: 100%;
    height: 100%;

    .card {
        display: inline-block;
        background-color: #fff;
        padding: 10px 20px;
    }

    .fle-title {
        line-height: 30px;
        font-size: 18px;
        font-weight: 500;
        color: #666;
    }

    .fle2 {
        width: 100%;
        height: 100%;
    }

    #fle2 {
        height: calc(100% - 30px);
        width: 100%;
    }
}
</style>
