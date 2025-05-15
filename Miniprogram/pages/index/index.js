// index.js
const {
  default: api
} = require("../../utils/api");

// 获取应用实例
const app = getApp()

Page({
    data: {
      notices: [
        {
          image: 'https://respic.3d66.com/coverimg/cache/0cfc/a1fe92f05be2df48369b96df668e13cd.jpg!detail-full-seo-p?v=9968357&k=D41D8CD98F00B204E9800998ECF8427E',
          text: '本店新增茶饮服务，欢迎体验！'
        },
        {
          image: 'https://p6.itc.cn/q_70/images01/20220310/2fcfd4102b834cf2a691ffb8953496e8.jpeg',
          text: '会员充值送豪礼，详情咨询店员。'
        },
        {
          image: 'https://picsum.photos/id/14/800/600',
          text: '感谢您的支持，祝您愉快！'
        }
      ]
    },

    onLoad() {
      
      api.getannouncement().then(data => {
        console.log(data.data.data)
        const updatedNotices = data.data.data.map(item => {
          return {
            ...item,
            image: item.image?'http://localhost:8000' + item.image:'https://photo.16pic.com/00/93/62/16pic_9362647_b.png'
          }
        });
        this.setData({
          notices: updatedNotices
        });
        console.log(this.data.notices)
        });
    },
    onShow() {
    },
    onReady() {},
})