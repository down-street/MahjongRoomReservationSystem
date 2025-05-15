import http from '../http';

export default {
    // 获取房间信息 goodsInfo
    getallgoodsstaff: () => http.get("api/getallgoodsstaff/", {}),
    insertgoods: (data) => http.post("api/insertgoods/", data),
    updategoods: (data) => http.post("api/updategoods/", data),
    blockgoods: (name) => http.post("api/blockgoods/", name),
    enablegoods: (name) => http.post("api/enablegoods/", name),
}