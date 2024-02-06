# flutter 开发环境配置

## windows 开发环境配置, 结合一下两个比较全面

https://flutter.cn/docs/get-started/editor
https://www.jianshu.com/p/4940db480fe2
https://baijiahao.baidu.com/s?id=1758041451400588196&wfr=spider&for=pc

## flutter 阿里源

```
 repositories {
        maven {
            url 'https://maven.aliyun.com/repository/public/'
        }
        maven {
            url 'https://maven.aliyun.com/repository/public'
        }
        maven {
            url 'https://maven.aliyun.com/repository/gradle-plugin'
        }
        maven {
            url 'https://maven.aliyun.com/repository/google'
        }
        maven {
            url 'https://maven.aliyun.com/repository/central'
        }
        mavenLocal()
        mavenCentral()


    }
```

# https://pub.dev/packages ，flutter 常用开发插件

webview_windows - 适用于 Windows 平台的基于 WebView2 的 webview 实现
flutter_webview_pro - 提供支持照片上传/拍照和地理定位的 WebView 小部件
flutter_web_auth - Flutter 插件，用于通过 Web 服务对用户进行身份验证
rich_clipboard - Flutter 插件，用于访问系统剪贴板中的富文本和其他数据类型
calendar_date_picker2 - 基于 Flutter CalendarDatePicker 的轻量级可定制日历选择器，支持单日期选择器、范围选择器和多选择器
web_view_tts - 在 Flutter WebView Android 中添加 Text-To-Speech 支持的 Flutter 插件
web_view_ble - 在适用于 Android 和 iOS 的 WebView Flutter 中添加低功耗蓝牙支持
flutter_side_menu - 完全可定制的侧边菜单
system_info2 - 提供对有关系统的有用信息（架构、位数、内核、内存、操作系统、CPU、用户）的轻松访问
moment_dart - 将 DateTime 转换为人类可读格式的包。灵感来自 moment.js
easy_refresh - 提供下拉刷新和上拉加载的小部件
mlkit_scanner - 适用于 iOS 和 Android 的 Google MLKit API 检测条形码、文本、面部和对象的 Flutter 插件
google_mlkit_face_detection - 使用 Google 的 ML Kit Face Detection 来检测图像中的人脸，识别关键的面部特征，并获取检测到的人脸的轮廓
face_camera - 实时检测人脸的 Flutter 相机插件，一旦检测到人脸，它可以自动捕捉
easy_debounce - Dart/Flutter 的一个非常易于使用的方法调用 debounce 包
pip_flutter - Flutter 画中画包
flutter_floatwing - 为 Android 制作浮动/覆盖窗口
local_notifier - 允许 Flutter 桌面应用程序显示本地通知
desktop_context_menu - 在光标位置打开上下文菜单的插件
fade_out_particle - 为诸如文本和图标之类的消失视图淡出粒子效果
flutter_animate - 通过简单、可定制、统一的 API 在 Flutter 中添加精美的动画效果和构建器
advstory - 先进的，完整的故事查看器。支持图像、视频、自定义小部件内容、手势、拦截器、侦听器、操纵器等
telegram_client - 用于制作基于应用程序电报的颤振和 userbot / bot 支持服务器端和客户端
screen_protector - 通过应用程序后台屏幕截图和防止 Android 和 iOS 屏幕截图安全数据泄漏
flutter_gl - Dart 通过 dart:ffi 跨平台调用 OpenGL API。跨平台的 3D 编程
zwidget - 将几乎所有小部件转换为可以轻松制作动画的伪 3D 版本
flutter_web_auth Flutter 插件，用于通过 Web 服务对用户进行身份验证 2022-02-24 161
google_mlkit_face_detection 使用 Google 的 ML Kit Face Detection 来检测图像中的人脸，识别关键的面部特征，并获取检测到的人脸的轮廓 2022-07-27 40
easy_debounce Dart/Flutter 的一个非常易于使用的方法调用 debouncer 包 2021-12-23 197
store_checker 查找当前安装的 apk/ipa 的来源 2022-09-19 30
twitter_api_v2 Dart 语言编写的 Twitter API v2.0 的轻量级和强大的包装库 2022-10-19 44
flame_splash_screen 使用带有徽标显示的漂亮闪屏来设计您的火焰游戏 2021-08-31 28
flame_forge2d Forge2D (Box2D) 支持 Flame 游戏引擎 2022-10-01 38
flutter_tesseract_ocr 基于神经网络 (LSTM) 的 OCR 引擎，该引擎专注于线识别。它支持 unicode (UTF-8)，可以识别 100 多种语言 2022-05-09 75
flame_audio 火焰游戏引擎的音频支持 2022-10-01 38
serverpod 为 Flutter 社区构建的下一代应用程序和 Web 服务器。它允许您在 Dart 中编写服务器端代码，自动生成您的 API，并以最小的努力连接您的数据库 2022-10-02 172
super_editor 可配置、可组合、可扩展的文本编辑器和文档渲染器。 2022-07-25 398
scroll_snap_list 允许在用户滚动结束时将事件“捕捉”到项目。 2022-05-29 274
f_logs FLog 提供快速 & 简单的日志记录解决方案。所有日志都保存到数据库中，然后可以在文件中导出。 2022-04-26 70
screen_recorder 记录你的 Flutter 部件并将记录导出为 GIF。 2022-01-18 68
flutter_link_previewer 从提供的文本中提取的 URL 预览，具有基本自定义和从缓存数据呈现的能力。 2022-10-02 161
any_link_preview 帮助您显示 Web 链接的预览。对于具有聊天功能的应用程序更有用。 2022-06-28 159
jwt_decode 用于解码 JSON Web 令牌，并检查并给出其到期日期 2021-03-23 87
dart_jsonwebtoken jsonwebtoken' (JWT) 的 dart 实现 2022-07-28 85
version 提供一个简单的类来解析和比较 semver.org 定义的语义版本 2022-06-15 149
snap_scroll_physics 允许您的滚动视图优先考虑要停止的点或不停止的区域。 2021-12-31 50
purchases_flutter 一个 Flutter 插件，可以轻松添加和管理应用内购买 (IAP) 和订阅。 2022-10-06 379
localstorage Flutter 的简单基于 json 文件的存储。替代本机 AsyncStorage 2021-03-14 276
advance_pdf_viewer 用于处理 PDF 文件的 Flutter 插件。适用于 Android 和 iOS 2022-01-04 339
encrypt PointyCastle 上的一组用于双向加密的高级 API。 2021-08-08 590
facebook_audience_network Facebook Audience Network 插件。您可以通过此插件展示 Facebook 横幅广告、插页式广告、奖励视频广告和原生广告。 2021-12-30 263
flutter_multi_formatter 国际电话号码格式化程序包、信用卡/借记卡和屏蔽格式化程序 2022-10-22 343
adobe_xd 使用“XD to Flutter”插件，根据您在 Adobe XD 中的设计生成使用 Flutter 构建应用程序的代码。 2022-01-28 335
flutter_code_push Flutter 应用代码推送的增强和实现。 2021-03-03 20
app_installer 全新的 Android+iOS 应用安装插件，支持打开应用商店和编辑评论，以及安装 Apk 文件。 2021-08-25 41
flutter_ume UME 是 Flutter 应用程序的应用程序内调试工具包平台。由字节跳动的 Flutter Infra 团队制作。 2022-09-26 56
english_words 用于处理英语单词的实用程序。 2021-03-24 414
fresh 用于 dart 的令牌刷新库。该包公开了各种刷新令牌实现（REST、GraphQL 等）通用的核心组件。 2022-04-04 113
jwt_decoder 帮助您解码 Json Web Tokens，您还可以知道 JWT 是否已经过期。 2021-03-26 289
google_ml_kit 用于实现谷歌为移动平台制作的独立机器学习套件。 2022-07-27 543
flutter_cube 渲染 Wavefront 对象文件的 Flutter 3D 小部件。 2021-03-13 232
change_app_package_name 使用单个命令更改应用程序包名称。更新 AndroidManifest、build.gradle、MainActivity 文件并自动将 MainActivity 文件移动到新的目录结构。 2022-05-29 817
forge2d Dart 的 2D 物理引擎，也适用于 Flutter 中的 Flame 游戏引擎。 2022-04-11 74
bonfire 使用 Flame 更简单地创建 RPG 风格或类似的游戏。 2022-10-07 257
ml_algo 机器学习算法、机器学习模型性能评估功能。 2022-08-22 66
easy_localization 轻松快速地国际化和本地化您的 Flutter 应用程序，这个包简化了国际化过程。 2022-05-13 1812
xterm 一个快速且功能齐全的 Flutter 应用程序终端模拟器。 2022-09-13 106
flutter_genius_scan 适用于 iOS 和 Android 的 Genius Scan SDK 的 Flutter 插件。它允许使用智能手机相机扫描纸质文档。 2022-10-04 76
flutter_plugin_android_lifecycle 用于在其他插件中访问 Android 生命周期。 2022-07-12 71
proste_lint 提供默认 lint，即插即用，方便团队协作。 2021-09-29 0
flare_splash_screen 应用程序的初始化完成一些工作之前，具有带有 Flare 动画的 Splash 屏幕。 2021-04-16 215
opencv_4 包含 OpenCV 模块集合的 Flutter 包项目。 2021-04-02 65
lint 一套针对 Dart 和 Flutter 项目的意见建议、社区驱动的 lint 规则。 2022-07-26 724
build_context 简化了 BuildContext 中大多数使用的属性/功能的访问包。 2021-03-10 138
uni_links 用于接受传入链接的 Flutter 插件 - 应用程序/深层链接 (Android)、通用链接和自定义 URL 方案 (iOS)。 2021-04-28 1023
simple_gesture_detector 易于使用、可靠且轻量级的 Flutter 应用程序手势检测器。 2021-03-04 43
render_metrics 获取小部件指标的库。使用 RenderObject 获取小部件相对于屏幕窗口的大小和位置，以及小部件之间的差异。 2021-12-13 90
form_field_validator 简单的 flutter 表单字段验证器，提供常见的验证选项。 2021-03-16 363
matrix_gesture_detector 将平移/旋转/缩放手势映射到 Matrix4 对象的手势检测器。 2019-03-08 64
formz Dart 中的统一表单表示，旨在以通用方式简化表单表示和验证。 2021-10-14 402
flutter_background_service 用于在后台执行 dart 代码的 flutter 插件。 2022-10-12 532
flutter_foreground_plugin Flutter 的前台服务插件。仅支持安卓，iOS 暂不支持。 2021-03-10 49
neat_periodic_task 长时间运行的进程中可靠地运行周期性任务的辅助类，例如 Web 服务器。 2021-03-03 108
cron 类似于 cron 的基于时间的作业调度程序。以固定时间或间隔定期运行任务。 2022-04-10 301
scanbot_sdk 适用于 Android 和 iOS 的 Scanbot Scanner SDK 的 Flutter 插件。提供文档扫描、QR 和条形码扫描、PDF 创建、TIFF、OCR 等功能。 2022-09-28 58
flutter_archive 在 Android、iOS 和 macOS 中创建和提取 ZIP 存档文件。递归压缩目录或给定文件列表中的所有文件。 2022-05-07 100
fullscreen 可以轻松地在 Flutter 应用程序中启用全屏。实现了 android 平台的三种全屏模式。 2021-03-14 38
flutter_uploader 用于创建和管理上传任务的插件。支持 iOS 和安卓。 2020-12-26 188
after_layout 您的小部件的第一个布局完成后执行代码，即在显示第一帧之后。 2022-05-16 560
url_strategy 允许使用单行代码设置 Web 应用程序 URL 策略。 2021-02-24 362
syncfusion_flutter_pdfviewer Flutter PDF Viewer 库用于无缝高效地显示 PDF 文档。 2022-10-18 499
mask_text_input_formatter 为 TextField 和 TextFormField 提供了 TextInputFormatter。 2022-08-02 751
email_validator 简单（但正确）的用于验证电子邮件地址的 dart 类。 2022-08-02 679
phone_number 用于解析、格式化和验证国际电话号码。 2022-08-10 121
stream_transform 用于转换和操作流的实用程序。 2022-10-05 150
ota_update 为 Android 和 iOS 提供 ota 更新，带有下载进度（仅限 Android）。 2021-11-22 152
collection 包含的实用函数和类的风格 dart:collection 使集合的工作更容易。 2022-10-14 651
admob_flutter 使用本机平台视图显示横幅广告的 Admob 插件。 2022-06-02 407
lpinyin 汉字转换拼音库。 2021-05-11 88
tflite 用于访问 TensorFlow Lite 的 Flutter 插件。 2021-04-13 441
excel 一个 flutter 和 dart 库，用于读取、创建、编辑和更新 Excel 表。 2020-08-17 498
syncfusion_flutter_pdf 用于在 Android、iOS 和 Web 平台上创建、阅读、编辑和保护 PDF 文件。 2022-10-18 450
flutter_inapp_purchase 应用程序购买。 2022-06-11 320
translator 用于 Dart 的免费且无限制的 Google 翻译 API。 2021-04-18 472
archive 为各种存档和压缩格式（例如 zip、tar、bzip2、gzip 和 zlib）提供编码器和解码器。 2022-10-16 392
pin_code_fields 帮助您生成 pin 码字段。 2022-04-03 1526
native_pdf_view 可在 Web，MacOS，Android 和 iOS 上呈现 PDF 文件。 2022-02-10 373
arcore_flutter_plugin 用于 ARCore SDK 的 Flutter 插件，Android 平台可构建新的增强现实体验。 2021-05-15 225
pdf 为 Web 或 Flutter 创建 pdf 文件。 2022-10-22 1653
flutter_native_splash 生成本机代码以使用背景颜色和初始图像来自定义 Flutter 的默认白色本机初始屏幕。支持暗模式，全屏等。 2022-10-09 4603
tflite_flutter TensorFlow Lite Flutter 插件提供了轻松，灵活和快速的 Dart API，可将 TFLite 模型集成到 Flutter 应用中。 2021-06-28 287
flutter_treeview 用于显示嵌套的分层数据。 2022-01-31 152
markdown 便携式 Markdown 库。它可以将 Markdown 解析为客户端和服务器上的 HTML。 2022-09-20 164
app_review 在 Flutter 中申请和撰写评论以及 Android 和 iOS 的开放式商店列表。 2022-07-25 236
arkit_plugin ARKit-Apple 的 iOS 移动设备增强现实（AR）开发平台。 2021-10-16 317
auto_size_text 可自动调整文本大小以使其完全适合其边界。 2021-10-27 3134
flutter_markdown Flutter 的 Markdown 渲染器。 2022-09-14 795
flutter_colorpicker 一款受 chrome devtools 启发的 HSV（HSB）/ HSL 拾色器。 2021-12-12 591
flutter_unity_widget Flutter Unity 3D 小部件，用于将 Unity 游戏场景嵌入 flutter 中。 2022-09-01 594
flame Flutter 游戏引擎。 2022-10-01 1159
logger 小型，易于使用且可扩展的记录器，可打印精美的日志。 2021-08-26 1794
touchable 为 CustomPainter 中在画布上绘制的每个 Shape 添加各种手势回调。 2022-04-18 168
rich_clipboard Flutter 插件，用于访问系统剪贴板中的富文本和其他数据类型 2022-08-15 22
web_view_tts 在 Flutter WebView Android 中添加 Text-To-Speech 支持的 Flutter 插件 2022-08-26 1
web_view_ble 在适用于 Android 和 iOS 的 WebView Flutter 中添加低功耗蓝牙支持 2022-08-21 2
system_info2 提供对有关系统的有用信息（架构、位数、内核、内存、操作系统、CPU、用户）的轻松访问 2022-06-03 24
mlkit_scanner 适用于 iOS 和 Android 的 Google MLKit API 检测条形码、文本、面部和对象的 Flutter 插件 2022-09-21 25
face_camera 实时检测人脸的 Flutter 相机插件，一旦检测到人脸，它可以自动捕捉 2022-06-16 58
screen_protector 通过应用程序后台屏幕截图和防止 Android 和 iOS 屏幕截图安全数据泄漏 2022-10-21 40
flutter_alarm_clock 连接安卓时钟应用 2021-12-22 39
installed_apps 设备上已安装应用程序相关的实用方法 2022-05-30 31
async_wallpaper 在 Android 上异步设置壁纸 2022-10-02 36
volume_controller 用于 ios 和 android 控制系统音量的 Flutter 音量插件 2022-08-24 32
palestine_trusted_device 检查设备是否为模拟器、root、越狱、开发者模式等。 2022-04-10 22
screen_capture_event 捕获 Android 和 iOS 的屏幕捕获（屏幕截图和屏幕录制）事件 2022-10-01 35
status_bar_control 状态栏控件，可让您控制 iOS 和 Android 中的状态栏颜色、样式（主题）、可见性和半透明属性 2022-02-20 32
sms_advanced 允许在 Android 中发送、接收、查询短信、发送短信和查询联系人信息 2021-08-04 30
android_sms_retriever 用于自动检索短信中发送的 OTP 代码，无需在 Android 中获得短信许可 2022-07-02 20
flutter_siri_suggestions 用于在 Siri Suggestions 上曝光的 Flutter 插件 2022-03-24 30
flutter_callkit_incoming 用于在 Flutter 应用程序中显示来电 2022-08-25 108
screen_brightness 用于控制屏幕亮度的插件 2022-09-25 52
native_drag_n_drop 允许您将本机拖放支持添加到您的颤振应用程序中 2022-02-02 67
timezone 时区数据库和时区感知 DateTime 2022-09-14 226
flutter_native_timezone 用于获取操作系统本地时区 2021-06-04 186
connectycube_flutter_call_kit 用于在应用程序在后台或终止时显示呼叫屏幕 2022-09-16 74
huawei_scan HUAWEI Scan Kit 扫描解析所有主要的一维和二维条码并生成二维码，帮助您将条码扫描功能快速构建到您的应用程序中 2021-10-01 11
dual_screen 可折叠和双屏支持，例如 TwoPane 小部件和铰链角度传感器数据 2022-05-05 59
flutter_barcode_listener 监听任何硬件条码扫描器，无需任何制造商 SDK 2022-03-03 68
quick_blue 跨平台 BluetoothLE 插件 2022-03-21 62
wifi_scan 用于扫描附近可见的 WiFi 接入点 2022-08-28 21
credit_card_scanner 用于 Flutter 的快速、准确和安全的信用卡和借记卡扫描仪，card_scanner 的持续工作 2022-07-29 27
carp_health_package CARP 健康采样包。从 Apple Health 或 Google Fit 采样健康数据 2022-09-25 6
carp_mobile_sensing Flutter 的移动传感框架。一个软件框架，用于通过探针从手机和连接的可穿戴设备中收集传感器数据。可以延长 2022-10-05 15
huawei_health Health Kit 提供了一个具有健身和健康开放能力的数据平台 2022-04-29 12
health_kit_reporter 帮助通过 HealthKit 框架从 Apple Health 写入或读取数据 2022-05-27 39
otp_autofill 使用 User Consent API 和 Retriever API 实现 OTP 自动填充的 Android。添加从另一个输入接收 OTP 代码的可能性 2021-12-07 115
live_icon 用于实时更改应用程序图标和标签 2021-07-01 29
flutter_siri_suggestions 用于在 Siri Suggestions 上曝光的 Flutter 插件也可以通过 Siri 唤醒特定功能 2022-03-24 30
wallpaper_manager_flutter 用于将大图像设置为墙纸，而不会从系统文件或缓存的图像文件中跳过 Android 设备上的主屏幕、锁定屏幕和两个屏幕的帧 2021-07-03 31
pasteboard 从剪贴板读取图像、文件并将文件写入剪贴板 2022-07-22 35
flutter_vibrate 触觉反馈插件 2021-09-30 127
mobile_scanner 基于 MLKit 的 Flutter 通用条码和二维码扫描器，qr_code_scanner 的持续工作。 2022-05-31 588
flutter_blue_plus FlutterBluePlus 是 Flutter 的蓝牙插件，flutter_blue 是 FlutterBlue 的持续工作。 2022-08-18 193
screen_capturer 允许 Flutter 桌面应用程序捕获屏幕截图。 2022-09-17 21
safe_device 可以轻松实现越狱、root、模拟器和虚假位置检测等安全步骤。 2022-04-07 129
flutter_shortcuts 用于在主屏幕上创建静态和动态应用程序/对话快捷方式。 2021-12-25 84
flutter_shortcuts 用于在主屏幕上创建静态和动态应用程序/对话快捷方式。 2021-12-25 84
open_mail_app 该库提供了查询设备以查找已安装的电子邮件应用程序并打开这些应用程序的功能。 2022-02-23 84
flutter_contacts 用于在 Android 和 iOS 上读取、创建、更新、删除和观察原生联系人，支持 vCard 和联系人权限处理。 2022-06-22 165
camerakit 使用原生 android 和 ios API 来拍照和扫描带有可控闪光灯的条形码。 2021-03-28 33
flutter_background 通过使用前台服务、唤醒锁定和禁用电池优化来保持 Flutter 应用程序在后台运行的插件。 2021-11-14 177
call_log 用于访问和查询通话记录日志。 2022-07-15 71
images_picker 用于从 Android 和 iOS 图像库中选择图像/视频，并使用相机拍照/视频，将图像/视频保存到相册/图库。 2022-03-21 138
telephony 用于使用电话功能，例如获取网络信息、拨打电话、发送和接收 SMS 以及侦听传入的 SMS。 2022-05-19 244
barcode_scan2 通过相机扫描二维条码和二维码的插件。 2022-05-14 172
fk_user_agent 在 Flutter 中检索 Android/iOS 设备用户代理。 2022-01-19 23
flutter_nearby_connections 支持点对点连接，并为 Android 和 IOS 发现附近的设备。 2021-06-17 156
flutter_jailbreak_detection 越狱和 root 检测插件，这个插件包装了 Rootbeer 用于 Android 和 DTTJailbreakDetection 用于 iOS。 2021-09-24 143
sms_autofill 提供短信代码自动填充支持。 2021-10-12 528
external_app_launcher 帮助从应用程序中打开另一个应用程序。 2022-08-04 147
auto_orientation 以编程方式为 iOS 和 Android 设置设备方向。 2022-01-11 55
flutter_interactional_widget 重力感应交互的 widget 集合。 2021-08-01 10
flutter_phoenix 轻松地从头开始重新启动您的应用程序，丢失任何以前的状态 2022-08-23 347
tray_manager 允许 Flutter 桌面应用定义系统托盘。 2022-08-27 64
xiaomi_scale 用于从蓝牙小米体重秤进行测量的 Flutter 插件。 2021-12-08 10
secure_application 当用户离开应用程序时保护应用程序内容的可见性。 2022-01-17 251
sms_user_consent 在不添加任何权限的情况下请求用户的电话号码（支持双卡）和/或同意阅读短信。 2021-03-15 77
native_device_orientation 用于允许获取本机设备方向的插件。 2022-06-06 89
flutter_dynamic_icon 动态改变应用图标和应用图标的 flutter 插件。 2022-03-01 151
home_widget 提供用于创建适用于 Android 和 iOS 的 HomeScreen 小部件的通用界面。 2022-05-14 647
flutter_screen_lock 提供在 ios 和 android 上锁定屏幕的能力，除了密码之外，还可以使用生物特征认证。 2022-07-21 141
flutter_app_lock 用于在应用打开和应用暂停时显示锁定屏幕。 2021-07-28 74
pedometer 适用于 Android 和 iOS 的计步器和步数检测包。 2021-04-19 176
adv_camera 具有对焦（带对焦矩形）和变焦功能的高级相机。 2022-10-18 43
all_sensors 用于检索加速度计、陀螺仪、接近传感器数据的 Flutter 插件。 2022-06-17 21
camera_camera 适用于您的项目、Android 和 iOS 平台的简单相机插件。 2021-05-19 142
flutter_compass Flutter 指南针，航向在 0-360 之间变化，0 为北。 2021-09-09 92
flutter_better_camera 用于在 Android 和 IOS 上控制相机，支持相机馈送、捕获图像、捕获视频、流式图像缓冲区，并支持相机 API 允许的所有基本功能（闪光灯、AE 等）。 2021-06-04 60
native_screenshot 使用本机代码（iOS 和 Android）截取屏幕截图的简单插件。 2021-04-04 42
file_selector 用于打开和保存文件的 Flutter 插件。 2022-10-06 149
r_upgrade 用于升级和安装应用程序的插件，支持 Android 和 IOS。 2022-05-12 98
gallery_saver 将网络或临时文件中的图像和视频保存到外部存储。 2021-10-19 316
receive_sharing_intent 使 flutter 应用程序能够接收来自其他应用程序的共享照片、文本或 url。 2021-03-14 488
clipboard_listener flutter 粘贴板监听器可以监听粘贴板的变化并通过回调通知你。 2021-04-07 8
perfect_volume_control Flutter 音量控制插件，支持安卓和 IOS，具有：显示隐藏音量图标、音量变化监控、设置音量、获取设备当前音量。 2021-09-22 26
usb_serial 该插件将允许您轻松使用基于 FTDI 或 CDC（以及更多！）协议的 USB uart 硬件。 2021-11-28 92
flutter_device_type 确定 Flutter 上手持设备的类型。就像设备是平板电脑还是 iPhoneX。 2021-03-11 48
watcher 文件系统观察者。它监视目录内容的更改，并在添加、删除或修改文件时发送通知。 2022-10-14 110
platform_device_id 从 android、ios、windows、linux、mac、web 获取设备 ID。 2021-04-04 214
health iOS HealthKit 和 Android GoogleFit 服务的包装器，用于读取健康和健身数据。 2022-10-21 265
flutter_ringtone_player 简单的系统默认铃声、闹钟和通知播放器。 2022-04-07 164
platform_info 包含有关当前平台的信息，例如构建模式和操作系统。 2022-05-19 64
flutter_phone_direct_caller 可直接从应用程序拨打号码，无需拨打电话拨号器。 2022-04-21 211
wallpaper_manager 用于更改 Android 设备上的主屏幕、锁定屏幕（或两者）壁纸。 2020-08-10 96
shake 用于检测手机抖动的 flutter 包，可调节的重力和复位周期。 2022-04-17 125
system_settings 用于在 iOS 和 Android 上打开系统和应用程序设置。 2022-04-03 48
system_shortcuts ANDROID 和 IOS Flutter 插件可以使用系统快捷方式，例如按主页、返回、增大音量、减小音量键和切换 wifi 以及蓝牙。 2020-07-15 34
disk_space 用于显示可用和总磁盘空间。 2021-10-04 52
mobile_number 用于获取设备的手机号码或列出 SIM 卡数据。 2022-10-11 67
flutter_keyboard_visibility 发现 Android 和 iOS 上的软键盘可见性状态。 2022-10-08 528
add_2_calendar 用于将事件添加到每个平台的默认日历。 2022-02-22 181
flutter_sms_inbox 可轻松查询设备短信收件箱。仅支持安卓。 2022-10-11 28
flutter_nfc_kit 在 Android 和 iOS 上提供 NFC 功能，包括读取元数据、读写 NDEF 记录。 2022-05-18 103
blue_thermal_printer 过蓝牙连接到热敏打印机的 Flutter 插件。 2022-07-19 202
flutter_bluetooth_serial Flutter 蓝牙串行库。 2021-08-17 237
flutter_reactive_ble 可与多个设备通信的反应式低功耗蓝牙 (BLE) 插件。 2021-11-08 366
flutter_beacon 用于在 Android 和 iOS 上作为信标 (iBeacon) 进行扫描和传输。 2021-08-21 59
flutter_ble_peripheral 使设备能够设置为外设模式，并通告自定义服务和特性。 2022-10-20 19
flutter_ble_lib 一个支持 BLE 操作的 Flutter 库。它使用 MultiPlatformBleAdapter 作为本机后端 2021-02-03 118
syncfusion_flutter_barcodes 生成器库用于生成和显示机器可读的行业标准一维和二维条码中的数据。 2022-10-18 101
background_fetch iOS 和 Android 的后台定期回调。包括 Android Headless 实现。 2022-09-30 774
audio_service 可在屏幕关闭时在后台播放音频。 2022-07-17 846
flutter_windowmanager 用于在应用程序运行时动态操作 Android WindowManager LayoutParams。 2021-08-26 181
path 一个全面的、跨平台的 Dart 路径操作库。 2022-05-18 915
awesome_notifications 通过 Firebase 或其他服务创建本地通知和推送通知（媒体通知、大图片、大文本等）的完整解决方案。 2022-10-16 1780
qrscan 使用 android 设备扫描条码和二维码。 2022-08-05 362
keyboard_actions 向 Android / iOS 键盘添加功能。。 2022-09-29 812
contacts_service 用于在 Android 和 iOS 设备上检索和管理联系人。 2021-09-22 441
flutter_email_sender 允许使用本机平台功能从 flutter 发送电子邮件。 2022-02-09 305
flutter_offline 用来处理离线在线连接。 2022-02-07 424
clipboard 帮助将文本复制到剪贴板并从剪贴板粘贴。 2021-03-09 431
sign_in_with_apple Flutter 启动 Apple 登录。 2022-07-17 1146
flutter_secure_keyboard 移动安全键盘可防止 KeyLogger 攻击和屏幕捕获。 2021-08-10 17
in_app_purchase 用于在 Flutter 应用程序中购买的独立于店面的 API。 2022-10-21 1271
uuid 适用于所有 Dart 平台（Web、VM、Flutter）的 RFC4122（v1、v4、v5）UUID 生成器和解析器。 2022-02-19 1317
flutter_device_details 针对 Android 和 iOS 设备的设备详情信息 2020-08-30 6
wifi_iot 处理 WiFi 连接和热点（AP、STA） 2022-08-28 175
open_settings Android 和 Ios 中打开各种设置界面最全的 flutter 插件包。 2021-07-21 122
qr_code_scanner 在 iOS 和 Android 上运行的 QR 码扫描仪，与 Flutter 无缝集成，比本机 Activity 或 ViewController 进行扫描要好得多。 2022-08-15 1417
share_extend 用于与系统 ui 共享文本，图像，视频和文件。 2021-04-05 116
flutter_vpn 应用内调用 VPN 服务。 2022-04-24 73
flutter_statusbarcolor_ns 帮助您以编程方式更改 Flutter 应用程序状态栏的颜色或导航栏的颜色。 2021-10-14 65
battery_plus 访问有关电池状态（充满，充电，放电）的信息。 2022-10-20 198
workmanager Flutter Workmanager。此插件可让您安排 Android 和 iOS 上的后台工作。 2022-10-20 1147
flutter_sms 可在 iOS 和 Android 上发送短信和彩信。 2022-06-06 241
sensors_plus 用于访问加速度计和陀螺仪传感器。 2022-10-20 412
network_info_plus 用于发现网络信息（例如，WiFi 详细信息）。 2022-10-20 293
geolocator Flutter 的地理位置插件。该插件提供了用于通用位置（GPS 等）功能。 2022-09-22 3635
package_info_plus 用于查询有关应用程序包的信息。 2022-10-20 1076
device_info_plus 可提供有关设备（制造商，型号等）以及运行该应用程序的 Android 或 iOS 版本的详细信息。 2022-10-20 1153
connectivity_plus 用于发现 Android 和 iOS 上的网络状态（WiFi 和移动/蜂窝）连接。 2022-10-21 1700
nfc_manager 用于访问 Android 和 iOS 上的 NFC 功能。 2022-09-18 200
flutter_udid 在 iOS 和 Android 上重新安装的应用程序之间检索持久性 UDID 的插件。 2021-03-28 78
flutter_camera_ml_vision 可显示相机预览并使用 Firebase ML Vision 检测事物。 2021-04-30 93
dokit 滴滴 DoKit For Flutter，一个 DoKit 针对 Flutter 环境的产研工具包，内部集成了各种丰富的小工具，UI、网络、内存、监控等等。 2021-07-06 35
wechat_assets_picker 对标微信的多选资源选择器，99%接近于原生微信的操作，纯 Dart 编写，支持选择的同时也支持预览资源。 2022-10-12 410
camerawesome 社区提供的开源相机插件。 2022-06-21 347
printing 允许 Flutter 应用程序生成文档并将其打印到 android 或 ios 兼容打印机。 2022-09-10 920
flutter_local_notifications 用于显示和推送 Flutter 应用程序的本地通知（定时、通知声音）。 2022-10-11 4192
flutter_contact 在 Android 和 iOS 设备上检索，创建和保存联系人以及与联系人相关的事件。 2021-10-30 56
sensors 访问 Android 和 iOS 加速度计和陀螺仪传感器。 2021-05-26 389
app_settings 从应用程序打开 iOS 和 Android 手机设置。 2022-06-09 564
wakelock 在 Android 和 iOS 上启用和切换屏幕唤醒锁，以防止屏幕自动关闭，本质上，这使您可以使设备保持唤醒状态，即防止设备进入休眠状态。 2022-07-07 1058
flutter_downloader 用于创建和管理下载任务的插件。 2022-09-17 998
open_file 调用本机 APP 打开带有字符串的文件。 2021-05-07 632
path_provider 查找文件系统上的常用位置。 2022-06-06 3229
package_info 查询有关应用程序包的信息。 2021-05-26 935
connectivity 发现 Android 和 iOS 上的网络（WiFi 和移动/蜂窝）连接状态。 2021-05-26 1872
image_picker 用于从 Android 和 iOS 图像库中选择图像，并使用相机拍摄新照片。 2022-10-05 4528
permission_handler 提供一个跨平台(iOS, Android) API 来请求和检查权限。Android 上也称为应用程序快捷方式。 2022-10-19 3145
quick_actions 用于在主屏幕上创建快捷方式，在 iOS 上也称为快速操作，在 Android 上也称为应用程序快捷方式。 2022-10-13 539
battery 用于访问有关 Android 和 iOS 上电池状态（充满，充电，放电）的信息。 2021-05-26 272
device_info 从 Flutter 应用程序中获取当前设备信息。 2021-11-01 1262
url_launcher 一款支持 android 和 IOS 的插件，其中包含打开网址、发送邮件、拨打电话、以及发送信息功能。 2022-09-28 5106
local_auth 提供了对用户执行本地设备上身份验证的方法（指纹解锁）。 2022-08-09 1665
device_apps 获取设备上安装的应用程序列表的插件（仅适用于 Android）。 2022-04-01 254
file_picker 允许您使用本机文件浏览器来选择单个或多个绝对文件路径，并具有扩展名过滤支持。 2022-10-20 2731
vibration iOS 和 Android 设备上处理震动的插件。 2022-08-31 373
system_info 可以轻松访问有关系统的有用信息（architecture, bitness, kernel, memory, operating system, CPU, user)。 2021-07-01 42
flutter_blue Android 和 iOS 上与低功耗蓝牙设备连接和通信。 2021-03-15 786
camera 获取有关和控制 Android 和 iOS 上的相机的信息。支持预览摄像头，捕获图像，捕获视频。 2022-10-21 1352
flutter_app_badger 用于在启动器上更新应用程序徽章的插件。 2022-09-16 585
device_calendar 修改用户设备上的日历。 2022-02-20 143
项目相关

