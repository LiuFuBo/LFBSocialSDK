                      分享功能说明文档
                      
    说明:该文档目的在于帮助新手快速熟悉分享框架功能使用，目前框架仅支持微信分享、微信朋友圈分享、QQ分享、QQ空间分享、新浪微博分享；以及以上平台登录功能封装；下面仅针对分享功能做说明,希望对使用本人分享框架的朋友有所帮助。
    
    分享功能必传参数
    1.shareType(分享平台) 
    2.shareInfoType 分享数据类型 (text,web,music,video,image,applet)
    
    一:分享纯文本
    必须参数: 
    1.text 分享文本
    
    二:分享图片
    必须参数:
    1.image 分享的图片,针对本地图片
    2.title 分享标题
    3.desc 标题描述
    4.thumbnailData 内容缩略图,一般<32k，如果超过，会导致接口调用失败
    5.originalImageData 内容原始图片
    
    三:网页分享
    必须参数:
    1.url 分享url链接地址
    2.title 分享标题
    3.desc 标题描述
    4.thumbnailData 内容缩略图,一般<32k，如果超过，会导致接口调用失败
    5.originalImageData 内容原始图片
    
    四:音乐分享
    必须参数:
    1.title 分享标题
    2.desc 标题描述
    3.thumbnailData 内容缩略图,一般<32k，如果超过，会导致接口调用失败
    4.originalImageData 内容原始图片
    5.musicUrl 分享音乐网页链接地址
    6.musicLowBandUrl 分享音乐低频段网页链接地址
    7.musicDataUrl 分享音乐数据下载链接地址
    8.musicLowBandDataUrl 分享音乐低频段数据下载链接地址
    
    五:视频分享
    必须参数:
    1.title 分享标题
    2.desc 标题描述
    3.thumbnailData 内容缩略图,一般<32k，如果超过，会导致接口调用失败
    4.originalImageData 内容原始图片
    5.videoUrl 分享视频网页链接地址
    6.videoLowBandUrl 分享视频低频段网页链接地址
    7.videoStreamUrl 分享视频流数据下载链接地址
    8.videoLowBandStreamUrl 分享视频低频段数据流下载链接地址 
    
    六:小程序分享
    必须参数:
    1.title 分享标题
    2.desc 标题描述
    3.webPageUrl 兼容低版本的网页链接,限制长度不超过10KB
    4.userName 小程序的用户名,小程序原始ID获取方法，登陆小程序管理后台-设置-基本设置-账号信息
    5.path 小程序页面路径
    6.hdImageData 小程序新版本的预览图二进制数据,6.5.9及以上版本微信客户端支持,限制128KB,自定义b图片建议长宽比5:4
    7.withShareTicket 是否使用带shareTicket的分享,小程序被二次打开时可以获取到更多信息，例如群的标识
    8.miniProgramType 小程序分享类型,默认正式版,1.8.1及以上版本开发者工具包支持分享开发板和体验版
