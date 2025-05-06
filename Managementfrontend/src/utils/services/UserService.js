import http from '../http';

export default {

    // 获取用户信息 UserInfo
    getmyprofile: () => http.get("api/getmyprofile/", {}),


    getallstaff: () => http.get("api/getallstaff/", {}),
    getallcustomer: () => http.get("api/getallcustomer/", {}),
    insertstaff: (data) => http.post("api/insertstaff/", data),
    insertcustomer: (data) => http.post("api/insertcustomer/", data),
    updatestaff: (data) => http.post("api/updatestaff/", data),
    updatecustomer: (data) => http.post("api/updatecustomer/", data),
    deletestaff: (name) => http.post("api/deletestaff/", {name}),
    deletecustomer: (name) => http.post("api/deletecustomer/", {name}),
}