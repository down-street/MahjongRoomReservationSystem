// pages/center/center.js
//先引入
import api from '../../utils/api';
const app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    nickname:'请登录',
    balance:0.00,
    status:null
  },
  handleTap(e) {
    const idx = e.currentTarget.dataset.idx
    if(idx=='settings')
    {
      wx.navigateTo({
        url: '/pages/center/settings/settings',
      });
    }
    if(idx=='balancetop')
    {
      let url= '/pages/center/balancetop/balancetop';
      wx.navigateTo({
        url: url,
      });
    }
    if(idx=='goodsorder')
    {
      let url = '/pages/center/goodsorder/goodsorder';
      wx.navigateTo({
        url: url,
      });
    }
    if(idx=='roomorder')
    {
        let url = '/pages/center/mycredit/mycredit';
        wx.navigateTo({
          url: url,
        });
    }
    api.checklogin().then(data => {
      if (data.StatusCode == 200)  {
        let url = '/pages/center/center';
        // 进入个人资料
        wx.navigateTo({
          url: url,
        });
      } else {
        wx.navigateTo({
          url: '/pages/center/login/login',
        });
      }
    });
  },

  /**
   * 生命周期函数--监听页面加载
   */

  onLoad(options) {
    setTimeout(() => {
      api.checklogin().then(data => {
        console.log(data)
        if (data.statusCode == 200) {
          let url = '/pages/center/center';
          // 进入个人资料 
          wx.navigateTo({
            url: url,
          });
        } else { 
          wx.navigateTo({
            url: '/pages/center/login/login',
          });
        }
      });
    }, 500);
    api.getcustomerinfo().then(data=>{
      if(data.data.status==1)
      {
        data.data.status='正在使用'
      }
      if(data.data.status==2)
      {
        data.data.status='已预约'
      }
      if(data.data.status==0)
      {
        data.data.status='未使用'
      }
      this.setData({
        nickname: data.data.username,
        balance: data.data.balance,
        status: data.data.status
      });
    });
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady() {
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide() {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload() {
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh() {
    api.getcustomerinfo().then(data=>{
      if(data.data.status==1)
      {
        data.data.status='正在使用'
      }
      if(data.data.status==2)
      {
        data.data.status='已预约'
      }
      if(data.data.status==0)
      {
        data.data.status='未使用'
      }
      this.setData({
        nickname: data.data.username,
        balance: data.data.balance,
        status: data.data.status
      });
    });
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom() {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage() {}
})