依赖 描述 更新时间 likes
once 想要定期运行一段代码（一次 - 每日 - 每周 - 每月 - 在新版本上 - 任何时期） 2022-04-05 108
sentry Dart 的崩溃报告库，可将崩溃报告发送到 Sentry.io。 2022-10-19 369
firebase_crashlytics Firebase Crashlytics 的 插件，它向 Firebase 控制台报告未捕获的错误。 2022-10-20 751
firebase_analytics Google Analytics for Firebase 的 Flutter 插件，这是一种应用测量解决方案，可提供有关 Android 和 iOS 上应用使用情况和用户参与度的洞察。 2022-10-20 805
bloc 可预测的状态管理库，有助于实现 BLoC（业务逻辑组件）设计模式。 2022-08-06 1971
adaptive_theme 允许在明暗主题之间动态切换并添加系统自适应主题支持。 2022-07-25 405
faker 用于生成假数据的库。faker 深受 Python 包 faker 和 Ruby 包 ffaker 的启发。 2021-05-15 527
sentry_flutter Flutter 的 Sentry SDK，捕获本机层中的错误。 2022-10-19 452
logging 提供用于调试和错误记录的 API。 2022-10-05 452
fvm 一个简单的 cli 来管理每个项目的 Flutter SDK 版本。支持通道、发布和本地缓存，以便在版本之间快速切换。 2022-07-06 403
sizer 可轻松使 Flutter 应用程序响应。自动调整 UI 以适应不同的屏幕尺寸。 2021-09-15 1129
flutter_mobx MobX 的 Flutter 集成。 2022-09-19 535
flutter_dotenv 使用 .env 文件轻松配置任何带有全局变量的 Flutter 应用程序。 2021-08-12 805
biometric_storage 加密的文件存储，可以选择通过针对 Android，iOS，MacOS 的生物特征识别锁进行保护，并部分支持 Linux，Windows 和 Web。 2022-06-16 167
flutter_hooks React hooks 的 flutter 实现。 2022-06-24 1441
responsive_builder 为小部件定义可读的响应式 UI。 2022-08-31 1092
supercharged 为所有 Flutter 开发人员带来了 Kotlin 等语言的所有舒适功能。 2021-09-18 892
auto_route 声明式路由解决方案。 2022-10-12 1887
flutter_bloc 轻松实现 BLoC（业务逻辑组件）设计模式。 2022-08-14 4663
web_socket_channel WebSocket 的 StreamChannel 包装器。提供跨平台的 WebSocketChannel API，该 API 的跨平台实现可通过基础 StreamChannel 进行通信。 2022-04-26 713
json_serializable 通过注释 Dart 类自动生成用于与 JSON 相互转换的代码。 2022-10-19 2287
double_back_to_close_app 可让 Android 用户按下两次后退按钮以关闭应用程序。 2021-12-02 279
flex_color_scheme 制作和使用基于 MaterialApp 主题的精美配色方案。 2022-09-21 1252
dartx 静态扩展方法的集合。 2022-04-12 624
responsive_framework 轻松使 Flutter 应用程序具有响应能力。自动使 UI 适应不同的屏幕尺寸。 2022-05-18 2001
device_preview 预览 Flutter 应用在其他设备上的外观和性能。 2022-05-24 2475
i18n_extension Flutter 的翻译和国际化（i18n）。大型和小型项目均易于使用。 2022-08-29 280
rxdart RxDart 是利用本机 Dart Streams API 为流行的用于异步编程的 reactX api 的实现。 2022-07-16 1880
google_mobile_ads 希望通过 Flutter 应用获利的发布商，适用于 Google 移动广告的 Flutter 插件，支持横幅广告，非页内广告（全屏），奖励广告和原生广告。 2022-10-12 1438
flutter_redux 轻松使用 Redux Store 来构建 Flutter Widgets。 2022-05-14 426
catcher 用于捕获错误的插件。当开发人员未发现错误时，允许进行处理。插件提供了多个错误处理程序。 2021-11-07 485
sentry_flutter Flutter 的崩溃报告库，可将崩溃报告发送到 Sentry.io。 2022-10-19 452
mobx 用于被动管理应用程序状态的库。 2022-10-12 965
google_fonts 在 Flutter 应用程序中包含来自 fonts.google.com 中的字体的软件包。 2022-05-23 4067
get Flutter 的轻便而强大的解决方案。它结合了高性能状态管理，智能依赖注入和快速实用的路由管理。 2022-05-22 10634
get_storage 完全用 Dart 编写的快速，轻巧且同步的键值存储。 2021-07-21 1102
flutter_screenutil 不同终端屏幕适配问题。 2022-09-02 2610
crypto SHA，MD5 和 HMAC 加密功能的实现 2022-04-27 963
Dio Dart 的强大 Http 客户端，支持拦截器，全局配置，FormData，请求取消，文件下载，超时等。 2022-03-31 4608
shared_preferences 读取、设置缓存。 2022-05-11 6367
fluro Flutter 的 企业级的路由框架。 2021-03-01 738
provider 官方推荐的状态管理。 2022-10-11 7541
intl 包含用于处理国际化/本地化消息，日期和数字格式和解析，双向文本以及其他国际化问题的代码。 2021-02-03 3443
event_bus EventBus 能够简化各组件间的通信，用于组件 A 调用组件 B 中的方法。 2021-03-04 448
flustars 依赖于 Dart 常用工具类库。 2021-03-08 79
common_utils 以及对其他第三方库封装，致力于为大家分享简单易用工具类。 2022-02-12 118
jiffy 一个受 moment.js 启发的程序包，用于解析，处理和格式化日期。 2021-12-18 551
列表相关

