const {
  default: api
} = require("../../../utils/api")
Page({
    data: {
      password: '',
      confirmPassword: ''
    },
  
    onPasswordInput(e) {
      this.setData({ password: e.detail.value });
    },
  
    onConfirmInput(e) {
      this.setData({ confirmPassword: e.detail.value });
    },
  
    onSubmit() {
      const { password, confirmPassword } = this.data;
  
      if (!password || !confirmPassword) {
        wx.showToast({ title: '请填写密码', icon: 'none' });
        return;
      }
  
  
      if (password !== confirmPassword) {
        wx.showToast({ title: '两次输入不一致', icon: 'none' });
        return;
      }
  
      // 模拟请求
      wx.showToast({ title: '修改成功', icon: 'success' });
      setTimeout(() => {
        api.updatecustomerinfo(password);
        wx.reLaunch({
          url: '/pages/center/center',
        })
      }, 1000);
    }
  });
  