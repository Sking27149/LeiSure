//
//  DrawerViewController.h
//  LeiSure
//
//  Created by lanou on 16/6/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

//初始化方法 第一个参数 左侧抽屉控制器 右侧主控制器
- (instancetype)initWithLeftVC:(UIViewController *)leftVC MainVC:(UIViewController *)mainVC;

//是否已经打开
@property (nonatomic, assign) BOOL isOpen;

//打开
- (void)open;
//关闭抽屉
- (void)close;


@end
