const serviceUrl = 'https://www.proseer.cn/zcxypc/api';
// const serviceUrl = 'http://192.168.2.11:8002/apitest/api';
// const serviceUrl = 'http://192.168.2.11:8002/api';
const servicePath = {
    'getcache' : serviceUrl + '/user/getcache',   // 获取用户信息
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
    'strategylistdetail' : serviceUrl + '/news/detail',  // 攻略详情
    'classification' : serviceUrl + '/college/app/search',  // 分类列表
    'collegedetailforapp' : serviceUrl + '/college/collegedetailforapp',  // 课程详情
    'collect' : serviceUrl + '/combination/collect',  // 收藏
    'getevaluate' : serviceUrl + '/college/getevaluate',  // 评价列表
    'addvaluate' : serviceUrl + '/college/addvaluate',  // 评价
    'pointexchangelist' : serviceUrl + '/coupon/app/pointexchangelist',  // 可兑换优惠券
    'mycouponlist' : serviceUrl + '/coupon/app/my',  // 我的优惠券
    'livestreaming' : serviceUrl + '/livestreaming/online/list',  // 直播中
    'livestreamingdetail' : serviceUrl + '/livestreaming/detail',  // 直播中详情
    'getgroupid' : serviceUrl + '/chatroom/advisory/getgroupid',  // 获取咨询ID
    'sendgroup' : serviceUrl + '/chatroom/msg/send',  // 发送咨询
    'getgroup' : serviceUrl + '/chatroom/msg/get',  // 获取咨询
    'createorder' : serviceUrl + '/order/createorder',  // 支付购买、下单、积分兑换
    'getstate' : serviceUrl + '/user/app/state',  // 获取配置state
    'wxlogin' : serviceUrl + '/user/app/wxlogin',  // 微信登录
    'wxcreateorder' : serviceUrl + '/order/createorder',  // 微信支付配置信息
    'getchatroom' : serviceUrl + '/chatroom/msg/get',  // 获取直播聊天室消息
    'sendchatroom' : serviceUrl + '/chatroom/msg/send',  // 发送直播聊天室消息
    'myorder' : serviceUrl + '/college/app/my',  // 已购买的课程
    'getmyfavoriate' : serviceUrl + '/college/app/getmyfavoriate',  // 我的收藏
    'collectpl' : serviceUrl + '/combination/collect/pl',  // 批量收藏
    'myConsumption' : serviceUrl + '/order/app/my',  // 牛币记录
    'myPointinfo' : serviceUrl + '/point/pointinfo',  // 积分记录
    'uploadfile' : serviceUrl + '/system/app/uploadfile',  // 生成分享海报
};