依赖 描述 更新时间 likes
flutter_reorderable_grid_view 更新子项或尝试使用拖放重新排序它们时启用动画 GridView 2022-07-30 62
drag_and_drop_lists 允许对两级列表进行拖放重新排序。 2022-08-04 249
loading_more_list 支持 ListView、GridView、WaterfallFlow 和 Slivers 的加载更多列表。 2022-08-17 100
sticky_and_expandable_list 构建分组列表，支持展开/折叠部分和粘性标题，支持将其与 sliver 小部件一起使用。 2022-07-25 117
animated_image_list Flutter 动画图像列表，具有视差效果和图像灯箱。 2021-05-30 69
inview_notifier_list 构建列表视图并在小部件出现在屏幕上时发出通知。 2021-12-28 322
alphabet_list_scroll_view 带有 A-Z 侧滚动条的可自定义列表视图。 2021-03-31 173
horizontal_data_table 左侧有固定列的水平数据表。 2022-09-05 289
flutter_animation_progress_bar 可以分组为多个部分。 2022-10-12 165
implicitly_animated_reorderable_list 它在两个列表的更改之间隐式动画，支持重新排序其项目。 2021-10-22 392
grouped_list 可以分组为多个部分。 2022-06-18 863
keframe 帮助你提升 Flutter 应用在任何场景下的流畅度。 2022-05-14 122
flutter_wall_layout 将一组（具有不同形状的小部件）显示为垂直或水平列表 2021-09-26 107
flutter_pagewise 一次加载一页（或一批）内容的小部件库。 2022-10-08 174
waterfall_flow 快速构建瀑布流布局的 Flutter 网格视图。 2021-12-17 124
azlistview Flutter 粘性标题和索引 ListView。索引栏。如城市列表、联系人列表。索引和悬停效果。 2022-02-12 194
syncfusion_officechart 用于从头开始创建 Office 图表。 2022-10-18 54
syncfusion_flutter_xlsio 创建带有公式、图表、图像、超链接、自动调整行和列等的 Excel 文档。 2022-10-18 226
syncfusion_flutter_datagrid 用于在表格视图中显示和操作数据 2022-10-18 430
sliver_tools 一组有用的 sliver 工具。 2022-09-05 713
flutter_layout_grid 强大的 Flutter 网格布局系统 2022-05-06 444
scrollable_positioned_list 滚动列表，允许滚动到列表中的特定项目。 2022-10-01 1124
lazy_load_scrollview 延迟加载 ScrollView 的包装器。 2021-03-07 336
draggable_scrollbar 可以拖动滚动条以快速浏览垂直列表。 2021-04-04 284
material_floating_search_bar 可扩展的动画浮动搜索栏的 Flutter 实现。 2022-03-05 1270
editable 高度可定制，可编辑的数据表格。 2021-03-04 174
pluto_grid 数据表格展示。 2022-10-22 504
infinite_listview 具有可以在两个方向上无限滚动的项目的 ListView。 2021-03-14 95
infinite_scroll_pagination 当用户向下滚动屏幕时，懒惰地加载和显示项目页面。 2022-05-23 2036
flutter_annual_task 用于显示日常任务（如 Github-Contributions）的网格视图。 2021-03-07 38
flutter_staggered_animations 轻松将交错动画添加到 ListView，GridView，Column 和 Row 子级中。 2022-08-23 1254
dropdown_search 用于让用户搜索在单个或多个选择列表中显示在对话框或菜单中的下拉列表。 2022-09-22 1104
extended_nested_scroll_view 扩展的嵌套滚动视图。 2022-07-01 152
drag_select_grid_view 一个同时支持拖动和点击以选择其项目的网格。 2022-07-24 106
sticky_infinite_list 具有粘性标头的无限列表。 2022-02-20 143
json_table Json Table 小部件，用于显示 json（Map）中的表。支持列切换。 2021-03-06 195
filter_list 从列表中过滤数据。 2022-07-02 291
flutter_swipe_action_cell iOS 式单元格滑动操作效果。 2022-06-12 230
flutter_staggered_grid_view 瀑布流展示控件，支持多列且行大小不同。 2022-07-10 2707
reorderables 可重新排列的表格，行，列，环绕，条状列表，允许拖放其子级。 2022-05-12 671
sticky_headers 可以将标题放置在可滚动内容上，该内容在滚动内容时将粘贴在容器的顶部。 2022-05-16 578
flutter_sticky_header 粘滞标题。在 CustomScrollView 中使用它。 2022-07-13 591
flutter_slidable 实现的可滑动列表项，具有可被取消的定向滑动动作。 2022-07-14 3674
UI / 小部件

