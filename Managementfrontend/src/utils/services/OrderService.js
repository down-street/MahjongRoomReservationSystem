import http from '../http';

export default {
    getallproductorder: () => http.get("api/getallproductorder/", {}),
    getallcleanorder: () => http.get("api/getallcleanorder/", {}),
    successproductorder: (order_id) => http.post("api/successproductorder/",order_id),
    successcleanorder: (order_id) => http.post("api/successcleanorder/",order_id),
    cancelproductorder: (order_id) => http.post("api/cancelproductorder/",order_id),
    cancelcleanorder: (order_id) => http.post("api/cancelcleanorder/",order_id),
}