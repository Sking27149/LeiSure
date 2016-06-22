//
//  DrawerViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/13.
//  Copyright © 2016年 Sking. All rights reserved.
//



//主页面偏移距离
#define kProportion 0.7

#import "DrawerViewController.h"

@interface DrawerViewController ()

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *leftView;

//平移手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan;


@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithLeftVC:(UIViewController *)leftVC MainVC:(UIViewController *)mainVC {
    self = [super init];
    if (self) {
        [self addChildViewController:leftVC];
        [self addChildViewController:mainVC];
        
        //左侧控制器添加在最下面
        [self.view addSubview:leftVC.view];
        [self.view addSubview:mainVC.view];
        //视图赋值
        self.mainView = mainVC.view;
        self.leftView = leftVC.view;
        
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHander)];
        //添加到上面的MainView上
        [self.mainView addGestureRecognizer:self.pan];
        self.leftView.transform = CGAffineTransformMakeScale(2, 2);
    }
    return self;
}

- (void)panHander {
    //获取用户手指位置
    CGPoint userPoint = [self.pan translationInView:self.mainView];
   // NSLog(@"%@", NSStringFromCGPoint(userPoint));
    //接受原始的frame
    CGRect mainFrame = self.mainView.frame;
    mainFrame.origin.x += userPoint.x;
    
  
    
    if (mainFrame.origin.x >= 0 && mainFrame.origin.x <= self.view.frame.size.width * kProportion) {
        
        
        self.leftView.transform = CGAffineTransformMakeScale(2 - (self.mainView.frame.origin.x) / (self.view.frame.size.width * kProportion), 2 - (self.mainView.frame.origin.x) / (self.view.frame.size.width * kProportion));
       
        self.mainView.frame = mainFrame;
        
        //同时修改leftView的frame
        CGRect leftFrame = self.leftView.frame;
        //将leftView的frame从左到右移动，来做一个平移效果
        leftFrame.origin.x = mainFrame.origin.x / 2 - self.view.frame.size.width * kProportion / 2;
        self.leftView.frame = leftFrame;

    }
    //将本次已经移动到的点设置为0
    [self.pan setTranslation:CGPointZero inView:self.mainView];
    
    if (self.pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x > self.view.frame.size.width * 0.5) {
            [self open];
        }else {
            [self close];
        }
    }
}


//打开抽屉
- (void)open {

    [UIView animateWithDuration:0.3 animations:^{
        //修改leftView的缩放
        self.leftView.transform = CGAffineTransformMakeScale(1, 1);

        //获取原始frame
        CGRect mainFrame = self.mainView.frame;
        //修改x值，使其往右边移动
        mainFrame.origin.x = self.view.frame.size.width * kProportion;
        //赋给新的frame
        self.mainView.frame = mainFrame;
       //修改letView的frame让他跟着一起动
        self.leftView.frame = self.view.frame;
        
    }completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}

- (void)close {

    [UIView animateWithDuration:0.3 animations:^{
        self.leftView.transform = CGAffineTransformMakeScale(2, 2);

        self.mainView.frame = self.view.frame;
        
        CGRect leftFrame = self.leftView.frame;
        leftFrame.origin.x = - self.view.frame.size.width * kProportion / 2;
        self.leftView.frame = leftFrame;
        
    } completion:^(BOOL finished) {
        self.isOpen = NO;
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