依赖 描述 更新时间 likes
easy_refresh 提供下拉刷新和上拉加载的小部件 2022-08-09 87
pip_flutter Flutter 画中画包 2021-12-03 27
flutter_floatwing 为 Android 制作浮动/覆盖窗口 2022-07-11 29
advstory 先进的，完整的故事查看器。支持图像、视频、自定义小部件内容、手势、拦截器、侦听器、操纵器等 2022-07-20 38
zwidget 将几乎所有小部件转换为可以轻松制作动画的伪 3D 版本 2022-06-02 29
typewritertext 简单的打字机文本动画包装器 2022-10-09 23
rounded_background_text 用圆角突出显示的文本和文本字段 2022-08-03 22
scroll_loop_auto_scroll 自动将自定义子小部件滚动到无限循环 2022-05-25 39
flutter_lyric 音乐歌词阅读器，支持高亮、翻译歌词、流畅动画、自定义 UI、解析 2022-09-09 33
neon_widgets 完整的霓虹灯解决方案 2022-03-30 33
signal_strength_indicator 可定制信号强度指示器小部件 2021-09-28 23
slide_countdown 创建简单的幻灯片动画倒数/倒数计时器 2022-09-15 178
tab_container 动画和可自定义的选项卡视图小部件 2022-04-21 126
tabbed_view 经典的桌面样式选项卡组件 2022-10-03 52
overscroll_pop Scrollview 的 Flutter 小部件，在 iOS 上的 Pinterest 和 Instagram 应用等过度滚动时弹出 2022-03-22 62
double_tap_player_view 像视频播放器一样通过双击和水平拖动来处理快进/快退行为的小部件 2022-02-03 31
flutter_onboarding_slider 具有平行设计的页面滑块，允许（文本）小部件或正文以不同的速度与背景滑动 2022-09-25 91
animated_toggle_switch 简单的动画切换开关，用于多种选择。 2022-04-22 221
animated_background 轻松扩展以在画布上绘制想要的任何内容。 2021-05-05 190
timeline_list 显示可自定义的小部件时间线。 2021-09-08 121
dotted_border 可以轻松地在任何小部件周围添加虚线边框。 2021-12-05 737
horizontal_card_pager 创建动态和漂亮的卡片视图。 2021-04-05 128
stop_watch_timer 简单的 CountUp 计时器 / CountDown 计时器。 2022-09-10 163
marquee_text 当孩子超过容器的宽度时自动滚动。 2021-12-05 30
animated_flip_counter 从一个数字翻转到另一个数字的隐式动画小部件 2022-08-05 217
vertical_card_pager 创建动态和漂亮的卡片视图。 2021-04-03 194
overflow_view 如果没有足够的空间，小部件会在一行中显示子级，并在末尾带有溢出指示符。 2021-04-10 156
glass_kit 用于在应用程序中实现玻璃态射。 2021-06-23 285
barcode_widget 条码生成小部件。 2022-08-12 167
card_scanner 快速、准确和安全的信用卡和借记卡扫描库。 2021-04-28 92
feedback 允许用户直接在应用程序中提供交互式反馈。 2022-05-12 598
pin_code_text_field 漂亮且高度可定制的 Flutter 小部件，用于输入 pin 码。适用于登录和 OTP 等用例。 2021-03-08 130
launch_review 帮助在 Google Play Store 和 Apple App Store 中留下用户评论/评分。 2021-03-08 286
bubble_showcase 小巧但功能强大的 Flutter 包，可让您突出显示应用程序的特定部分，以便向用户解释它们或展示应用程序的新功能。 2021-10-05 115
system_alert_window 用于在所有其他应用程序以及回调事件上显示 Truecaller 之类的覆盖窗口。 2022-10-18 143
bruno 类似 ElementUI 用于移动应用程序的企业级 Flutter 组件包。 2022-09-30 71
timer_count_down 简单的倒数计时器。用于创建一个简单的计时器。 2021-12-12 124
auth_buttons Auth Buttons 是一个 Flutter 小部件库，包括用于与最流行的社交网络（如 Google、Facebook、Apple 和 Twitter）进行身份验证的按钮。 2022-06-21 130
draggable_home Draggable 是一个用于添加漂亮的可拖动主页的部件。 2022-10-22 356
fluent_ui 在 Flutter 中实现 Windows UI。基于官方文档。 2022-10-22 1761
flutter_intro 为您的 Flutter 项目提供新功能介绍和分步用户指南的更好方法。 2022-05-13 375
circular_countdown_timer 使用圆形倒计时计时器制作动画圆形倒计时。 2022-06-23 369
particles_flutter 粒子动画的包，可以通过连接线控制动画速度、屏幕上粒子的数量、粒子的尺寸和形状等。 2021-07-22 105
html_editor_enhanced 适用于 Android、iOS 和 Web 的 HTML 富文本编辑器。 2022-06-04 363
zoom_widget 用于放大子小部件可以容纳的可修改大小的画布的小部件。 2022-09-21 124
dotted_decoration 虚线装饰是用于绘制矩形、圆形或圆角矩形的虚线分隔线、虚线边框的包。 2021-03-24 87
skeleton_loader 为你的应用程序提供了一个完全可定制的骨架屏。 2021-07-05 187
shimmer_animation 轻松创建简单而漂亮的骨架屏。 2021-06-29 222
neumorphic Neumorphism 用户界面的实现。 2020-08-09 232
sliver_header_delegate 一个灵活的 sliver header delegate，允许轻松自定义您的 SliverHeader。 2021-04-19 70
onboarding_overlay 灵活地控制有或没有目标元素的进入。 2022-04-19 196
cupertino_stepper Cupertino Stepper 步骤显示进度。 2021-12-11 167
flutter_fortune_wheel 抽奖幸运轮小部件。 2022-01-02 162
hashtagable 用于实现主题标签装饰文本的小部件和函数。像 Twitter 一样装饰以 # 开头的单词。 2022-04-22 122
native_updater 提示用户使用本机对话框进行更新。 2021-12-19 117
passcode_screen 用于显示密码输入屏幕，类似于原生 iOS。屏幕可定制颜色、大小、字体等。 2022-01-03 88
flutter_mentions 用于向您的应用程序添加@提及功能。 2021-05-24 130
otp_text_field 在您的应用程序中创建 OTP 文本字段小部件。 2022-04-25 142
fancy_on_boarding 用于快速、方便且美观的 OnBoarding 屏幕库。 2020-10-26 144
ripple_backdrop_animate_route 带有路线背景的波纹动画。 2022-06-20 25
in_app_update Android API 在 Android 上启用应用内更新。 2022-02-18 586
rating_dialog 漂亮且可定制的 Star Rating Dialog 包。 2022-04-29 160
rounded_loading_button 动画加载按钮小部件的简单实现。 2022-03-06 410
awesome_card 用于在您的应用程序中创建信用卡小部件。 2022-01-27 222
flutter_reaction_button Flutter 按钮反应它是完全可定制的小部件，例如 Facebook 反应按钮。 2022-07-15 221
simple_url_preview 显示 url 预览。可自定义的高度、背景和文本样式以及线条。 2021-06-15 67
floaty_head 创建自定义聊天头，在点击时显示隐藏内容，如 Messenger。 2020-09-20 201
flutter_rounded_progress_bar 圆形进度条，可自定义颜色和边框。 2021-03-18 64
tcard 像卡片一样，可以向左或向右滑动。 2021-03-30 158
juxtapose 用于通过拖动滑块拇指以水平或垂直显示滑块的任一侧来比较两个堆叠的小部件的小部件。 2021-10-06 81
flutter_signin_button 适用于 iOS 和 Android 的 Flutter 插件，用于为不同的社交媒体帐户生成登录按钮。 2021-03-31 755
styled_widget 通过使用方法定义小部件来简化小部件树结构。 2021-09-06 600
playing_cards 标准 52 张扑克牌卡片组的渲染库。 2022-04-19 90
intro_views_flutter 用于简单的材料设计应用程序介绍屏幕，带有一些很酷的动画。 2021-06-13 476
flutter_vant_kit 一个 vant 风格的 flutter UI 库。 2021-06-04 45
in_app_review Flutter 插件，用于在 Android、IOS 和 MacOS 上显示应用内评论/系统评级弹出窗口。 2022-01-12 1105
flutter_glow Flutter Glow ui 套件，可帮助您创建和使用发光的小部件。 2021-03-17 96
r_dotted_line_border 关于虚线边框的 Flutter 装饰盒包装。 2021-03-15 8
liquid_pull_to_refresh 一个漂亮的自定义刷新指示器，带有一些很酷的动画。 2022-01-10 456
focus_detector 检测您的小部件何时出现或从屏幕上消失。 2022-01-11 250
flutter_shimmer 创建指示加载状态的 Shimmer 效果。 2021-09-23 167
readmore 允许动态展开和折叠文本的 Flutter 包。 2022-06-20 480
extended_sliver 一个强大的 Sliver 扩展库。 2022-05-07 92
smooth_page_indicator 具有一组内置效果的可定制动画页面指示器。 2021-08-28 1764
visibility_detector 检测其子项的可见性并通知回调的小部件。 2022-05-05 570
flutter_instagram_stories 显示故事（视频和图像），如 Whatsapp 和 Instagram。 2022-10-09 141
expand_widget 能够轻松展开和收回小部件集合或文本。 2022-09-13 101
bubble_tab_indicator 为 TabBar 的选项卡指示器添加类似气泡的效果。 2021-03-08 218
custom_refresh_indicator 可以轻松实现自定义刷新指示器。 2022-06-14 362
flex_color_picker 可定制的 Flutter 自定义颜色选择器。 2022-09-09 255
glassmorphism 用于轻松实现 Glassmorphic UI （玻璃拟态） 的 Flutter 包。 2021-08-30 312
circular_profile_avatar 许开发人员实现带有边框、覆盖、缩写文本和许多其他功能的圆形轮廓头像。 2021-09-03 107
hand_signature 允许用手指绘制签名的签名板小部件。 2022-06-27 155
clippy_flutter 提供的自定义形状剪辑的小部件。 2020-03-15 126
align_positioned 它允许您以复杂的方式声明性地定位/调整其子项的大小。 2021-10-05 212
flutter_advanced_switch 高级开关控件为小部件自定义提供了丰富的 API。 2022-04-03 80
breathing_collection 带有呼吸动画的 Flutter 小部件。 2022-02-04 47
painter 一个用手指绘画的简单小部件。 2021-05-24 155
card_settings 用于构建设置表单的 Flutter 包。 2022-04-07 208
slider_button 用于激活/停用某些事件的可定制滑块按钮小部件。 2021-12-24 206
toggle_switch 一个简单的切换开关小部件。 2022-04-15 755
flutter_switch 易于实现的自定义开关。 2021-06-22 415
progress_state_button Android、IOS 和 Web 的进度按钮小部件。 2021-11-10 275
animated_icon_button 创建自定义动画 IconButton。包括所有可用的图标。基于原生 IconButton。 2021-06-05 182
multi_select_flutter 以您想要的方式制作多选小部件。 2022-03-14 450
flutter_material_pickers 轻松且一致地显示 material 主题选择器对话框。 2022-04-08 186
extended_text 扩展官方文本以快速构建内嵌图像或特殊文本。 2022-09-01 178
keyboard_dismisser 用于在键盘之外执行手势时隐藏键盘。 2022-05-20 169
back_button_interceptor 后退按钮拦截器。可用于在点击 Android 后退按钮时执行操作。 2022-10-16 211
day_night_time_picker 昼夜时间选择器。带有太阳和月亮资产的美丽昼夜动画。 2022-09-08 434
gradient_widgets 有漂亮的渐变的小部件。 2021-04-02 81
weather 一个天气插件，用于通过 OpenWeatherMap API 获取当前天气和预测。适用于 Android 和 iOS。 2021-05-17 132
screenshot_callback 可让您检测移动屏幕截图并在 iOS 和 Android 上执行回调函数。 2022-09-30 57
flutter_tex 用于渲染基于 LaTeX、TeX 和 MathML 并支持 HTML 和 JavaScript 的数学/数学、物理和化学、统计方程和表达式。 2022-03-05 208
flutter_linkify 将文本 URL 和电子邮件转换为 Flutter 文本中可点击的内联链接。 2021-04-13 517
intl_phone_number_input 用于以国际/国际格式输入电话号码。 2022-09-21 555
floating_bubbles 用于将前景上的浮动气泡添加到任何 Flutter 小部件的 Flutter 包。 2022-09-20 35
vertical_weight_slider 提供易于使用且可滚动的垂直重量滑块。 2021-12-26 29
slider_button 用于激活/停用某些事件的可定制滑块按钮小部件。 2021-12-24 206
story_view 像 Whatsapp 和 Instagram 一样显示故事。 2022-10-17 498
pinput 密码输入 (OTP) 文本字段，支持自定义数字键盘。密码、密码、验证码、安全、优惠券、Wowcher、2FA、两步验证、双因素身份验证。 2022-10-08 1164
backdrop material 背景实现。 2022-08-28 390
flutter_showcase 快速、简单和酷炫的方式，可以与全世界分享您的 Flutter 项目。 2020-04-22 61
weekday_selector 帮助您在应用中选择工作日。非常适合重复发生的事件、警报。 2022-03-26 88
im_stepper 漂亮、易于使用的步进器和页面指示器小部件。 2022-06-10 468
tutorial_coach_mark 帮助您以美观、简单和可定制的方式展示您的应用程序及其功能的指南。 2022-08-04 804
avatar_glow 带有炫酷背景发光动画的 Avatar Glow Widget。 2021-10-31 738
country_code_picker 用于显示国家/地区代码选择器。 2021-06-19 567
dash_chat 受 react-native-gifted-chat 启发的最完整的 Flutter 聊天 UI。 2021-05-29 421
bubble 用于像 Whatsapp 和其他人中的对话气泡一样聊天。 2021-03-10 493
splashscreen 大量定制可轻松为任何 flutter 应用程序创建一个介绍性的启动画面包。 2020-11-17 491
intro_slider 帮助你为你的应用制作一个很酷的介绍/入门页。 2022-09-27 932
introduction_screen 应用程序的介绍/入门页。 2022-03-30 1887
feature_discovery 向新用户显示特定功能的描述。 2021-12-05 639
step_progress_indicator 一系列选定和未选定步骤组成的条形指示器。 2022-01-02 565
marquee 无限滚动文本的 Flutter 小部件。 2022-06-04 638
settings_ui Agora Video SDK 的 Flutter 插件。 2022-01-26 629
slimy_card 漂亮的类似粘液的卡片动画，将卡片分成两部分。 2020-04-15 553
flutter_credit_card 一个信用卡小部件包，支持输入卡片详细信息，卡片翻转动画。 2022-09-15 509
numberpicker 数字选择器，支持滚动 2021-04-14 403
blobs 用最少的代码创建漂亮的斑点形状。 2021-06-15 286
clay_containers 为您自己的独特设计轻松创建自定义的新形态容器小部件。 2021-03-09 272
skeleton_text 提供了一种在 Flutter 项目中添加骨架屏加载动画的简单方法。 2021-03-12 276
chat_ui_kit 完整的 Flutter 聊天 UI 套件，它为您提供基本结构以及一组工具，可让您快速构建现代聊天 UI。 2022-09-01 46
flutter_form_builder 通过删除样板代码，重用验证，对更改做出反应并收集最终用户输入来帮助在 Flutter 中创建表单。 2022-10-06 1648
flutter_platform_widgets 通过单个小部件简化了 Material 和 Cupertino 小部件的使用。 2022-06-09 814
flutter_login 具有登录/注册功能的登录小部件，可帮助加快开发速度。 2022-06-22 1011
flutter_quill 支持移动和 Web 的富文本编辑器。 2022-10-21 844
sign_button 为不同的社交媒体帐户生成登录按钮。 2021-11-07 133
velocity_x 开源极简 UI 框架，可快速构建定制设计。 2022-10-12 1053
getwidget 带有预构建的 1000 多个 UI 组件。它使开发更快，更愉快。 2022-06-03 1509
chat_bubbles 聊天气泡小部件，类似于 Whatsapp 和更多形状。易于使用和实现聊天气泡。 2022-08-16 172
dotted_line 使用 Flutter 绘制虚线。您可以绘制一条漂亮的虚线。 2021-10-24 172
carousel_slider 轮播控件，支持无限滚动和自定义子控件。 2022-04-23 3595
flutter_summernote Flutter 中的文本编辑器。 2021-06-21 71
wave 创建具有自定义颜色，时间，浮动和模糊效果的波形小部件。 2022-06-14 489
credit_card_input_form 信用卡信息输入表格。 2021-04-03 53
scratcher 刮刮卡小部件。 2022-10-21 329
flutter_tags 创建可选和输入标签（TextField）。 2020-11-11 278
flutter_simple_calculator 提供简单的计算器。 2022-06-09 53
flutter_neumorphic 随时可用的 Neumorphic ui 套件。 2021-11-11 1379
flutter_spinkit 随时间变化而变化的加载指示器集合。 2021-08-28 2869
pull_to_refresh 一个提供上拉加载和下拉刷新的组件,同时支持 Android 和 Ios。 2021-05-07 2084
badges 用于创建徽章，可用于任何小部件的附加标记，例如，显示购物车中的许多物品。 2022-06-02 2204
city_pickers 适用于城市选择器的 Flutter 插件，弹出窗口小部件，按功能调用。 2022-08-03 59
argon_buttons_flutter 创建漂亮的“加载”和“计时器”按钮。无需担心每个按钮的动画和状态。 2021-05-07 337
flutter_easyrefresh 正如名字一样，EasyRefresh 很容易就能在 Flutter 应用上实现下拉刷新以及上拉加载操作。 2022-07-07 416
flutter_rating_bar 一个简单但完全可定制的评分栏。 2022-05-18 1503
flutter_easyloading 一个简单易用的 Flutter 插件，包含 23 种 loading 动画效果、进度条展示、Toast 展示。纯 Flutter 端实现，兼容性好，支持 iOS、Android。 2022-05-23 1293
dough 创建自定义的面团小部件以实现自定义的挤压效果。 2022-05-17 347
flutter_picker Flutter 插件选择器。包括 NumberPicker，DateTimePicker，ArrayPicker 和默认链接选择器。 2022-07-19 353
syncfusion_flutter_sliders 用于创建高度可定制且 UI 丰富的滑块、范围滑块和范围选择器小部件。 2022-10-18 541
expandable 通过单击标题或图标来展开或折叠的 Flutter 小部件。 2021-03-16 1300
flutter_typeahead 高度可定制的预先输入（自动完成）文本输入字段。 2022-09-17 1307
音视频类

