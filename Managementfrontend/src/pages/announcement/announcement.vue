<!-- User -->
<template>
    <div class="User">
        <div style="float: left">
            <el-button @click="addannouncement()">添加公告</el-button>
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
                    <el-table-column fixed prop="announcement_id" label="公告id" width="80">
                    </el-table-column>
                    <el-table-column prop="content" label="公告内容" width="370">
                    </el-table-column>
                    <el-table-column prop="ImageUrl" label="公告图片" width="100">
                        <template slot-scope="scope">
                            <img v-if="scope.row.ImageUrl" :src="scope.row.ImageUrl" alt="商品图片"
                                style="width: 80px; height: 80px; object-fit: cover;" />
                            <span v-else>暂无图片</span>
                        </template>
                    </el-table-column>
                    <el-table-column label="操作" width="200">
                        <template slot-scope="scope">
                            <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑信息</el-button>
                            <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
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
                <el-form-item label="公告内容" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="editform.content" autocomplete="off"></el-input>
                </el-form-item>
                <!-- 上传图片模块 -->
                <el-form-item label="公告" :label-width="formLabelWidth">
                    <el-upload class="upload-demo" action="/api/upload/" :on-success="handleImageSuccess"
                        :show-file-list="false" accept="image/*">
                        <el-button size="small" type="primary">选择图片</el-button>
                    </el-upload>
                    <!-- <el-button size="small" type="success" @click="submitUpload">上传图片</el-button> -->
                    <div v-if="editform.imageUrl" class="image-preview">
                        <img :src="editform.imageUrl" alt="公告图片" style="width: 100px; height: 100px; margin-top: 10px;">
                    </div>
                </el-form-item>

            </el-form>
            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="editdialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="editannouncement">保 存</el-button>
            </div>
        </el-dialog>
        <el-dialog title="添加公告" :visible.sync="adddialogFormVisible">
            <el-form :model="addform" style="width: 90%">
                <el-form-item label="公告内容" :label-width="formLabelWidth">
                    <el-input class="inputbar" v-model="addform.content" autocomplete="off"></el-input>
                </el-form-item>
                <!-- 上传图片模块 -->
                <el-form-item label="商品图片" :label-width="formLabelWidth">
                    <el-upload class="upload-demo" action="/api/upload/" :on-success="handleImageSuccessadd"
                        :show-file-list="false" accept="image/*">
                        <el-button size="small" type="primary">选择图片</el-button>
                    </el-upload>
                    <!-- <el-button size="small" type="success" @click="submitUpload">上传图片</el-button> -->
                    <div v-if="addform.imageUrl" class="image-preview">
                        <img :src="addform.imageUrl" alt="商品图片" style="width: 100px; height: 100px; margin-top: 10px;">
                    </div>
                </el-form-item>

            </el-form>

            <!-- 下方确定按钮 -->
            <div slot="footer" class="dialog-footer">
                <el-button @click="adddialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="createannouncement">保 存</el-button>
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
        handleImageSuccess(response, file) {
            this.$set(this.editform, 'imageUrl', 'api' + response.url);
            // this.editform.imageUrl = "api"+response.url;  // 假设服务器返回的图片路径在response.url中
            //console.log(this.editform.imageUrl);
        },
        handleImageSuccessadd(response, file) {
            this.$set(this.addform, 'imageUrl', 'api' + response.url);
            // this.editform.imageUrl = "api"+response.url;  // 假设服务器返回的图片路径在response.url中
            //console.log(this.editform.imageUrl);
        },
        // 保存修改
        editannouncement() {
            //console.log(this.editform);
            console.log(this.editform);

            this.$api.AnnouncementService.updateannouncement(this.editform).then((data) => {
                Message.success("修改成功");
                this.editdialogFormVisible = false;
                this.getallannouncement();
            });

        },
        createannouncement() {
            console.log(this.addform);
            this.$api.AnnouncementService.insertannouncement(this.addform).then((data) => {
                Message.success("添加成功");
                this.adddialogFormVisible = false;
                this.getallannouncement();
            });
        },
        // 获取所有用户
        getallannouncement() {
            this.$api.AuthService.checklogin();
            this.$api.AnnouncementService.getallannouncement().then((data) => {
                //print(data);
                this.list = data.announcement;
                
                this.list.forEach((item) => {
                    
                    if (item.ImageUrl == null) {
                        //item.image = "https://img.icons8.com/ios/50/000000/no-image.png";
                    }
                    else {
                        item.ImageUrl = "api" + item.ImageUrl;
                    }
                });console.log(this.list);
                //console.log(Array.isArray(this.list), this.list);

            });
        },
        // 页面改版
        pageChange(val) {
            this.pageIdx = val - 1;
            this.getallannouncement();
        },
        // 选择变化
        handleSelectionChange(val) {
            this.multipleSelection = val;
        },
        addannouncement() {
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
                    this.$api.AnnouncementService.deleteannouncement(row.announcement_id).then((data) => {
                        Message.success("下架成功");
                        that.getallannouncement();
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
        setTimeout(() => this.getallannouncement(), 300);
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
