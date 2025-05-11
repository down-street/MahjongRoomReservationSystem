// pages/center/settings/settings.js


Page({

    /**
     * 页面的初始数据
     */
    data: {

    },

    logout() {
        wx.clearStorage()
        wx.reLaunch({
            url: '/pages/center/login/login',
        })
    },


    /**
     * 生命周期函数--监听页面加载
     */
    onLoad(options) {

    },



    /**
     * 生命周期函数--监听页面显示
     */
    onShow() {

    },

    /**
 

    /**
     * 页面相关事件处理函数--监听用户下拉动作
     */
    onPullDownRefresh() {

    },


    edit() {
        wx.navigateTo({
            url: '/pages/center/user/user',
        })
    }
})