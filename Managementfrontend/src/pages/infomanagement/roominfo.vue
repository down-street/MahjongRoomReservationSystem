<!-- User -->
<template>
    <div class="User">
        <div style="float: left">
            <el-button @click="addroom()">新增房间</el-button>
        </div>
        <div class="receive-show">
            <el-empty v-if="list == []" :image-size="300"> </el-empty>
            <el-table :data="list.filter(
                (data) =>
                    !search ||
                    data.nickName
                        .toLowerCase()
                        .includes(search.toLowerCase())
            )" :stripe="true" style="width: calc(100% - 30px)" @selection-change="handleSelectionChange">
                <el-table-column fixed prop="name" label="房间名称" width="120" />
                <el-table-column fixed prop="description" label="房间描述" width="140" />
                <el-table-column fixed prop="price" label="房间价格(每小时)" width="140" />
                <el-table-column prop="status" label="房间使用状态" width="150" />
                <el-table-column prop="phone_number" label="顾客手机号" width="120" />
                <el-table-column prop="start_time" label="开始时间" width="100" />
                <el-table-column prop="end_time" label="结束时间" width="100" />

                <el-table-column label="操作" width="200">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑信息</el-button>
                        <el-button size="mini" :type="scope.row.status === '已停用' ? 'success' : 'warning'" @click="scope.row.status === '已停用'
                            ? handleEnable(scope.$index, scope.row)
                            : handleBlock(scope.$index, scope.row)">
                            {{ scope.row.status === '已停用' ? '启用' : '停用' }}
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>

        <!-- 对话框 -->
        <el-dialog title="编辑房间信息" :visible.sync="editdialogFormVisible">
            <el-form :model="editform" style="width: 90%">
                <el-form-item label="房间名称" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="房间描述" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.description" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="房间价格" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.price" autocomplete="off"></el-input>
                </el-form-item>

            </el-form>
            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="editdialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="editroom">保 存</el-button>
            </div>
        </el-dialog>
        <el-dialog title="添加" :visible.sync="adddialogFormVisible">
            <el-form :model="addform" style="width: 90%">
                <el-form-item label="房间名称" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="房间描述" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.description" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="房间价格" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.price" autocomplete="off"></el-input>
                </el-form-item>

            </el-form>
            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="adddialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="createroom">保 存</el-button>
            </div>
        </el-dialog>
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
        // 保存修改
        editroom() {
            //console.log(this.editform);
            console.log(this.editform);

            this.$api.RoomService.updateroom(this.editform).then((data) => {
                Message.success("修改成功");
                this.editdialogFormVisible = false;
                this.getallroom();
            });

        },
        createroom() {
            console.log(this.addform);
            this.$api.RoomService.insertroom(this.addform).then((data) => {
                Message.success("添加成功");
                this.adddialogFormVisible = false;
                this.getallroom();
            });
        },
        // 获取所有用户
        getallroom() {
            this.$api.RoomService.getallroom().then((data) => {
                console.log(data);
                this.list = data.room;
                this.list.forEach((item) => {
                    if (item.blocked == 1) {
                        item.status = "已停用";
                    }
                });
                //console.log(Array.isArray(this.list), this.list);

            });
        },
        // 页面改版
        pageChange(val) {
            this.pageIdx = val - 1;
            this.getallroom();
        },
        // 选择变化
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        addroom() {
            this.adddialogFormVisible = true;
            this.addform = { name: "", status: 0, realname: "", password: "" };
        },
        handleEdit(index, row) {
            this.editdialogFormVisible = true;
            this.editform = { ...row };
        },
        handleBlock(index, row) {
            let that = this;
            console.log(row);
            this.$confirm("确定停用？")
                .then((_) => {
                    console.log("yes");
                    //
                    this.$api.RoomService.blockroom(row.room_id).then((data) => {
                        Message.success("成功停用");
                        that.getallroom();
                    });
                    done();
                })
                .catch((_) => { });
        },
        handleEnable(index, row) {
            let that = this;
            console.log(row);
            this.$confirm("确定启用？")
                .then((_) => {
                    console.log("yes");
                    //
                    this.$api.RoomService.enableroom(row.room_id).then((data) => {
                        Message.success("成功启用");
                        that.getallroom();
                    });
                    done();
                })
                .catch((_) => { });
        },
    },
    //生命周期 - 创建完成（可以访问当前this实例）
    created() { },
    //生命周期 - 挂载完成（可以访问DOM元素）
    mounted() {
        setTimeout(() => this.getallroom(), 300);
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
