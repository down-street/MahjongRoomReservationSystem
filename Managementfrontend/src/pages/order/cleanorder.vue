<!-- User -->
<template>
    <div class="User">
        <div class="receive-show">
            <el-empty v-if="list == []" :image-size="300"> </el-empty>
            <div v-else style="width: 100%; height: 100%; margin: 20px">
                <el-table :data="list.filter(
                    (data) =>
                        !search ||
                        data.nickName
                            .toLowerCase()
                            .includes(search.toLowerCase())
                )
                    " :stripe="true" style="width: calc(100% - 30px)" @selection-change="handleSelectionChange">
                    <el-table-column prop="room_name" label="房间名称" width="170">
                    </el-table-column>

                    <el-table-column label="操作" align="left" style="align-items: right">

                        <template slot-scope="scope">
                            <el-button size="mini" type="success"
                                @click="handleSuccess(scope.$index, scope.row)">确认清洁完成</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-if="list != []" class="pagination" background layout="prev, pager, next"
                    :page-size="pageSize" :total="totalElements" @current-change="pageChange">
                </el-pagination>
            </div>
        </div>

    </div>
</template>

<script>

import { Message } from "element-ui";
//这里可以导入其他文件（比如：组件，工具js，第三方插件js，json文件，图片文件等等）
//例如：import 《组件名称》 from ‘《组件路径》‘;

export default {
    name: "User",
    components: {},
    props: [],
    data() {
        //这里存放数据
        return {
            pageSize: 10,
            totalElements: 0,
            pageIdx: 0,
            search: "",
            list: [],
            // 对话框
            editdialogFormVisible: false,
            adddialogFormVisible: false,
            formIdx: -1,
            // 对话框数据
            addform: {},
            editform: {},
            formLabelWidth: "80px",
        };
    },
    //监听属性 类似于data概念
    computed: {
    },
    //监控data中的数据变化
    watch: {},
    //方法集合
    methods: {
        // 获取所有用户
        getallorder() {
            this.$api.OrderService.getallcleanorder().then((data) => {
                
                this.list = data.cleanorder;
                console.log(this.list);
                //console.log(Array.isArray(this.list), this.list);

            });
        },
        // 页面改版
        pageChange(val) {
            this.pageIdx = val - 1;
            this.getallorder();
        },
        // 选择变化
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        handleSuccess(index, row) {
            let that = this;
            console.log(index, row);
            this.$confirm("请确认已清洁完毕")
                .then((_) => {
                    console.log("yes");
                    console.log(row);
                    this.$api.OrderService.successcleanorder(row.cleanorder_id).then((data) => {
                        Message.success("成功提交");
                        that.getallorder();
                    });
                    done();
                })
                .catch((_) => { });
        }
    },
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        setTimeout(() => this.getallorder(), 300);
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
.User {
    padding: 20px;
    background-color: #fff;
    width: 100%;
    height: 100%;
}

.receive-show {
    height: calc(100% - 60px);
    width: 100%;

    .pagination {
        margin-top: 26px;
    }
}

.inputbar {
    width: 60%;
}
</style>
