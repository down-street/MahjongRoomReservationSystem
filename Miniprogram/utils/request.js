import {
  store
} from '../store/store'
class Request {

  get(url, data) {
    return this.request('GET', url, data)
  }
  post(url, data) {
    return this.request('POST', url, data)
  }
  put(url, data) {
    return this.request('PUT', url, data)
  }
  request(method, url, data) {
    const that = this
    if (url[0] != '/') url = '/' + url
    url = store.baseUrl + url
    //console.log(url);
    return new Promise((resolve, reject) => {
      wx.request({
        url: url,
        data: data,
        method, // 一种做法，在header中带上登录态，方式取决于和后端的约定
        header: {
          "Content-Type": method == "POST" ? "application/json" : "application/x-www-form-urlencoded",
          'X-CSRFToken': wx.getStorageSync('csrftoken'),
          'Cookie': wx.getStorageSync('cookie'),
        },
        xsrfCookieName: 'csrftoken',
        xsrfHeaderName: 'X-CSRFToken',
        success(res) {
          wx.hideLoading();
          wx.stopPullDownRefresh();
          //if (store.CheckError(res.data)) ;
          console.log(res)
          const cookies = res.cookies[0]
          //console.log(cookies)
          if (cookies) {
            wx.setStorageSync('cookie', cookies);
          }
          //console.log(wx.getStorageSync('cookie'))
          resolve(res) 
        },
        fail(res) {
          wx.hideLoading();
          wx.stopPullDownRefresh();
          reject({
            message: res.errMsg,
            url: that.baseURL + url,
            method,
            data,
            statusCode: res.statusCode,
            result: res.data
          })
        }
      })
    })
  }
}


const request = new Request()

module.exports = request