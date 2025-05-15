const { default: api } = require("../../utils/api");

Page({
  data: {
    rooms: [
      {
        name: "棋牌室 A",
        description: "明亮舒适，可容纳 4 人。",
        status: "1",
        reservedSlots: [
          { start: "10:00", end: "12:00" },
          { start: "14:00", end: "15:30" },
        ]
      },
      {
        name: "棋牌室 B",
        description: "带空调，适合长时间对局。",
        status: "0"
      },
      {
        name: "棋牌室 C",
        description: "环境安静，带独立卫生间。",
        status: "2"
      }
    ],
    currentReservation:null,
    selectedStart: '08:00',  // 示例开始时间
    selectedEnd: '09:00',    // 示例结束时间
    duration: '1小时'  ,      // 默认时长
    duration_hour:1,
    duration_minute:0,
    currentstatus:null
    // currentReservation: {
    //   room: {
    //     id: 1,
    //     name: "棋牌室 A"
    //   },
    //   startTime: "14:00",
    //   endTime: "16:00"
    // }
    
    
  },

  onLoad() {
        // 添加样式类和文字
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
        this.fetchReservation()
        this.fetchRooms()
  },
  onReady()
  {
  },
  onStartTimeChange(e) {
    let selectedStart = e.detail.value;  // 获取选择的开始时间
    if(selectedStart>this.data.selectedEnd)
    selectedStart=this.data.selectedEnd
    this.setData({
      selectedStart: selectedStart
    });
    this.calculateDuration();  // 重新计算时长
  },

  onEndTimeChange(e) {
    let selectedEnd = e.detail.value;  // 获取选择的结束时间
  
    if(selectedEnd<this.data.selectedStart)
    {
      selectedEnd=this.data.selectedStart
    }
    this.setData({
      selectedEnd: selectedEnd
    });
    this.calculateDuration();  // 重新计算时长
  },

  calculateDuration() {
    const { selectedStart, selectedEnd } = this.data;

    // 将时分字符串转换为 Date 对象，确保每个日期部分都被设置
    const startTime = new Date(`1970-01-01T${selectedStart}:00`);
    const endTime = new Date(`1970-01-01T${selectedEnd}:00`);

    // 计算时长差值（单位：分钟）
    const durationMinutes = (endTime - startTime) / (1000 * 60);

    // 将时长转换为小时和分钟格式
    const hours = Math.floor(durationMinutes / 60);
    const minutes = durationMinutes % 60;

    // 更新时长数据
    const duration = `${hours}小时${minutes}分钟`;

    this.setData({
      duration: duration,
      duration_hour:hours,
      duration_minute:minutes
    });
  },
  fetchReservation() {
    api.getmyreservation().then(data=>
      {
        if(data.data.data)
        {
        
            this.setData({
              currentReservation:data.data.data,
              currentstatus:data.data.data.status
            }
              
            )
            console.log(this.data.currentstatus)
        }
        else
        {
          this.setData(
            {
              currentReservation:null,
            }
            
          )
        }
      }

    );
  },

  fetchRooms() {
    api.getallrooms().then(data=>
      {
          this.setData(
            {
              rooms:data.data.data
            }
          );
          const statusMap = {
            0: { class: "available", text: "空闲" },
            1: { class: "reserved", text: "已预约" },
            2: { class: "in-use", text: "使用中" },
            3:{ class: "cleaning", text: "正在清洁" }
          };
      
          const rooms = this.data.rooms.map(r => ({
            ...r,
            statusClass: statusMap[r.status].class,
            statusText: statusMap[r.status].text
          }));
          this.setData({ rooms });
      }
    )
  },

  openReservationPopup(e) {
    if (this.data.currentstatus<2) {
      wx.showToast({ title: "您正在使用其他房间或已有预约", icon: "none" });
      return;
    }
    const room = e.currentTarget.dataset.room
    if(room.status!=0)
    {
      wx.showToast({ title: "请选择空闲的房间", icon: "none" });
      return;
    }
    this.setData({ showPopup: true, selectedRoom: room })
  },

  closePopup() {
    this.setData({ showPopup: false });
  },

  submitReservation() {
    const { selectedRoom, selectedStart, selectedEnd } = this.data
    if (selectedStart >= selectedEnd) {
      wx.showToast({ title: "结束时间必须晚于开始时间", icon: "none" })
      return
    }
    console.log(selectedRoom)
    this.calculateDuration();
    //console.log(this.data.duration_hour,this.data.duration_minute)
    if (this.data.duration_hour==0) {
      wx.showToast({ title: "至少预定一个小时", icon: "none" })
      return
    }
    api.makereservation(
      {
        'room_id':selectedRoom.id,
        'starttime':selectedStart,
        'endtime':selectedEnd,
      }
    )
    this.setData(
      {
        showPopup:0
      }
    );
    wx.showToast({
      title: '预约成功！',
      icon: 'success',
      duration: 1500
    });

    this.fetchRooms();
    this.fetchReservation();    
    wx.reLaunch({
      url: '/pages/purchase/purchase',
    })
  },

  cancelReservation() {
    wx.showModal({
      title: '取消预约',
      content: '确定要取消当前预约吗？',
      confirmText: '是',
      cancelText: '否',
      success: (res) => {
        console.log(this.data.currentReservation)
        if (res.confirm) {
          // 调接口取消预约
          let dt={};
          dt['room_id']=this.data.currentReservation.room_id;
          dt['id']=this.data.currentReservation.id;
          api.cancelreservation(dt)
            .then(() => {
              wx.showToast({
                title: '已取消预约',
                icon: 'success',
                duration: 1500
              });
              // 刷新当前预约信息和房间列表
              this.setData({ currentReservation: null, showPopup: false }, () => {
                this.fetchRooms();
              });
              console.log('change')
              wx.reLaunch({
                url: '/pages/purchase/purchase',
              })
            })
            .catch(err => {
              console.error('取消失败', err);
              wx.showToast({
                title: '取消失败，请重试',
                icon: 'none'
              });
            });
        }
      }
    });
  },

})
