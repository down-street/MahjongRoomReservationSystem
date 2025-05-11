import request from './request.js'
//引入request.js 文件
class Api {
    //请求方法
    wxLogin(code) {
        return request.post('/wx/login', code)
    }

    login = (username,password) => request.post("/login/", {username,password});
    checklogin= () => request.post("/checklogin/", {});

    getcustomerinfo=()=>request.get('/getcustomerinfo/')
    updatecustomerinfo=(data)=>request.post('/updatecustomerinfo/',data)

    getroomorder=()=>request.get('/getroomorder/')
    getgoodsorder=()=>request.get('/getgoodsorder/')

    getallgoods=()=>request.get('/getallgoods/')
    submitgoodsorder=(items)=>request.post('/submitgoodsorder/',items)
    getmyreservation=()=>request.get('/getmyreservation/')
    getallrooms=()=>request.get('/getallrooms/')
    makereservation=(data)=>request.post('/makereservation/',data)
    cancelreservation=(room_id)=>request.post('/cancelreservation/',room_id)
}
const api = new Api()
export default api