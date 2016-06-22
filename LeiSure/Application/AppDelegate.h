//
//  AppDelegate.h
//  LeiSure
//
//  Created by lanou on 16/6/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawerViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//抽屉控制器 声明称属性 方便在其他地方控制抽屉
@property (nonatomic, strong) DrawerViewController *drawerVC;

- (void)openDrawer;

@end

