

Pod::Spec.new do |s|

  # 库名字
  s.name         = "LFBSocialSDK"
  # 库的版本
  s.version      = "1.0.5"
  # 库摘要
  s.summary      = "share framework for iOS (powerful，superior performance)"
  # 库描述
  s.description  = <<-DESC
                   简单易容的分享框架，目前提供微信、
                   朋友圈、QQ、QQ空间、新浪微博分享服务，
                   同时也提供了第三方登录功能
                   持续更新中...
                  DESC

  # 远程仓库地址,即GitHub地址，或者你使用的其他Gitlab地址
  s.homepage     = "https://github.com/LiuFuBo1991/LFBSocialSDK"
  
  # MIT许可证 (The MIT License),软件授权条款
  s.license      = "MIT"


  # 作者信息
  s.author             = { "liufubo" => "18380438251@163.com" }
  # 作者信息
  s.social_media_url   = "http://www.jianshu.com/u/7d935e492eec"
   

  # 支持的系统及支持的最低系统版本
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  支持多平台使用时配置
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # 下载地址，远程仓库的 GitHub下载地址(clone 地址), 使用.git结尾
  #  如果使用版本号做为tag那么不能频繁的打tag，必须要保持版本号和tag一致，否在拉取到的将是版本号作为tag对应提交的内容
  s.source       = { :git => "https://github.com/LiuFuBo1991/LFBSocialSDK.git", :tag => "#{s.version}" }


  # 库文件在仓库中的相对路径
  # 等号后面的第一个参数表示的是要添加 Cocoapods 依赖的库在项目中的相对路径
  # 我的库在库根目录，所以直接就是LFBSocialSDK
  # 如果库放在其他地方，比如LFBSocial/LFBSocialSDK,则填写实际相对路径
  # 等号后的第二个参数，表示LFBSocialSDK文件夹下的哪些文件需要 Cocoapods依赖
  # "**"这个通配符代表LFBSocialSDK文件下所有文件,"*.{h,m}代表所有的.h,.m文件"
  s.source_files  = "LFBSocialSDK", "LFBSocialSDK/**/*.{h,m,md}"
  # 指明 LFBSocialSDK文件夹下不需要添加到 Cocoapods的文件
  # 这里 Exclude 文件夹内的内容
  #s.exclude_files = "LFBSocialSDK/Exclude"
  # 公开头文件 
  #s.public_header_files = "LFBSocialSDK/Classes/**/*.h"

  # 项目中是否用到ARC
  s.requires_arc = true

  # 项目中的图片资源
  s.resource_bundles = {
    'LFBSocialSDK' => ['LFBSocialSDK/**/*.{xcassets}']
  }
  
  

  
  # 库中用到的框架或系统库 (没有用到可以没有)
  #s.static_framework = true
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

    
  # 如果库中依赖其他的三方库，可以添加这些依赖库
  s.dependency "WechatOpenSDK", "~> 1.8.4"
  s.dependency "TencentOpenAPI", "~> 1.0.0"
  s.dependency "WeiboSDK", "~> 3.1.3"
  s.dependency "Masonry", "~> 1.1.0"

end
