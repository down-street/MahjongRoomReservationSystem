<!-- FirstLeftBody -->
<template>
    <div class="chart2">
        <div class="card table" id="c2"></div>
        <div class="card table" id="c3"></div>
    </div>
</template>

<script>
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;
import * as echarts from "echarts";

export default {
    name: "chart2",
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
            opt2: {
                title: {
                    text: "棋牌室状态",
                    textStyle: {
                        //标题内容的样式
                        color: "#666",
                        fontStyle: "normal", //lic主标题文字字体风格，默认normal，有italic(斜体),oblique(斜体)
                        fontWeight: "500", //可选normal(正常)，bold(加粗)，bolder(加粗)，lighter(变细)，100|200|300|400|500...
                        fontFamily: "san-serif", //主题文字字体，默认微软雅黑
                        fontSize: 16, //主题文字字体大小，默认为18px
                    },
                    left: 6,
                    top: 8,
                },
                tooltip: {
                    trigger: "item",
                },
                series: [
                    {
                        type: "pie",
                        radius: ["0%", "80%"],
                        avoidLabelOverlap: false,
                        center: ["56%", "55%"],
                        itemStyle: {
                            borderRadius: 6,
                            borderWidth: 0,
                        },
                        label: {
                            show: true,
                            formatter: "{b}:{c}\n{d}%",
                            position: "inner",
                            textStyle: { fontSize: 10 },
                        },
                        data: [
                            { value: 384, name: "学生" },
                            { value: 80, name: "老师" },
                            { value: 40, name: "家属" },
                            { value: 20, name: "其他" },
                        ],
                    },
                ],
            },
            opt3: {
                title: {
                    text: "服务人员统计",
                    textStyle: {
                        //标题内容的样式
                        color: "#666",
                        fontStyle: "normal", //lic主标题文字字体风格，默认normal，有italic(斜体),oblique(斜体)
                        fontWeight: "500", //可选normal(正常)，bold(加粗)，bolder(加粗)，lighter(变细)，100|200|300|400|500...
                        fontFamily: "san-serif", //主题文字字体，默认微软雅黑
                        fontSize: 16, //主题文字字体大小，默认为18px
                    },
                    left: 6,
                    top: 8,
                },
                tooltip: {
                    trigger: "item",
                },
                series: [
                    {
                        type: "pie",
                        radius: ["40%", "80%"],
                        center: ["55%", "55%"],
                        avoidLabelOverlap: false,
                        itemStyle: {
                            borderRadius: 4,
                            borderWidth: 3,
                        },
                        label: {
                            show: true,
                            formatter: "{b}:{c}\n{d}%",
                            position: "inner",
                            textStyle: { fontSize: 10 },
                        },
                        data: [
                            { value: 484, name: "男生" },
                            { value: 300, name: "女生" },
                        ],
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
    methods: {},
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        //console.log(this.opt2.series[0].data);

       //console.log(this.opt2.series[0].data);
        this.opt2.series[0].data = Object.entries(this.data['chart2']).map(
            ([key, value]) => ({ name: key, value: value })
        );

        //console.log(this.opt2.series[0].data);
        this.opt3.series[0].data = Object.entries(this.data['chart3']).map(
            ([key, value]) => ({ name: key, value: value })
        );

        let c2 = echarts.init(document.getElementById("c2"));
        let c3 = echarts.init(document.getElementById("c3"));
        c2.setOption(this.opt2);
        c3.setOption(this.opt3);
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
.chart2 {
    width: 100%;
    height: 100%;
    padding: 0 20px;
}

.table {
    float: left;
    height: calc(100% - 40px);
    margin: 20px 15px;
    width: calc(50% - 30px);
    background-color: #fff;
}
</style>
