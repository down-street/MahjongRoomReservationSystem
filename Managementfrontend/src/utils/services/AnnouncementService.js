import http from '../http';

export default {
    // 获取房间信息 announcementInfo
    getallannouncement: () => http.get("api/getallannouncement/", {}),
    insertannouncement: (data) => http.post("api/insertannouncement/", data),
    updateannouncement: (data) => http.post("api/updateannouncement/", data),
    deleteannouncement: (name) => http.post("api/deleteannouncement/", name),
    enableannouncement: (name) => http.post("api/enableannouncement/", name),
}