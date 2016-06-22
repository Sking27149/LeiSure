//
//  Carousel.h
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kInterval 2

//定义一个block 无返回值 有参数
typedef void(^CarouselViewBlock)(NSInteger index);

@interface Carousel : UIView

//图片点击block
@property (nonatomic, copy) CarouselViewBlock imageClickBlock;


- (instancetype)initWithFrame:(CGRect)frame ImageURLS:(NSArray *)imageURLS;


- (void)setupScrollView:(NSArray *)imageURLS;



@end
