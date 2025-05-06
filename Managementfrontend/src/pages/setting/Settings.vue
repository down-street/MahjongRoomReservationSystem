<template>
    <div class="profile-container">
        <h1 class="profile-title">个人信息维护</h1>
        <el-card class="profile-card">
            <div v-if="roleid === 'staff'">
                <div class="info-box">
                    <el-form v-model="data" ref="form" label-width="100px">
                        <el-form-item label="用户名">
                            <div class="form-static">{{ this.username || '未填写' }}</div>
                        </el-form-item>
                        <el-form-item label="姓名">
                            <el-input class="form-input" v-model="realname" placeholder="请输入姓名"></el-input>
                        </el-form-item>
                        <el-form-item label="角色">
                            <div class="form-static">{{ this.role || '未填写' }}</div>
                        </el-form-item>
                        <el-form-item label="工作状态">
                            <el-select v-model="status" placeholder="请选择工作状态" class="form-input">
                                <el-option label="工作" value=1 />
                                <el-option label="休息" value=0 />
                            </el-select>
                        </el-form-item>
                        <el-form-item label="密码">
                            <el-input class="form-input" v-model="password" placeholder="请输入密码，不修改则留空"></el-input>
                        </el-form-item>
                        <el-form-item label="重复输入密码">
                            <el-input class="form-input" v-model="passwordrepeat" placeholder="重复输入密码"></el-input>
                        </el-form-item>

                    </el-form>
                </div>
            </div>

            <div v-else-if="roleid === 'admin'">
                <div class="info-box">
                    <el-form v-model="data" ref="form" label-width="100px">
                        <el-form-item label="用户名">
                            <div class="form-static">{{ this.username || '未填写' }}</div>
                        </el-form-item>
                        <el-form-item label="角色">
                            <div class="form-static">{{ this.role || '未填写' }}</div>
                        </el-form-item>

                        <el-form-item label="密码">
                            <el-input class="form-input" v-model="password" placeholder="请输入密码，不修改则留空"></el-input>
                        </el-form-item>
                        <el-form-item label="重复输入密码">
                            <el-input class="form-input" v-model="passwordrepeat" placeholder="重复输入密码"></el-input>
                        </el-form-item>
                    </el-form>
                </div>
            </div>

            <el-button type="warning" @click="submitchange">修改</el-button>
        </el-card>
    </div>
</template>
<script>
import { Message } from "element-ui";
export default {
    data() {
        return {
            data: {
            },
            roleid: '',
            username: '',
            realname: '',
            status: '',
            role: '',
            password: '',
            passwordrepeat: ''
        };
    },
    mounted() {
        // 加载用户数据
        this.$api.UserService.getmyprofile().then((res) => {
            //console.log(res);
            this.username = res.username;
            //console.log(this.data.username);
            this.roleid = res.role;
            this.role = (res.role == 'admin' ? '管理员' : '工作人员');
            this.realname = res.realname;
            this.status = res.status;
        });
    },
    methods: {
        submitchange() {
            if (this.status == '工作')
                this.status = 1;
            else if (this.status == '休息')
                this.status = 0;
            if (this.password != this.passwordrepeat) {
                Message.error("两次输入的密码不一致");
                return;
            }
            this.$api.UserService.updatestaff({
                role: this.roleid,
                name: this.username,
                realname: this.realname,
                status: this.status,
                password: this.password
            }).then(() => {
                Message.success("修改成功");
            });
            location.reload();
            //console.log(this.status)
            // this.$api.UserService.changepassword(this.passwordForm).then(() => {
            //     this.$message.success("修改密码成功");
            //     this.showPasswordDialog = false;
            // });
        }
    }
};
</script>

<style lang="less" scoped>
.profile-container {
    width: 100%;
    height: 100%;
    //background: #fff;
    padding-left: 30%;
    padding-right: 30%;
    padding-top: 20%;
    padding-bottom: 20%;
    //margin-top: 30%;
    text-align: center;
}

.profile-title {
    font-size: 25px;
    margin-bottom: 20px;
}

.profile-card {
    padding: 20px;
    border: 1px solid #dcdfe6;
    box-shadow: none;
    border-radius: 4px;
}

.info-box {
    border: 1px solid #e4e7ed;
    border-radius: 4px;
    padding: 10px 15px;
    margin-bottom: 12px;
    background-color: #f9f9f9;
}

::v-deep(.el-form-item__label) {
    font-size: 14px;
    color: #555;
    text-shadow: none;
}

.form-input {
    width: 100%;
    text-align: center;
    font-size: 14px;
    color: #333;
}

.form-static {
    color: #909399;
    font-size: 14px;
}
</style>
