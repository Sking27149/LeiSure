//
//  URLDefineHeader.h
//  LeiSure
//
//  Created by lanou on 16/6/14.
//  Copyright © 2016年 Sking. All rights reserved.
//

#ifndef URLDefineHeader_h
#define URLDefineHeader_h

//专门存放所有的网络接口地址

//阅读分类列表
#define kReadListURL @"http://api2.pianke.me/read/columns"

//阅读列表
#define kReadListDeatilURL @"http://api2.pianke.me/read/columns_detail"

//阅读内容
#define kReadDetailURL @"http://api2.pianke.me/article/info"

//电台列表
#define kRadioListURL @"http://api2.pianke.me/ting/radio"

//电台列表加载更多
#define kRadioListMoreURL @"http://api2.pianke.me/ting/radio_list"

//电台详情列表
#define kRadioDetailURL @"http://api2.pianke.me/ting/radio_detail"

//电台详情列表加载更多
#define kRadioDetailMoreURL @"http://api2.pianke.me/ting/radio_detail_list"

//良品列表
#define kGoodsURL @"http://api2.pianke.me/pub/shop"

//良品详情
#define kGoodsDetailURL @"http://api2.pianke.me/group/posts_info"

//话题
#define kTopicURL @"http://api2.pianke.me/group/posts_hotlist"

//话题
#define kTopicDetailURL @"http://api2.pianke.me/group/posts_info"

//  登录注册
#define LOGIN_URL            @"http://api2.pianke.me/user/login" //登录接口的地址   email  passwd
#define REGIST_URL           @"http://api2.pianke.me/user/reg"   //注册接口的地址 uname gender email passwd

//  评论
#define GETCOMMENT_url         @"http://api2.pianke.me/comment/get" // 获取评论  id
#define ADDCOMMENT_url         @"http://api2.pianke.me/comment/add" // 发表评论  contentid content   auth
#define DELCOMMENT_url         @"http://api2.pianke.me/comment/del" // 删除评论 contentid commentid auth

#endif /* URLDefineHeader_h */
