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
    api.getgoodsorder().then(data => {
      // 原始订单列表
      let records = data.data.order;
    
      // 对每条记录进行处理，将 name 字段转成 name_arr 数组
      records.forEach(item => {
        item.name_arr = Object.entries(item.name || {}).map(([key, value]) => {
          return { key, value };
        });
      });
    
      // 更新页面数据
      this.setData({
        records: records
      });
    
      console.log(this.data.records);
    });
    
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