依赖 描述 更新时间 likes
pod_player Vimeo 和 youtube 播放器 2022-08-04 161
acr_cloud_sdk 非官方的 ACR Cloud SDK，用于识别声音和音乐 influtter 2022-03-28 24
social_media_recorder 通过 Button 提供从麦克风到给定文件路径的录音机，以像社交媒体 Button 一样录制语音 2022-10-15 75
flutter_audio_waveforms 用于轻松将音频波形添加到您的应用程序，具有多个自定义选项 2022-10-19 87
audio_waveforms 允许在录制音频或从音频文件中生成波形 2022-09-12 164
zoom Zoom 客户端 SDK 的 Flutter 插件 2022-01-09 30
hmssdk_flutter 100ms SDK 的 Flutter 包，视频视频会议基础设施。 2022-10-20 43
video_editor 视频编辑器允许通过超级灵活的 UI 设计修剪、裁剪、旋转和缩放视频。 2022-06-23 243
flutter_sound_lite 用于音频播放和录制的完整 api，音频播放器，录音机，媒体播放器，媒体录音机，录音机，录音机。 2022-01-18 107
noise_meter 用于从手机的麦克风中收集噪音。 2022-03-03 67
audio_session 为应用设置 iOS 音频会话类别和 Android 音频属性，并管理您的应用的音频焦点、混音和闪避行为。 2022-07-17 146
on_audio_query 用于从设备存储中查询音频/歌曲信息 [标题、艺术家、专辑等]。 2022-05-17 95
audio_manager 用于音乐播放的插件，包括通知处理。 2021-10-05 121
dart_vlc 媒体播放、广播、录制和 chromecast 库。基于 libVLC 和 libVLC++。 2022-06-23 198
tflite_audio 用于 Flutter 的音频分类 Tflite 包（iOS & Android），可以支持谷歌可教机器模型。 2022-03-18 50
flutter_aliplayer Flutter 的阿里云播放器。 2022-10-20 9
youtube_player_iframe 官方 YouTube iFrame 播放器 API 的 Flutter 端口。支持网络和移动平台。 2022-09-15 337
flutter_playout 提供来自 URL 的音频/视频播放，并支持 iOS 和 Android 的背景音频、锁屏控件和播放器事件。 2021-06-11 190
video_thumbnail 从本地视频文件或视频 URL 创建缩略图。 2022-09-12 320
chewie_audio 带有 Cupertino 和 Material 播放控件的 Flutter 音频播放器。 2022-01-05 52
twilio_programmable_video 用于 Twilio Programmable Video 的 Flutter 插件，使您能够构建实时视频通话应用程序 (WebRTC)。 2022-09-30 187
video_player 用于在 Android、iOS 和 Web 上与其他 Flutter 小部件一起显示内联视频。 2022-08-22 1942
miniplayer 简化迷你播放器的创建。 2021-09-29 237
flutter_vlc_player Flutter 的 video_player 的 VLC 驱动替代品。 2022-06-03 301
flick_video_player 基于 video_player 的，flutter 视频播放器。 2022-06-21 338
tapioca Tapioca 是一个 Flutter 插件，用于在 Android 和 iOS 上进行视频编辑。 2022-09-14 102
media_info 利用平台代码来确定音频、视频和照片属性。 2022-10-23 33
light_compressor 功能强大且易于使用的 Flutter 视频压缩插件。 2021-11-14 82
alan_voice Alan 语音插件。 2022-10-17 76
agora_rtc_engine Agora Video SDK 的 Flutter 插件。 2022-09-28 572
video_compress 视频操作的轻量级库。压缩视频，删除音频，从 dart 代码中获取视频缩略图。 2022-06-20 370
flutter_ffmpeg 移动平台上运行 FFmpeg 的 Flutter 插件。 2021-08-04 321
youtube_player_flutter 使用官方 iFrame 播放器 API 播放或流式传输内联 YouTube 视频。 2022-10-11 995
better_player 基于 video_player 和 Chewie 的高级视频播放器。它解决了许多典型的用例，并且易于运行。 2022-06-05 857
flutter_tencentplayer 用于播放腾讯云点播视频，实时流媒体，离线下载等的本机插件。 2021-11-21 24
just_audio Flutter 的功能丰富的音频播放器。以各种音频格式循环播放，剪辑和连接来自任何来源）的任何声音，并实现无缝播放。 2022-09-15 2312
sounds 为音频播放和录制提供了完整的 api 和小部件。 2020-08-09 65
video_trimmer 用于修剪视频。这支持将修剪后的视频文件检索，修剪和存储到文件系统。 2022-10-22 325
assets_audio_player 播放存储在资产文件中的音乐/音频。 2022-07-05 823
iscflutterplugin 海康 isc 平台视频播放插件 2022-09-28 4
audioplayers 可同时播放多个音频文件。 2022-10-08 1798
flutter_sound 音频录制处理。 2022-05-22 994
fijkplayer 基于 ijkplayer 的 Video Player Flutter 插件，支持最流行的协议和编解码器。 2021-11-30 139
chewie Flutter 的视频播放器，带有 Cupertino 和 Material 播放控件。 2022-09-09 1197
flutter_webrtc Flutter WebRTC 插件。 2022-10-16 724
图像 / 图形

