import api from '../../../utils/api.js'


Page({
  data: {
    identify: "",
    tag: 0,
    method: 0,
    resttime: 0,
    vcode: null,
    password: null,
  },
  onLoad() {
  },
  onUnload() {
  },
  // input双向绑定
  updateIdentify(e) {
    this.setData({
      identify: e.detail.value
    })
  },
  updatevcode(e) {
    this.setData({
      vcode: e.detail.value
    })
  },
  updatepassword(e) {
    this.setData({
      password: e.detail.value
    })
  },
  // 改变登陆方式
  changeloginmethod() {
    if (this.data.method == 0) {
      this.setData({
        method: 1
      })
    } else {
      this.setData({
        method: 0
      })
    }
    console.log(this.data.method, this.data.tag)
  },
  changetologin() {
    console.log(this.data.tag);
    //deal with verification code not implemented
    let that = this
    const phone = this.data.identify
    console.log(phone);

    if (phone == null || phone == "" || (!/^\d{11}$/.test(phone))) {
      wx.showToast({
        title: "请输入正确的手机号",
        icon: "none"
      })
      return;
    }
    wx.showToast({
      title: '验证码已发送！',
      icon: 'none',
      duration: 1500
    })
    this.setData({
      tag: 1,
    })
    this.setData({
      resttime: 10
    });

    // 保存定时器 ID 以便后续清除
    this.countdownTimer = setInterval(function () {
      let current = that.data.resttime;
      if (current <= 1) {
        clearInterval(that.countdownTimer); // 清除定时器
        that.setData({
          resttime: 0
        });
      } else {
        that.setData({
          resttime: current - 1
        });
      }
    }, 1000);
  },
  login() {
    let that = this
    console.log(this.data.identify);
    const name = this.data.identify;
    const code = this.data.method == 0 ? this.data.vcode : this.data.password;
    if (this.data.method == 0) {
      if (name == null || name == "" || code == null || code == "") {
        wx.showToast({
          title: "请输入验证码!",
          icon: "none"
        })
        return;
      }
    } else {
      if (name == null || name == "" || code == null || code == "") {
        wx.showToast({
          title: "请输入手机号与密码!",
          icon: "none"
        })
        return;
      }
    }
    // 开始请求
    wx.showLoading({
      title: '正在登录',
    })

    api.login(name, code).then(data => {
      console.log(data)
      if (data.statusCode == 200) {
        
        wx.reLaunch({
          url: '/pages/center/center',
        })
      } else {
        wx.hideLoading();
        if (data.statusCode == 401) {
          if (this.data.method == 0) {
            wx.showToast({
              title: "验证码错误，请重试",
              icon: "none"
            })
          } else {
            wx.showToast({
              title: "手机号或密码错误，请重试",
              icon: "none"
            })
          }

        }
        if (data.statusCode == 403) {
          wx.showToast({
            title: "您已被封禁!",
            icon: "none"
          })
        }
        if(data.statusCode==404)
        {
          wx.showToast({
            title: "该手机号未注册，请先通过验证码注册!",
            icon: "none"
          })
        }
      }
    })
    .catch(err => {
      wx.hideLoading();
      console.error("请求异常：", err);
      wx.showToast({
        title: "网络错误，请稍后再试",
        icon: "none"
      })
    })
  },


})