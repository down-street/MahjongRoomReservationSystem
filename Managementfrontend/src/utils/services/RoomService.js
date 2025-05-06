import http from '../http';

export default {
    // 获取房间信息 RoomInfo
    getallroom: () => http.get("api/getallroom/", {}),
    insertroom: (data) => http.post("api/insertroom/", data),
    updateroom: (data) => http.post("api/updateroom/", data),
    blockroom: (name) => http.post("api/blockroom/", name),
    enableroom: (name) => http.post("api/enableroom/", name),
}