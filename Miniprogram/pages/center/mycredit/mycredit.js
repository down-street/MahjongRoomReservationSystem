// pages/center/mycredit/mycredit.js

const {
  default: api
} = require("../../../utils/api")


Page({

  /**
   * 页面的初始数据
   */
  data: {
    records: null

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad(options) {
    api.getroomorder().then(data => {
      this.setData({
        records: data.data.order
      })
      console.log(this.data.records)
    })
  },


  /**
   * 生命周期函数--监听页面显示
   */
  onShow() {

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

  },


})