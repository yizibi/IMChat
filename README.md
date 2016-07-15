# IMChat

### 网易云信IM基本功能


##### 前言

> 网易云信的即时聊天SDk,不同于环信,网易SDk不支持客户端注册用户,需要服务器向网易服务器注册用户,然后返回客户端accid和token,然后客户端登陆云信服务器,具体参见云信IM[注册用户云信ID调用说明](http://dev.netease.im/docs?doc=server&#云信ID)

#### 说明
该demo,依赖SDWebimage,网易`NIMSDk`,`NIMUIKit`,`网易静态库`请(.a文件)自行下载;

* 网易[NIMSDk地址](http://netease.im/im-sdk-demo)
* [NIMUIKit地址](https://github.com/netease-im/NIM_iOS_UIKit)


###  **最终目的**

网易云信官网的demo功能太复杂,将`IM`,`音视频`,等功能抽离出来.方便在其他项目移植,只需要给`sessionViewcontroller`传递会话id即可,快速集成网易云信IM;

### 目前进展

1> 已实现,聊天功能,点击图片,浏览大图

**具体如下图**:


![](http://o9zpq25pv.bkt.clouddn.com/github/gif/NIMIMChat.gif)


* 进展中....
	* 音视频聊天...

