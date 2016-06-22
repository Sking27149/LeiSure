//
//  ASRequestTool.m
//  LeiSure
//
//  Created by lanou on 16/6/14.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ASRequestTool.h"

@implementation ASRequestTool

+ (void)requestWithType:(requestType)type URLString:(NSString *)urString Parameter:(NSDictionary *)parameterDic callBack:(void (^)(NSData *, NSError *))callBack {
    //转换URL
    NSURL *url = [NSURL URLWithString:urString];
    //如果地址中包含中文或者一些特殊字符，会导致URL转换失败 需要进行UTF8编码
    if (url == nil) {
        NSString *utf8Str = [urString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        url = [NSURL URLWithString:utf8Str];
        
    }
    
    //创建一个可变的请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    if (type == POST) {
        //修改请求方式为POST
        [request setHTTPMethod:@"POST"];
        if (parameterDic == nil) {
            //NSLog(@"请求参数为空");
        }else {
        [request setHTTPBody:[self dataForDic:parameterDic]];
        }
    }
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    //创建一个dataTask 并开始
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //请求完之后，回调自己的block 将数据传出去
        callBack(data, error);
    }] resume];
    
}

+ (NSData *)dataForDic:(NSDictionary *)dic {
    NSMutableString *mStr = [@"" mutableCopy];
    for (NSString *key in dic) {
        [mStr appendFormat:@"&%@=%@", key, dic[key]];
    }
    [mStr deleteCharactersInRange:NSMakeRange(0, 1)];

    NSData *data = [mStr dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}


@end
