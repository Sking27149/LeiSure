//
//  CycleScrollView.h
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView <UIScrollViewDelegate>

/*
   自定义初始化方法
   参数：
   frame: 定义滚动视图的大小
   animationDuration: 滚动的时间间隔
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

// 页面图片的总个数
@property (nonatomic, assign) NSInteger totalPagesCount;
// 刷新视图
@property (nonatomic, copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
// 点击页面
@property (nonatomic, copy) void (^TapActionBlock)(NSInteger pageIndex);

@end
