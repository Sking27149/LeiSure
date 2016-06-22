//
//  GoodsDetailViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self request];
}

- (void)request {
    [ASRequestTool requestWithType:POST URLString:kGoodsDetailURL Parameter:@{@"contentid" : self.contentid} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
            [self.view addSubview:webView];
            self.automaticallyAdjustsScrollViewInsets = NO;
            
            NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
            
            [webView loadHTMLString:jsonDic[@"data"][@"postsinfo"][@"html"] baseURL:[NSURL fileURLWithPath:cssPath]];
        });
    }];
}



@end