依赖 描述 更新时间 likes
power_image 功能强大的插件，充分利用原生图片库在 flutter 端展示图片的能力 2022-05-25 33
image_compare 用于图像比较的 Dart 包。使用各种算法比较图像的差异 2021-11-24 31
flutter_blurhash 图像占位符的紧凑表示，对 30 个字符以下的模糊图像进行编码，以便像 Medium 使用的那样即时显示 2022-04-21 1070
stories_editor 以 instagram 故事创建者的风格创建的包，您可以使用它创建带有图像、文本、贴纸 (Gifs)、手指画的图像 2022-08-22 60
image_network 允许使用 CanvasKit 在 Web 上渲染图像，而不会出现 CORS 问题 2022-05-08 69
advance_image_picker 用于从 Android 和 iOS 图片库中选择多张图片，用相机拍摄新照片，并在使用前对其进行编辑，例如旋转、裁剪、添加贴纸/滤镜，是 image_picker 插件的高级版本。 2022-06-03 98
scribble 一个轻量级的 Flutter 手绘库，支持压力、可变线宽等 2022-08-02 100
image_pickers image_pickers 支持本地图片或视频多选，支持将网络图片或视频保存到相册，支持预览视频或图片。 2021-10-29 52
emojis 飞镖的表情符号！此软件包包含所有 unicode 13.0 表情符号（2020）。 2021-11-19 86
image_editor 在 Android 和 iOS 上编辑图像数据并输出到文件/内存。 2022-07-19 195
image_cropping 支持多平台裁剪和旋转图像，它允许包含背景，图像旋转，根据要求改变选择比例。 2022-09-01 71
fluttermoji Flutter 的轻量级和高度可定制的 SVG 图形集。 2022-02-15 158
native_pdf_renderer 用于在 Web、MacOS、Windows、Android 和 iOS 上将 PDF 页面呈现为图像。 2022-02-10 94
flutter_cached_pdfview 用于显示 iOS 和 Android 的本机 PDF 视图。 2021-12-01 283
flutter_mobile_vision 谷歌移动视觉的 Flutter 实现。扫描条码、识别文本和检测人脸。 2020-04-28 122
google_ml_vision 用于 Google ML Kit 设备上视觉 API 的 Flutter 插件。它包括条码扫描、图像标记、文本识别和人脸检测。 2021-09-02 101
fluentui_system_icons 微软友好和现代的图标集合。 2022-10-14 434
graphite 可轻松绘制直接图形、树、流程图。包括用于创建图形交互的手势 API。 2021-05-13 69
flutter_signature_pad 允许用户用手指签名并将结果导出为图像。 2022-06-06 84
draw_your_image 使用户能够在您设计的 UI 中用手指进行绘制。 2021-03-31 25
patterns_canvas 在画布元素或小部件上绘制条纹或圆点等图案。 2022-05-30 44
arrow_path 使用 Path 对象轻松绘制箭头，可以合成路径以将箭头添加到任何曲线并一次绘制。 2022-07-18 32
octo_image 多功能 Flutter 图像小部件。支持带有淡入淡出的占位符、错误小部件和图像转换器。 2022-05-16 553
qr Dart 和 Flutter 的二维码生成库。支持 QR 码版本 1 到 40，纠错和冗余。 2022-04-12 128
barcode Dart 的条码生成库，可以为任何后端生成通用绘图操作。 2022-08-20 313
flutter_qr_reader 扫描二维码和图片。 2021-04-03 69
scan 使用自定义选项扫描小部件树中的二维码和条形码，从路径准确解码二维码和条形码图像。 2021-12-22 112
flutter_barcode_scanner Android 和 iOS 上支持条码扫描的插件。支持条码、二维码等。 2021-04-19 898
ai_barcode 支持 Android、iOS、网络识别'一维条码'和'二维条码'的识别与生成。 2022-06-30 122
websafe_svg 能够在 Android、iOS 和 Web 中使用 SVG 的简单抽象。 2022-10-18 99
pretty_qr_code Flutter 的漂亮二维码，您可以使用参数圆角边缘或使用标准视图。 2021-05-24 127
pinch_zoom 交互式查看图像的小部件，可以使图片捏缩放 2021-07-16 133
progressive_image 使用低质量图像占位符逐步加载更大图像的部件。 2021-05-10 268
ios_platform_images 在 Flutter 和 iOS 之间共享图像的插件。 2022-05-25 18
flutter_luban 基于图像的图像压缩包，如 Luban for Dart。该库没有系统平台限制。 2021-05-01 81
local_image_provider 用于在移动设备上检索图像、视频和相册的元数据和内容的库。 2022-05-17 29
proste_bezier_curve 更少的代码，更少的难度，绘制标准的贝塞尔曲线。 2021-07-16 36
image_crop 在 iOS 和 Android 上裁剪图像的 Flutter 插件。 2022-08-02 174
bitmap 快速且简约的库，可帮助您在 Flutter 应用程序上操作图像。 2021-03-17 70
bezier bezier.dart 是一个简单的开源 Dart 库，用于处理二维贝塞尔曲线数学。 2021-04-04 43
animate_icons 可以在任何两个图标之间设置动画。 2021-03-14 151
path_drawing 帮助（画布）路径创建和操作。 2022-08-04 145
material_design_icons_flutter 社区为 Flutter 设计的 Material Design 图标。 2022-07-08 502
syncfusion_flutter_signaturepad 允许您通过绘制的手势捕捉平滑和更逼真的签名并将其保存为图像。 2022-10-18 134
image 使服务器和 Web 应用程序能够加载、操作和保存具有各种图像文件格式的图像。 2022-10-16 908
flutter_vector_icons Flutter 的可自定义图标，包括 AntDesign、Entypo、EvilIcons、Feather、FontAwesome、Foundation、Ionicons、MaterialCommunityIcons、MaterialIcons、Octicons、SimpleLineIcons 和 Zocial。 2022-09-17 194
transparent_image Dart 代码中的透明图像。 2021-03-18 300
qr_flutter 简单快速地渲染二维码。 2021-03-14 1304
image_editor_pro 图像编辑器插件，简单、轻松地支持使用油漆、文本和表情符号。 2021-05-17 311
palette_generator 用于从源图像生成调色板颜色。 2022-08-25 376
wechat_camera_picker wechat_assets_picker 的扩展，基于 camera 相机功能和 photo_manager。 2022-10-21 126
panorama 全景图-360 度全景图查看器。 2021-04-16 122
crop 裁剪任何小部件，不仅限于图像。 2022-10-20 162
drawing_animation 画布上逐渐绘制 SVG 路径对象。 2022-08-11 169
flutter_launcher_icons Flutter 启动器图标-一个软件包。 2022-08-07 4562
emoji_picker_flutter 提供了一个表情符号选择器小部件，其中包含 8 种类别的 1500 多种表情符号。 2022-10-17 242
graphx 使 Flutter 中的绘图和动画极其简单。 2022-06-02 256
flutter_weather_bg 多种天气背景动画效果。 2020-10-01 48
photofilters 用于将各种类型的滤镜应用于图像。 2021-06-15 192
flutter_custom_clippers 将 widget 裁剪成各种自定义形状。 2021-06-10 515
loading_gifs 加载指示器 GIF。 2021-03-04 72
liquid_progress_indicator 水波效果的进度指示器。 2021-07-09 597
model_viewer 用于以 glTF 和 GLB 格式呈现交互式 3D 模型。 2020-08-21 126
confetti 在屏幕上吹起五彩纸屑。以风格庆祝应用成就。控制速度，角度，重力和纸屑量。 2022-05-13 794
flutter_icons 可定制的 Flutter 图标，在 Flutter 项目中可以使用超过 3K +图标。 2020-04-16 717
signature Flutter 插件可提供性能优化的签名画布，并能够设置自定义样式，边界和初始状态。 2022-08-12 327
screenshot Flutter 屏幕截图程序包（运行时），将任何小部件捕获为图像。 2021-07-16 744
crop_your_image 帮助您的应用嵌入用于裁剪图像的小部件。 2022-03-15 264
image_painter 用于在图像上绘画的插件。 2022-06-16 80
image_gallery_saver 用于将图像保存到图库的 flutter 插件。 2021-10-08 399
nineold 朋友圈 9 宫格图片显示，支持 9+以上图片。 2022-03-31 3
photo_manager 使用 api 创建图像选择器或使用照片。 2022-10-19 371
image_cropper 适用于 Android 和 iOS 支持裁剪图像的 Flutter 插件。 2022-08-09 1408
edge_detection 检测对象的边缘，扫描纸张，检测角，检测矩形。它允许裁剪检测到的对象图像并返回裁剪图像的路径。 2022-03-08 166
before_after 轻松地显示两个图像之间的差异。 2020-11-07 78
imageview360 通过旋转和手势自定义提供 360 度的图像视图。 2022-01-15 146
flutter_avatars_bottts svg 头像渲染小部件。 2020-09-05 11
flutter_image_compress 图片压缩。 2022-09-19 763
cached_network_image Flutter 库可加载和缓存网络图像。 2022-08-31 3916
flutter_gifimage 用于解决 gif 无法控制的速度，进度。 2019-11-07 60
extended_image 强大的官方 Image 扩展组件, 支持加载以及失败显示，缓存网络图片，缩放拖拽图片，图片浏览(微信掘金效果)，滑动退出页面(微信掘金效果)，编辑图片(裁剪旋转翻转)，保存，绘制自定义效果等功能。 2022-09-17 1208
extended_image_library extended_image 的基础库，如果你只需要网络图片缓存功能，你可以只引用这个库。 2022-09-01 114
flutter_svg Flutter 的 SVG 渲染和窗口小部件库，允许绘制和显示可缩放矢量图形。 2022-09-09 3238
font_awesome_flutter 以 Flutter Icons 的形式提供. 提供 1500 个其他图标供您的应用使用。 2022-09-08 3041
weather_icons 带有 200 多个天气主题图标的图标包。 2021-07-08 62
photo_view 图像能够通过用户手势（例如捏，旋转和拖动）进行缩放和平移，还可以显示任何窗口小部件而不是图像，例如容器，文本或 SVG。 2022-05-24 1964
flutter_emoji 轻巧的表情符号。 2022-01-23 138
时间相关

依赖 描述 更新时间 likes
calendar_date_picker2 基于 Flutter CalendarDatePicker 的轻量级可定制日历选择器，支持单日期选择器、范围选择器和多选择器 2022-09-29 52
moment_dart 将 DateTime 转换为人类可读格式的包。灵感来自 moment.js 2022-10-01 30
cr_calendar 带有自定义、范围选择和事件显示的很棒的日历 2022-09-16 52
time_duration_picker 配对连续任务的时间选择器 2022-03-17 38
day dart 中的日期库 Day.js 2022-02-03 16
time 类型安全的日期时间和持续时间计算，由扩展提供支持。 2022-09-03 283
nepali_date_picker material 风格的日期选择器、日期范围选择器和日历。 2022-05-16 67
flutter_cupertino_datetime_picker Flutter Cupertino 日期选择器 2021-10-15 42
flutter_rounded_date_picker 帮助您选择带有圆形日历和可自定义主题的日期和年份。 2022-09-05 210
timeago 创建模糊时间戳的库（例如“ 15 分钟前”）。 2022-08-11 1130
calendar_timeline 水平日期选择器，占用很少的屏幕空间，因此我们始终可以看到它，并且便于单手使用。 2022-07-05 228
flutter_week_view 显示高度可定制的周视图（或日视图）。 2022-05-19 100
time_range 选择时间范围的 Flutter 小部件。 2022-07-05 75
flutter_time_range 完全可定制的小部件，允许用户选择时间范围。 2021-05-10 14
date_format 用于格式化日期。提供各种常量以构建 Date 格式的字符串。使用 formatDate 方法根据格式字符串格式化日期。 2022-09-22 365
table_calendar 高度可定制的功能丰富的 Flutter 日历，具有手势，动画和多种格式。 2022-09-06 1830
flutter_calendar_carousel 可滑动的日历小部件。 2022-07-12 337
flutter_cupertino_date_picker Flutter Cupertino 日期选择器。以 iOS 样式显示 DatePicker。 2020-06-17 124
timelines 功能强大且易于使用的 Flutter 时间线。 2021-03-27 1062
timeline_tile 建立高度可定制的时间线。 2021-03-10 1301
flutter_datetime_picker 日期时间选择器。 2021-04-23 768
date_picker_timeline 日期选择器库，提供日历作为水平时间线。 2021-03-06 371
time_planner 一个漂亮，易于使用且可自定义的日历规划器。 2022-07-22 86
custom_timer 高度可定制的计时器构建器，具有控制器，动画，间隔，回调，自定义操作等。 2022-08-07 110
timetable 可自定义的动画日历小部件，包括日和周视图。 2020-10-26 218
syncfusion_flutter_datepicker 使用户可以轻松选择日期或日期范围。 2022-10-18 951
syncfusion_flutter_calendar 九个内置的可配置视图，提供用于高效安排和表示约会/事件的基本功能。 2022-10-18 906
动画

