//
//  RadioPlayViewController.h
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioPlayViewController : UIViewController

//播放列表
@property (nonatomic, strong) NSMutableArray *musicList;

//点击的下标
@property (nonatomic) NSInteger selectIndex;


@end
