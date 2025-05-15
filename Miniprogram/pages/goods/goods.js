const {
  default: api
} = require("../../utils/api");

Page({
  data: {
    products: [{
        id: 1,
        image: "/resources/images/p1.jpg",
        name: "商品 A",
        desc: "这是商品 A 的描述",
        price: 19.9,
        count: 0
      },
      {
        id: 2,
        image: "/resources/images/p2.jpg",
        name: "商品 B",
        desc: "这是商品 B 的描述",
        price: 29.9,
        count: 0
      },
      {
        id: 3,
        image: "/resources/images/p3.jpg",
        name: "商品 C",
        desc: "这是商品 C 的描述",
        price: 9.9,
        count: 0
      }
    ],
    totalCount: 0,
    totalPrice: 0
  },
  onLoad: function () {
    api.checklogin().then(data=>
      {
        console.log(data.data)
        if(data.statusCode!=200)
        {
          wx.reLaunch({
            url: '/pages/center/login/login',
          })
        }
      }
      
    )
    api.getallgoods().then(data => {
      const goods = data.data.goods.map(item => {
        return {
          ...item,
          image: item.image ? 'http://localhost:8000' + item.image : "https://www.62icon.com/images/products/generated/large/77e515667fda8d7606e69378e60aa29e.png"
        };
      });

      this.setData({
        products: goods
      });

      console.log(this.data.products);
    });
  },
  addToCart(e) {
    const id = e.currentTarget.dataset.id;
    const updated = this.data.products.map(item => {
      if (item.id === id) {
        if (item.count >= item.quantity) {
          wx.showToast({
            title: '物品数量超限',
          })
          return item;
        } else {
          item.count += 1;
          this.updateTotal();
        }
      }
      return item;
    });

    this.setData({
      products: updated
    }, this.updateTotal);
  },
  removeFromCart(e) {
    const id = e.currentTarget.dataset.id;
    const updated = this.data.products.map(item => {
      if (item.id === id && item.count > 0) {
        item.count -= 1;
        this.updateTotal();
      }
      return item;
    });

    this.setData({
      products: updated
    }, this.updateTotal);
  },
  updateTotal() {
    let totalCount = 0;
    let totalPrice = 0;
    this.data.products.forEach(item => {
      totalCount += item.count;
      totalPrice += item.count * item.price;
    });
    totalPrice = totalPrice.toFixed(2);
    //console.log(totalPricef)
    this.setData({
      totalCount,
      totalPrice
    });
  },

  submitOrder() {
    if (this.data.totalCount === 0) {
      wx.showToast({
        title: "请选择商品",
        icon: "none"
      });
      return;
    }

    wx.showModal({
      title: "确认下单",
      content: `您将购买 ${this.data.totalCount} 件商品，合计 ¥${this.data.totalPrice}，是否确认？`,
      success: (res) => {
        if (res.confirm) {

          wx.showLoading({
            title: "提交中..."
          });

          // 组织提交数据，只提交 count>0 的商品
          const items = this.data.products
            .filter(p => p.count > 0)
            .map(p => ({
              item_id: p.id,
              quantity: p.count
            }));

          api.submitgoodsorder(items).then(data => {
            console.log(data)
            if (data.statusCode == 200) {
              // 清空购物车
              wx.showToast({
                title: "下单成功",
                icon: "success"
              });
              const cleared = this.data.products.map(p => ({
                ...p,
                count: 0
              }));
              this.setData({
                products: cleared,
                totalCount: 0,
                totalPrice: 0
              });
            } else if (data.statusCode == 409) {
              wx.showModal({
                title: "库存不足",
                content: `商品库存不足，请重新下单`,
                showCancel: false
              });
              wx.reLaunch();
            } else if (data.statusCode == 402) {
              wx.showModal({
                title: "余额不足",
                content: `您的余额不足，请充值后再下单。`,
                showCancel: false
              });
            } else {
              wx.showToast({
                title: data.message || '下单失败',
                icon: "none"
              });
            }
          });
        }
      }
    });
  }
});