//
//  ASRequestTool.h
//  LeiSure
//
//  Created by lanou on 16/6/14.
//  Copyright © 2016年 Sking. All rights reserved.
//

//请求类型
typedef enum {
    GET,
    POST
} requestType;

#import <Foundation/Foundation.h>

@interface ASRequestTool : NSObject




//数据请求
//参数：请求类型 请求地址 POST参数字典 block回调
+ (void)requestWithType:(requestType)type URLString:(NSString *)urString Parameter:(NSDictionary *)parameterDic callBack:(void(^)(NSData *data, NSError *error))callBack;



@end
