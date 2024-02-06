# 项目名

黑马： 面试 APP

# 项目描述

面试 APP 提供了多种题目和内容，包括基础知识点问题、原理问题、项目问题等，满足不同前端程序员的需求。同时，面试通 APP 还包含各大公司的真实面试经验，便于用户找到心仪公司的面经。面试通 APP 支持用户自主选择学习内容，同时还提供了智能推荐和反馈机制，帮助用户更好地掌握知识和技能。

# 核心功能：

•刷题系统：题库频道、面试题长列表、点赞、收藏、分享、富文本预览
•项目系统：企业级项目场景面试题展示、业务类问答、技术类问答
•面经系统：大厂面试经验、文章阅读、试题阅读数据埋点
•个人中心：打卡、打卡记录、学习时间统计、数据可视化、编辑头像、编辑昵称、退出登录
•历史记录：试题阅读记录、面经阅读记录、点赞收藏记录、个人反馈记录

# 使用技术

基于 API9 使用 ArtTS 与 ArtUI 实现页面构建和状态管理
基于 PersistentStorage 和 AppStorage 实现用户信息存储和访问权限控制
基于 display 和 deviceInfo 实现适配手机侧函数 vp2vp 做到视觉统一
基于 IDataSource 和 LazyForEach 实现列表懒加载优化列表性能
基于 emitter 实现 UIAbility 进程内通信实现通知更新首页信息
基于 mediaquery 实现设备和横竖屏查询实现多设备布局适配
基于 http 封装请求工具类，实现接口响应数据泛型支持和参数处理与响应拦截
基于鸿蒙系统组件，抽象封装通用组件 Search、Skeleton、MiniCalendar、LoadingDialog、Tag 等
基于 UIAbility 和 Page 生命周期实现阅读实现埋点
基于 fs 读取和复制到应用沙箱环境实现文件上传，且完成数据回显功能
基于 Web 组件实现 webview 能力，实现用户协议和隐私协议功能
基于 router 都页面栈进行控制，完成页面栈维护和清理
基于 notificationManager 实现用户学习时间通知提醒
基于动画模块，实现页面转场动画的自定义以及下拉刷新自定义组件动画效果
使用鸿蒙第三方库 dayjs 实现时间相关处理业务逻辑
封装本地库，抽离 MiniCalendar 组件进行共享维护和迭代
整个项目涉及到鸿蒙原生能力应用，文件管理、网络管理、WebView、窗口管理完成项目需求。

# 技术亮点

• 实现手机侧统一视觉比例适配，解决 Meta50 显示问题
• 突破了文件上传 API 设计缺陷，和后台约定上传规范
• 共享库维护，将一些通用的组件统一维护，为后期项目迭代准备

# 其他：

如何实现地图？
如何实现支付？
学习建议#
鸿蒙能力集
卡片开发
本地数据库
原子化服务
端云一体
三个一多

# 黑马项目源码

https://github.com/HarmonyOS-Next/interview-handbook-project

# UI

https://codesign.qq.com/s/2kY5j3LVeb9ExNd 密码： 2ydd

# api

https://apifox.com/apidoc/shared-31e6a8d7-316a-4c5a-83c1-e5c7a2c343bf/api-121818399

# harmoneyOs 参考文档

https://www.arkui.club/chapter4/4_4_input.html

# 测试用户登录名和密码

登录名：
hmheima
hmheima9
hmheimaAdmin
hmheima1
hmheima2
hmheima3
hmheima4
hmheima5
hmheima6
hmheima7

用户名密码：
Hmheima%123

# 待完善

1，横竖屏问题
2，接口 token 存在，仍然报错的问题
3，项目页面 web 组件调试