依赖 描述 更新时间 likes
fade_out_particle 为诸如文本和图标之类的消失视图淡出粒子效果 2022-08-29 92
flutter_animate 通过简单、可定制、统一的 API 在 Flutter 中添加精美的动画效果和构建器 2022-08-18 472
flutter_gl Dart 通过 dart:ffi 跨平台调用 OpenGL API。跨平台的 3D 编程 2022-10-04 33
three_dart threejs 的 dart 实现，易于使用、轻量级、跨平台的通用 3D 库 2022-10-17 87
flutter_bounceable 简单、交互式和可自定义的点击弹跳动画，可以包装在您喜欢的任何小部件上。 2022-06-15 95
local_hero 当它的位置在同一条路线内发生变化时，它会隐式地启动一个英雄动画。 2021-07-25 132
dismissible_page 创建通过滑动手势关闭的页面，具有英雄风格的动画，受 Facebook 和 Instagram 故事的启发。 2022-06-30 267
flutter_sliding_tutorial 应用视差效果将使您的产品演示看起来像 Google 应用教程。 2022-09-16 139
animator 使动画更轻松的 Flutter 库。它允许将动画设置与用户界面分离。 2022-05-22 221
animated_splash_screen 以完全可定制的方式创建动画启动画面的最简单方法。 2022-07-03 426
jelly_anim 包含果冻动画。用户可以动态修改果冻和视口大小、果冻坐标、溢出标志。 2021-08-23 43
giphy_get 使用纯飞镖代码从 Giphy 中选择 EMOJI、STICKER 或 GIF，支持安卓、iOS、网页和桌面。 2022-09-06 78
giphy_picker 允许您从 Giphy 中挑选动画 GIF 图像的插件。 2021-03-04 60
delayed_display 在延迟后以漂亮的淡入淡出和滑动动画显示子项。 2021-03-22 351
rive 提供运行时功能，用于回放使用 Rive 编辑器构建的动画并与之交互。 2022-07-25 905
flutter_animator 能够以更少的代码更快、更高效地创建令人惊叹的动画。 2022-06-07 270
spring 简单而强大的预建动画工具包，用于更快、更轻松地开发应用程序。 2021-05-10 187
flutter_bounce 用于将点击弹跳动画传递到环绕的小部件。 2021-06-14 108
bouncing_widget 在小部件上添加弹跳动画。 2021-03-22 160
loading_animations 一系列简单但非常可定制的加载动画。 2021-03-09 213
loading_indicator 加载动画的集合。开箱即用，没有额外的依赖。 2022-05-15 325
smooth_sort 添加精彩和自定义排序动画的 Flutter 包。 2021-04-17 23
funvas 根据时间和数学函数创建画布动画的包。 2022-07-07 157
circular_clip_route 通过展开圆形剪辑来显示其页面的页面路由。 2022-03-16 99
sprung Flutter 动画的弹簧曲线，使用真实的物理方程来驱动您的动画。 2022-07-27 147
auto_animated 可以为列表和图标设置动画。 2022-08-15 909
mouse_parallax 在多个平台上实现基于指针的视差动画的简单方法。 2021-02-27 135
widget_circular_animator 预先构建的 Flutter 圆形动画器，适合个人资料视图或任何其他小部件。 2021-06-14 121
flutter_bounce 用于在任何小部件上点击弹跳动画。 2021-06-14 108
page_transition 漂亮的页面过渡包。 2022-06-21 929
concentric_transition 适用于入门，页面过渡，自定义剪切器等。 2022-06-08 477
flip_card 翻页动画的组件，可以用于隐藏和显示产品的详细信息。 2021-10-09 655
like_button 点赞按钮动画。 2022-09-29 948
animated_text_kit 酷炫的漂亮文字动画。 2022-06-05 3430
liquid_swipe 液体效果的页面切换组件。 2022-06-30 900
shimmer 为控件添加闪光效果。 2021-04-12 3068
flare_flutter Flutter 的动画插件。 2021-07-29 648
lottie 在 Flutter 上本地渲染 After Effects 动画。该软件包是 Lottie 播放器的纯 Dart 实现。 2022-09-14 2293
simple_animations 创建精美的自定义动画。 2022-08-13 1570
animate_do 受 Animate.css 启发的动画包，仅使用 Flutter 动画构建，没有额外的包。 2022-01-10 2763
animations 轻松集成到任何 Flutter 应用程序中的精美预建动画。 2022-10-05 4315
图表类

依赖 描述 更新时间 likes
calendar_view 允许您轻松实现所有日历 UI 和日历事件功能。 2022-08-12 280
round_spot 可定制、易用的热图界面分析库。 2021-07-11 68
graphic 声明式、可交互的可视化图表库 2022-09-19 345
k_chart k 图。支持拖动，缩放，长按。 2022-04-14 123
flutter_animation_progress_bar 以反应式风格显示动画进度条。它还支持垂直和水平条。 2022-10-12 165
syncfusion_flutter_treemap 用于创建交互式树图，以基于平方、切片和切块算法可视化平面和分层数据。 2022-10-18 51
syncfusion_flutter_gauges Flutter 仪表库包括线性仪表和径向仪表（又名圆形仪表），用于创建现代、交互式、动画仪表和径向滑块。 2022-10-18 685
sleek_circular_slider Flutter 的高度可定制的圆形滑块/进度条。 2021-06-27 923
syncfusion_flutter_charts Dart 原生编写的数据可视化库，用于创建美观、动画和高性能的图表 2022-10-18 2065
time_chart 可滚动的时间图表。 2022-05-27 50
bezier_chart 一个漂亮的贝塞尔曲线折线图窗口部件。 2020-04-26 239
flutter_echarts 基于 Echarts 的数据可视化图表库，能够构建高级图表，例如 WebGL 3D，GIS 地图等。 2022-08-13 368
fl_chart Flutter 图表库，当前支持折线图，条形图和饼图。 2022-09-23 3527
charts_flutter Material Design 图表库。 2021-11-03 1303
percent_indicator 根据百分比显示进度小部件，可以是圆形或线性的，也可以根据需要进行自定义。 2022-05-13 1652
graphview 图形结构显示数据。它可以显示树形布局和层次结构图。 2021-12-28 283
侧边栏 / 侧边菜单

依赖 描述 更新时间 likes
flutter_side_menu 完全可定制的侧边菜单 2022-09-20 12
shrink_sidemenu 液体收缩侧边菜单。 2021-12-23 197
collapsible_sidebar 用于实现 Material Design 的 Flutter 应用程序的可折叠侧边栏。 2022-10-16 262
animated_stack 自定义动画堆叠页面，以创建可自定义的侧边菜单按钮。 2021-04-02 182
animated_drawer 一个简单但完全可定制的抽屉。 2021-01-21 163
drawer_swipe 轻松快速使用的滑动抽屉库。 2021-03-10 73
flutter_slider_drawer 带有 Slider Drawer Menu 自定义实现的 Flutter 包。 2022-01-27 300
flutter_inner_drawer 创建侧边抽屉。 2021-03-17 427
hidden_drawer_menu 带有透视动画的精美抽屉模式菜单功能的库。 2021-11-16 177
flutter_zoom_drawer 侧边菜单（抽屉）的自定义实现。 2022-07-15 717
底部导航栏 / 浮动菜单

依赖 描述 更新时间 likes
persistent_bottom_nav_bar_v2 persistent_bottom_nav_bar 的延续 2022-08-16 142
water_drop_nav_bar 底部导航栏，具有独特的水滴效果。 2022-09-01 167
sliding_clipped_nav_bar 底部导航栏带有滑动菜单图标和带有剪切效果的文本。 2022-09-01 167
bottom_animation Flutter 底部导航栏。 2021-06-20 18
cupertino_tabbar 高度可定制且简单的小部件，用于拥有 iOS 13 风格的标签栏。 2021-05-04 61
expandable_bottom_bar 带有可扩展表的动画底部应用栏。 2021-05-26 293
tab_indicator_styler 将漂亮且流行的标签指示器直接添加到默认的 Flutter TabBar。 2021-08-12 196
flutter_snake_navigationbar 底部导航栏小部件在更改项上带有蛇形动画。 2022-03-09 483
google_nav_bar 谷歌风格的底部导航栏。 2022-03-22 933
custom_navigation_bar 带有气泡点击效果的自定义导航栏。 2021-06-14 393
salomon_bottom_bar 炫酷的底部导航栏。 2022-05-08 595
bubble_bottom_bar 动画的底部导航栏。 2021-12-05 205
fancy_bottom_navigation 动画的底部导航栏。 2021-03-16 220
animated_bottom_navigation_bar 绚丽的动画底部导航栏。 2022-08-18 682
bottom_bar_with_sheet 底部导航栏，该底部栏将在每个页面上放置 BottomSheet 小部件。 2022-05-02 341
flutter_speed_dial 可展开选项的浮动按钮。 2022-10-14 858
focused_menu 长按菜单。 2021-03-13 378
bottom_navy_bar 精美而生动的底部导航。 2021-03-28 1035
cuberto_bottom_bar 动画底部导航栏。 2022-01-03 121
convex_bottom_bar 实现 ConvexAppBar 以在底部栏中显示一个凸形选项卡。支持主题。 2022-09-19 1970
full_screen_menu 全屏菜单，为用户提供多种精美的方式。 2021-03-20 65
fab_circular_menu 使用 Floating Action Button 创建漂亮的圆形菜单。 2021-03-24 521
curved_navigation_bar 可轻松实现弯曲的导航栏。 2022-02-08 1502
persistent_bottom_nav_bar 高度可定制的持久性/静态底部导航栏。 2022-09-16 1512
circular_menu 一个简单多样的动画圆形菜单。 2022-06-21 316
titled_navigation_bar 美观，干净，简单的底部导航栏。 2020-04-27 137
对话框 / 底部弹片 / Toast

依赖 描述 更新时间 likes
flutter_smart_dialog 优雅的 Flutter Dialog 解决方案，轻松实现 Toast、Loading 和自定义 Dialog。 2022-10-22 237
motion_toast 带有动画的精美设计 toast，包含多种内置设计。 2022-09-18 213
oktoast 纯 flutter toast 库，支持自定义 style/widget，轻松实现与原生 toast 相同的效果。 2022-09-27 227
proste_dialog 相比 giffy_dialog，提供了更高的自由度和更强的可扩展性。 2021-07-23 1
rflutter_alert 用于 Flutter 的超级可定制且易于使用的警报/弹出对话框。 2021-08-03 850
material_dialogs 帮助您在应用程序中创建动画、简单、时尚的 material 对话框。 2022-05-23 171
flutter_beautiful_popup 美化你的应用弹出窗口。 2021-09-17 133
aesthetic_dialogs 允许显示漂亮的自定义对话框。 2022-01-01 65
flutter_animated_dialog 新的 Flutter 对话框，带有幻灯片淡入淡出旋转大小缩放 rotate3D 动画。 2021-07-13 167
snapping_sheet 提供了一个工作表小部件，可以捕捉到不同的垂直和水平位置。 2021-04-22 602
awesome_dialog 尽可能简单的动画显示漂亮的对话框。 2022-09-23 889
fluttertoast Toast 组件。 2022-10-15 2341
adaptive_dialog 根据平台自适应地显示对话框或模态框。 2022-08-31 687
bot_toast 易于使用的 Flutter Toast 库，易于使用且功能丰富。 2022-07-14 682
flash 高度可定制，功能强大且易于使用的警报库。 2022-09-27 839
flutter_styled_toast 自定义 Toast。 2022-05-15 270
rate_my_app 询问用户是否对自定义条件（例如安装时间，启动次数等）进行评分。 2022-05-19 447
gzx_dropdown_menu 易于使用且功能强大的自定义功能，仿美团和淘宝下拉菜单。 2021-04-07 148
giffy_dialog 一个精美的自定义警报对话框。 2020-07-16 459
popover 点击元素，弹出气泡式的卡片浮层。 2021-10-12 279
showcaseview 逐步展示/突出显示小部件，用于引导说明效果。 2022-08-05 1286
direct_select_flutter 选择控件，具有飘渺的全屏模式弹出窗口。 2021-05-14 261
sliding_sheet 以单个手势拖动和滚动并捕捉到范围列表的小部件。 2021-10-22 625
upgrader 用于在商店中有较新版本的应用程序时提示用户进行升级。 2022-10-21 989
solid_bottom_sheet 完整的可定制的 bottom_sheet。 2021-06-08 169
rubber Flutter 的一种很好的弹性底片实现。 2021-07-05 291
sliding_up_panel 可拖动的底部弹片实现。 2021-04-27 2175
modal_bottom_sheet 创建令人敬畏而强大的模态底板。 2022-09-05 2353
Windows / Linux / Mac

依赖 描述 更新时间 likes
webview_windows 适用于 Windows 平台的基于 WebView2 的 webview 实现 2022-09-26 124
local_notifier 允许 Flutter 桌面应用程序显示本地通知 2022-06-04 26
desktop_context_menu 在光标位置打开上下文菜单的插件 2022-05-03 28
contextmenu 显示精美的动画材质上下文菜单，它适用于触摸设备和桌面设备 2022-03-02 40
launch_at_startup 允许 Flutter 桌面应用程序在启动/登录时自动启动 2022-09-17 43
auto_updater 允许 Flutter 桌面应用程序自动更新自己（基于 sparkle 和 winsparkle） 2022-08-27 55
screen_text_extractor 允许 Flutter 桌面应用程序从屏幕中提取文本 2022-05-02 10
msix 命令行工具，可从您的 Flutter Windows 构建文件创建 Msix 安装程序。 2022-10-11 440
desktop Flutter 桌面设计标准。只需简单、可用的 wigdets 即可创建应用程序。 2022-04-16 95
window_manager 允许 Flutter 桌面应用程序调整窗口大小和重新定位。 2022-08-27 308
system_tray system_tray 可以轻松自定义托盘。 2022-09-14 145
screen_retriever 该插件允许 Flutter 桌面应用程序检索有关屏幕大小、显示、光标位置等的信息。 2022-10-13 11
nativeshell NativeShell Dart API。用于与 NativeShell 平台代码交互。 2022-02-05 24
window_decorations 提供 Linux 主题中大部分窗口装饰的包。 2022-02-17 16
macos_ui 实现当前 macOS 设计语言的 Flutter 小部件和主题。 2022-09-05 459
window_decorations 提供 Linux 主题中大部分窗口装饰的包。 2022-02-17 16
hotkey_manager 允许 Flutter 桌面应用程序定义系统/应用程序范围内的热键（即快捷方式）。 2022-04-28 45
flutter_media_metadata 用于读取媒体文件元数据的 Flutter 插件。 2022-01-30 33
flutter_acrylic 在 Windows 和 Linux 上的窗口模糊和透明效果。 2022-03-10 278
desktop_window Flutter 桌面插件（macOS/Linux/Windows）用于获取和更改窗口大小。 2021-03-09 230
bitsdojo_window 帮助使用 Flutter 桌面（自定义边框、标题栏和最小化/最大化/关闭按钮）和 Windows 和 macOS 的常见桌面窗口操作（在屏幕上显示/隐藏/定位）创建自定义窗口。 2022-09-09 610
desktop_drop 一个插件，允许用户将文件拖动到您的 Flutter 桌面应用程序。 2022-03-09 175
desktoasts 在 Windows 上显示本机 toast 的插件。 2022-01-28 30
card_swiper 一个 macOS 插件，可以为全局键盘快捷键注册回调。 2022-06-05 473
process_run 适用于 Linux/Win/Mac 的进程运行助手以及查找可执行文件的功能。 2022-01-19 167
rename 帮助您为 Ios、Android、MacOS 和 Linux 平台更改或重命名您的 Flutter 项目 BundleId 和 AppName 2021-11-06 521
protocol_registry 轻松注册/查询/删除 URI 方案。适用于 Windows 和 Linux。 2021-09-01 3
global_shortcuts 一个 macOS 插件，可以为全局键盘快捷键注册回调。 2021-05-31 4
通讯类

