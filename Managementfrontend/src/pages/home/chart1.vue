<!-- FirstLeftBody -->
<template>
    <div class="chart1">
        <div class="card table" id="c1"></div>
    </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;
import * as echarts from "echarts";

export default {
    name: "chart1",
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
            opt1: {
                title: {
                    text: "商品剩余数量",
                    textStyle: {
                        //标题内容的样式
                        color: "#666", //京东红
                        fontStyle: "normal", //lic主标题文字字体风格，默认normal，有italic(斜体),oblique(斜体)
                        fontWeight: "500", //可选normal(正常)，bold(加粗)，bolder(加粗)，lighter(变细)，100|200|300|400|500...
                        fontFamily: "san-serif", //主题文字字体，默认微软雅黑
                        fontSize: 16, //主题文字字体大小，默认为18px
                    },
                    left: 6,
                    top: 8,
                },
                tooltip: {
                    trigger: "axis",
                    axisPointer: {
                        type: "shadow",
                    },
                },
                grid: {
                    left: "0%",
                    right: "5%",
                    top: "8%",
                    bottom: "4%",
                    containLabel: true,
                },
                xAxis: [
                    {
                        type: "category",
                        data: [250, 244, 252, 228, 290, 360, 330],
                    },
                ],
                yAxis: [
                    {
                        show: false,
                    },
                ],
                series: [
                    {
                        type: "bar",
                        stack: "all",
                        emphasis: {
                            focus: "series",
                        },
                        data: [250, 244, 252, 228, 290, 360, 330],
                    }
                ],
            },

        };
    },
    //监听属性 类似于data概念
    computed: {},
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {},
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        //console.log(this.data)
        this.opt1.xAxis[0].data = Object.keys(this.data);
        this.opt1.series[0].data = Object.values(this.data);
        let c1 = echarts.init(document.getElementById("c1"));
        c1.setOption(this.opt1);
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
.chart1 {
    width: 100%;
    height: 100%;
    padding: 0 20px;
}

.table {
    float: left;
    height: calc(100% - 40px);
    margin: 20px 15px;
    background-color: #fff;
}
</style>
