import http from '../http';

export default {

    authorize: (username,password) => http.post("api/mnglogin/", {username, password}),
    get_csrf: ()=> http.get("/api/csrf/", {}),
    logout: () => http.post("/api/mnglogout/", {}),
    checklogin: () => http.post("/api/checklogin/", {}),
}