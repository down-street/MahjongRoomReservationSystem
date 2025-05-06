<!-- User -->
<template>
    <div class="User">
        <div style="float: left">
            <el-button @click="addcustomer()">添加顾客</el-button>
        </div>
        <div class="receive-show">
            <el-empty v-if="list == []" :image-size="300"> </el-empty>
            <div v-else style="width: 100%; height: 100%">
                <el-table :data="list.filter(
                    (data) =>
                        !search ||
                        data.nickName
                            .toLowerCase()
                            .includes(search.toLowerCase())
                )
                    " :stripe="true" style="width: calc(100% - 30px)" @selection-change="handleSelectionChange">
                    <el-table-column type="selection" width="100">
                    </el-table-column>
                    <el-table-column fixed prop="name" label="用户名" width="140">
                    </el-table-column>
                    <el-table-column prop="phone_number" label="手机号" width="170">
                    </el-table-column>
                    <el-table-column prop="status" label="房间使用状态" width="150">
                    </el-table-column>
                    <el-table-column prop="balance" label="余额" width="100">
                    </el-table-column>
                    <el-table-column prop="blocked" label="是否被封禁" width="100">
                    </el-table-column>
                    <el-table-column align="left" style="align-items: right">

                        <template slot-scope="scope">
                            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">修改</el-button>
                            <el-button size="mini" type="danger"
                                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-if="list != []" class="pagination" background layout="prev, pager, next"
                    :page-size="pageSize" :total="totalElements" @current-change="pageChange">
                </el-pagination>
            </div>
        </div>

        <!-- 对话框 -->
        <el-dialog title="编辑" :visible.sync="editdialogFormVisible">
            <el-form :model="editform" style="width: 90%">
                <el-form-item label="用户名" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.name" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="手机号" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.phone_number" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="余额" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.balance" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="房间状态" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.status" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="封禁状态" :label-width="formLabelWidth">
                    <el-select v-model="editform.blocked" placeholder="请选择状态">
                        <el-option label="否" :value=0></el-option>
                        <el-option label="是" :value=1></el-option>
                    </el-select>
                </el-form-item>

            </el-form>
            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="editdialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="editcustomer">保 存</el-button>
            </div>
        </el-dialog>
        <el-dialog title="添加" :visible.sync="adddialogFormVisible">
            <el-form :model="addform" style="width: 90%">
                <el-form-item label="用户名" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="密码" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.password" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="手机号" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.phone_number" autocomplete="off"></el-input>
                </el-form-item>

            </el-form>
            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="adddialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="createcustomer">保 存</el-button>
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
        editcustomer() {
            //console.log(this.editform);
            if (this.editform.blocked == "否") {
                this.editform.blocked = 0;
            } else if (this.editform.blocked == "是") {
                this.editform.blocked= 1;
            }
            console.log(this.editform);
            
            this.$api.UserService.updatecustomer(this.editform).then((data) => {
                Message.success("修改成功");
                this.editdialogFormVisible = false;
                this.getallcustomer();
            });

        },
        createcustomer() {
            console.log(this.addform);
            this.$api.UserService.insertcustomer(this.addform).then((data) => {
                Message.success("添加成功");
                this.adddialogFormVisible = false;
                this.getallcustomer();
            });
        },
        // 获取所有用户
        getallcustomer() {
            this.$api.UserService.getallcustomer().then((data) => {
                this.list = data.customer;
                this.list.forEach((item) => {
                    if (item.blocked == 0) {
                        item.blocked = "否";
                    } else if (item.blocked == 1) {
                        item.blocked = "是";
                    }
                });
                //console.log(Array.isArray(this.list), this.list);

            });
        },
        // 页面改版
        pageChange(val) {
            this.pageIdx = val - 1;
            this.getallcustomer();
        },
        // 选择变化
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        addcustomer() {
            this.adddialogFormVisible = true;
            this.addform = { name: "", status: 0, realname: "", password: "" };
        },
        handleEdit(index, row) {
            this.editdialogFormVisible = true;
            this.editform = { ...row };
        },
        handleDelete(index, row) {
            let that = this;
            console.log(index, row);
            this.$confirm("确定删除？")
                .then((_) => {
                    console.log("yes");
                    //
                    this.$api.UserService.deletecustomer(row.name).then((data) => {
                        Message.success("删除成功");
                        that.getallcustomer();
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
        setTimeout(() => this.getallcustomer(), 300);
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
