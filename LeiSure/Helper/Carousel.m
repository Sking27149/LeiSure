//
//  Carousel.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "Carousel.h"

@interface Carousel ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

//位置指示器
@property (nonatomic, strong) UIPageControl *pageControl;

//定时器
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation Carousel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame ImageURLS:(NSArray *)imageURLS {
    self = [super initWithFrame:frame];
    
    if (self) {
        if (imageURLS.count == 0) {
            return nil;
        }
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.backgroundColor = [UIColor cyanColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        //初始化pageControl
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        [self addSubview:self.pageControl];
        [self.pageControl addTarget:self action:@selector(pageControlClick) forControlEvents:(UIControlEventValueChanged)];
        
        [self setupScrollView:imageURLS];
        
        
        //初始化定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)pageControlClick {
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake((self.pageControl.currentPage + 1) * self.frame.size.width, 0);
    } completion:^(BOOL finished) {
        //开启定时器
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kInterval]];
    }];
    
    
}

- (void)timerAction {
    //结构体和对象连用是，不能直接赋值
    NSInteger index = self.scrollView.contentOffset.x / self.frame.size.width + 1;
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x = self.frame.size.width *index;
    
   // self.scrollView.contentOffset = offSet;
    [self.scrollView setContentOffset:offSet animated:YES];
    
    
    
}

- (void)setupScrollView:(NSArray *)imageURLS {
    
    
    //设置滚动区域
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (imageURLS.count + 2), 0);
    for (int i = 0; i < imageURLS.count + 2; i++) {
        
        //创建UIimageView
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        
        //第一张显示最后一张图
        if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURLS.lastObject]];
        }else if (i == imageURLS.count + 1) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURLS.firstObject]];
        }else {
            //显示网络图片
            [imageView sd_setImageWithURL:imageURLS[i - 1]];
        }
        
        //创建点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
    }
    //设置pageControl
    self.pageControl.numberOfPages = imageURLS.count;
    
}

//图片点击方法
- (void)imageClick {
    NSInteger index = self.scrollView.contentOffset.x / self.frame.size.width;
    //先判断block是否实现
    if (self.imageClickBlock) {
        self.imageClickBlock(index - 1);
    }
}


//正在滚动方法，无论是修改偏移量 还是用户滑动都会执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //滚动到最前面
    NSInteger count = self.pageControl.numberOfPages + 2;
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width *(count - 2) , 0);
    }else if (scrollView.contentOffset.x >= (self.frame.size.width *(count - 1))) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    //修改page下标
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.frame.size.width - 1;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //暂停定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

//结束拖拽时再开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:kInterval]];
}




@end
