// const serviceUrl = 'https://www.proseer.cn/zcxypcstage/api';
const serviceUrl = 'http://192.168.2.11:8002/apitest/api/';
const servicePath = {
    'captcha' : serviceUrl + '/user/captcha',   // 获取验证码
    'quicklogin' : serviceUrl + '/user/app/quicklogin',   // 注册、手机号登录
    'setpwd' : serviceUrl + '/user/setpwd',   // 设置密码
    'login' : serviceUrl + '/user/app/login',   // 密码登录

    'home' : serviceUrl + '/combination/app/home',   // 首页
    'hotList' : serviceUrl + '/college/app/hot',   // 大家都在搜
    'searchbytitleandteacher' : serviceUrl + '/college/app/searchbytitleandteacher',   // 搜索课程、老师
    'recommend' : serviceUrl + '/college/app/recommend',  // 猜你喜欢
    'book' : serviceUrl + '/combination/book',  // 预约直播
    'strategylist' : serviceUrl + '/news/list',  // 攻略
    'classification' : serviceUrl + '/college/app/search',  // 分类列表
};