依赖 描述 更新时间 likes
telegram_client 用于制作基于应用程序电报的颤振和 userbot / bot 支持服务器端和客户端 2022-10-15 47
huawei_ml_image 华为机器学习套件 Flutter 语言插件。提供图像分类、物体检测和图像超分辨率等功能 2022-06-10 4
huawei_ml_body Flutter 的 HUAWEI ML Kit Body 插件。提供人脸识别、活体和骨骼检测等功能。 2022-06-10 6
huawei_iap Flutter 的 HUAWEI IAP Kit 插件 2022-08-01 24
huawei_ml_text Flutter 的 HUAWEI ML Kit 文本插件。提供文本、文档、身份证、银行卡、通用卡和表单识别等功能 2022-06-10 5
huawei_modeling3d 实现了华为 3D 建模 SDK 与 Flutter 平台的通信 2021-10-01 4
huawei_iap Flutter 的 HUAWEI IAP Kit 插件 2022-08-01 24
huawei_analytics Flutter 的 HUAWEI Analytics Kit 插件 2022-09-27 17
huawei_dtm 华为动态标签管理器（DTM）是一个动态标签管理系统 2022-10-10 1
huawei_analytics Flutter 的 HUAWEI Analytics Kit 插件 2022-09-27 17
huawei_ads HUAWEI Ads Kit 插件利用华为庞大的用户群和海量数据能力，为用户提供有针对性的优质广告内容 2022-08-12 17
pangle_flutter 一个在 Android 和 iOS 上支持字节跳动 Pangle SDK 的 Flutter 插件 2022-10-07 27
huawei_account Flutter 的 HUAWEI Account Kit 插件 2022-06-30 17
social_share 需要直接与某些知名应用共享的多种共享选项。 2021-12-15 250
completion 将 shell 命令完成添加到 Dart 应用程序的包。 2021-03-07 21
googleapis 用于访问通过 API 发现服务描述的 Google API 的自动生成的客户端库。 2022-09-14 627
graphql Dart 的独立 GraphQL 客户端。 2022-04-09 354
github 使用 Github 的 v3 API 的高级 GitHub API 客户端库。 2022-10-22 106
flutter_chat_bubble 用于创建不同类型的聊天气泡。 2021-08-03 163
flutter_chat_ui 积极维护、社区驱动的聊天 UI 实施，带有可选的 Firebase BaaS。 2022-10-02 621
teledart 与最新 Telegram Bot API 接口的 Dart 库。 2022-03-12 199
ftpconnect Flutter 简单而强大的 dart FTP 连接库，可与 FTP 服务器交互，并可以压缩和解压缩文件。 2022-09-18 76
mailer 从 Dart 撰写和发送电子邮件。支持文件附件和 HTML 电子邮件。 2022-07-02 257
flutter_qq_ads 基于「腾讯广告、广点通、优量汇」SDK 的插件。 2022-04-08 15
flutter_pangle_ads Flutter 广告插件（字节跳动、穿山甲）。 2022-09-06 25
flutter_facebook_auth 将 facebook 登录添加到您的 Flutter 应用程序、获取用户信息、个人资料图片等的最简单方法。包括网络支持。 2022-09-13 902
google_sign_in 用于 Google Sign-In 的 Flutter 插件，一种用于在 Android 和 iOS 上使用 Google 帐户登录的安全身份验证系统。 2022-09-23 1979
tencent_im_sdk_plugin 腾讯云即时通信 IM 专业版原生 SDK 插件，包含了专业版 SDK 的全部功能。 2022-10-18 28
nearby_connections android NearbyConnections API 的插件。 2022-03-18 91
flutter_insta 用于获取 instagram 用户的详细信息。 2022-08-24 151
wechat_kit 允许开发人员使用 natvie Android 和 iOS 微信 SDK 进行身份验证/共享/支付。 2022-06-22 67
flutter_segment 适用于 iOS、Android 和 Web 的分析的 Flutter 实现。 2022-08-24 58
wiredash Wiredash 是 Flutter 应用程序的交互式用户反馈工具。 2022-08-25 203
flutter_paystack 通过 Paystack 支付网关进行支付。完全支持安卓和 iOS。 2022-09-18 159
onesignal_flutter OneSignal 是一种针对移动应用程序的免费推送通知服务。 2022-08-10 578
flutter_share_me 用于将内容分享到社交媒体。您可以使用它分享到 Facebook、WhatsApp、Twitter 和系统共享 UI。支持网址和文字。 2022-09-23 155
huawei_push Flutter 的 HUAWEI Push Kit 插件。 2022-08-01 51
amplitude_flutter 官方 Amplitude Flutter SDK。 2022-10-22 67
adhara_socket_io websocket by socket.io for flutter by adhara，支持 iOS 和 Android 2021-05-31 84
jitsi_meet 用于在 Flutter 中集成开源 Jitsi Meet API 的视频会议插件。 2021-04-13 406
rammus 网友开发的阿里云推送 Flutter 插件 2022-09-01 11
flutter_alibc flutter 版本的阿里百川。 2021-06-01 9
flutter_speech Flutter 插件支持 Android、iOS 和 Mac OSX 上的语音识别。 2021-04-25 39
android_alarm_manager_plus 用于访问 Android AlarmManager 服务，并在警报触发时在后台运行 Dart 代码。 2022-10-21 273
tencent_rtc_plugin 腾讯云实时音视频插件，集成腾讯 RTC，支持安卓和 IOS 双端。 2021-08-25 3
tencent_im_plugin 集成腾讯云“imsdk”，实现跨平台即时访问，兼容 Android 和 IOS 设备。 2021-08-16 17
mongo_dart MongoDB 驱动程序，在纯 Dart 中实现。所有 CRUD 操作、聚合管道。 2022-04-10 321
pay 对 Flutter 应用程序付款支持的插件。 2022-09-14 569
mqtt_client 用于 Dart 的基于服务器和浏览器的 MQTT 客户端。 2022-09-02 295
hive 用纯 Dart 编写的轻量级和极快的键值数据库。 2022-06-30 4051
stripe_sdk Flutter 唯一的原生 Stripe 库，完全支持 SCA/PSD2、支付和最新的 Stripe 功能。 2020-12-27 157
flutter_stripe Stripe 的 flutter 库，支持 PaymentSheets、Apple 和 Google Pay、SCA、PSD2 等。 2022-09-25 642
graphql_flutter Flutter 的 GraphQL 客户端。 2022-04-08 603
flutter_cache_manager 用于在应用程序的缓存目录中下载和缓存文件。可以更改有关文件保留时间的各种设置。 2021-11-29 963
tobias 允许用户使用原生 Android 和 iOS 支付宝 SDK 进行身份验证或支付。 2022-07-30 39
jmlink_flutter_plugin 移动端 JMLink 服务可以从多种渠道中唤醒 APP 内一个具体的页面。 2022-08-15 1
firebase_messaging Firebase 消息传递插件。 2022-10-20 2551
jshare_flutter_plugin 具备国内外主流社交平台分享和第三方登录功能，提供新浪微博、QQ、微信、Facebook、twitter 等第三方社会化服务。 2021-05-25 2
janalytics 利用极光推送的数据和网络优势而推出的数据统计分析服务。 2021-12-14 1
jverify 整合了三大运营商的网关认证能力，为开发者提供了一键登录和号码认证功能，优化用户注册/登录、号码验证的体验，提高安全性。 2022-09-07 11
jmessage_flutter 极光 IM（英文名 JMessage）致力于帮助 App 解决应用内聊天和跨应用聊天问题。 2021-11-05 6
jpush_flutter 极光推送官方支持的 Flutter 插件。 2022-10-12 52
flutter_bugly 用于腾讯 Bugly，崩溃监控，崩溃分析，异常报告，应用程序更新，数据统计等。 2022-02-18 49
firebase_core 用于 Firebase Core 的 Flutter 插件，可连接到多个 Firebase 应用程序。 2022-10-20 2234
cloud_firestore 用于 Cloud Firestore 的 Flutter 插件，这是一个云托管的 noSQL 数据库，具有实时同步功能。 2022-10-20 2507
sqflite SQLite 的 Flutter 插件。 2022-10-06 3368
firebase_auth 用于 Firebase 身份验证的 Flutter 插件。 2022-10-20 2742
share_plus 通过平台的“共享”对话框共享 Flutter 应用程序中的内容。 2022-10-20 1627
speech_to_text 将特定于设备的语音显示给文本识别功能。 2022-10-19 695
flutter_tts 用于文字转语音的 Flutter 插件。iOS，Android 和 Web 支持该插件。 2022-09-06 733
fluwx Flutter 中实现 WeChat SDK 的功能。借助 Fluwx，开发人员可以轻松使用 WeChatSDK，例如分享，付款，小程序。 2022-10-18 113
socket_io_client 用于 Web，Flutter 和 dartvm 的 socket.io-client 的 Dartlang 端口。 2022-07-13 835
jpush_flutter 极光推送官方支持的 Flutter 插件。 2022-10-12 52
地图类

依赖 描述 更新时间 likes
huawei_location HUAWEI Flutter Location Kit 插件将全球导航卫星系统 (GNSS)、Wi-Fi 和基站定位功能结合到您的应用中 2022-10-10 25
amap_flutter_map 高德地图 SDK Flutter 插件 2021-11-23 47
huawei_map 华为地图套件，提供标准地图和 UI 元素，为您定制更符合服务场景的地图。 2022-06-30 43
flutter_animarker 谷歌地图的标记地理动画解决方案。 2021-04-23 123
flutter_mapbox_navigation 用于 Flutter 的成熟的逐步导航 UI，可随时放入您的应用程序。 2021-07-20 196
maps_launcher 用于在所有平台上打开地图应用程序（或浏览器）。 2021-07-29 287
google_map_location_picker 基于 google_maps_flutter 的 Flutter 地图位置选择器。 2021-03-06 237
google_maps_flutter 用于在 iOS 和 Android 应用程序中集成谷歌地图。 2022-09-28 2820
mapbox_gl 用于在 Android、iOS 和 Web 平台上的 Flutter 应用程序中集成 Mapbox 地图。 2022-05-19 396
map Flutter 的地图小部件用 100% Dart 编写。支持 Android、iOS、Web 和桌面。 2022-10-20 238
background_locator 即使应用程序被终止，一个 Flutter 插件也会请求位置。 2022-01-08 343
background_location 用于在 Android 和 iOS 的后台获取位置更新。 2021-10-18 270
map_launcher 查找安装在设备上的可用地图，并使用标记启动它们或显示方向。 2022-09-19 488
syncfusion_flutter_maps 用于从形状文件或 WMTS 服务创建美观、交互式和可自定义的地图，以可视化地理区域。 2022-10-18 285
flutter_background_geolocation 先进的背景位置跟踪和地理围栏模块。 2022-10-14 442
maps_curved_line 帮助在谷歌地图上绘制曲线的包。这可以用作在位置 A 和位置 B 之间绘制路线的经济高效的方式。 2021-04-28 24
coordtransform 坐标变换工具，提供 BD09、GCJ02、WGS84 坐标系相互变换。 2021-06-03 3
flutter_map Leaflet 的 Dart 实现，为 Flutter 应用程序提供地图小部件。 2022-09-05 1026
flutter_baidu_mapapi_map 百度地图 Flutter 插件。 2022-07-06 17
flutter_bmflocation 百度地图定位 Flutter 插件。 2022-08-26 16
amap_flutter_location 高德官方定位 Flutter 插件。 2021-11-23 33
location 可轻松处理 iOS 和 Android 中的实时位置。 2022-05-13 2072
Web

依赖 描述 更新时间 likes
webview_flutter_plus webview_flutter 的扩展，用于从资产或字符串等加载本地 HTML、CSS 和 Javascript 2022-03-05 112
webview_flutter 在 Android 和 iOS 上提供 WebView 小部件的 Flutter 插件。 2022-05-11 2593
html 用于在浏览器外解析和操作 HTML 内容的 API。 2022-10-19 375
flutter_inappwebview 可让您添加嵌入式 Web 视图，使用 Web 视图以及打开应用内浏览器窗口。 2022-10-22 1426
flutter_widget_from_html 用于从 html 构建小部件树的 Flutter 软件包，支持超链接，图像，嵌套列表等。 2022-01-30 443
flutter_html 用于将静态 html 标记呈现为 Flutter 小部件（将呈现超过 70 种不同的 HTML 标签！）。 2021-12-09 1393
flutter_webview_plugin 允许 Flutter 与本机 WebView 通信的插件。 2021-05-24 638

# shared_preferences 数据存储

// Obtain shared preferences.
final SharedPreferences prefs = await SharedPreferences.getInstance();

Write data
// Save an integer value to 'counter' key.
await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

Read data

// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = prefs.getInt('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = prefs.getBool('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = prefs.getDouble('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = prefs.getString('action');
// Try reading data from the 'items' key. If it doesn't exist, returns null.
final List<String>? items = prefs.getStringList('items');

Remove an entry
// Remove data for the 'counter' key.
await prefs.remove('counter');

# 数据序列化 : https://www.jianshu.com/p/da99262b17df

json2dart: json 格式转 dart 格式
https://caijinglong.github.io/json2dart/index.html

安装： json_annotation, json_serializable, build_runner
执行命令： flutter packages pub run build_runner watch lib

# 运行命令

flutter run -d chrome --web-hostname=127.0.0.1

# 关闭 cors 运行
 chrome ：
flutter run -d chrome --web-browser-flag "--disable-web-security"

 edge ：
flutter run -d edge --web-browser-flag "--disable-web-security"

# fluro 路由管理

三种跳转方式
清除路由堆栈跳转：即跳转后的页面作为根页面（没有返回按钮），这种适合闪屏页跳到首页。代码如下：
RouterManager.router.navigateTo(context, RouterManager.homePath, clearStack: true);
普通跳转：无参数直接跳转，代码如下：
RouterManager.router.navigateTo(context, RouterManager.loginPath);
带参数跳转：路由路径携带参数，和普通跳转类似，只是拼接了路径参数和 query 参数：
RouterManager.router.navigateTo(context, '${RouterManager.dynamicPath}/$id?event=a&event=b')

# flutter_screenutil 屏幕适配

https://github.com/OpenFlutter/flutter_screenutil/blob/master/README_CN.md
