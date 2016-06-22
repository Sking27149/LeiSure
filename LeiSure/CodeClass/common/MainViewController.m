//
//  MainViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "MainViewController.h"
#import "RadioViewController.h"
#import "TopicViewController.h"
#import "GoodsViewController.h"
#import "ReadViewController.h"
#import "LeftViewController.h"
#import "ASUINaViewController.h"
@interface MainViewController ()

@property (nonatomic, strong) UIView *showView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加一个按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:[UIApplication sharedApplication].delegate action:@selector(openDrawer)];
    
    
    RadioViewController *radioVC = [[RadioViewController alloc] init];
    ASUINaViewController *radioNAVC = [[ASUINaViewController alloc] initWithRootViewController:radioVC];
    radioVC.navigationItem.leftBarButtonItem = leftItem;
    
    
    ReadViewController *readVC = [[ReadViewController alloc] init];
    ASUINaViewController *readNAVC = [[ASUINaViewController alloc] initWithRootViewController:readVC];
    readVC.navigationItem.leftBarButtonItem = leftItem;
    
    TopicViewController *topicVC = [[TopicViewController alloc] init];
    ASUINaViewController *topicNAVC = [[ASUINaViewController alloc] initWithRootViewController:topicVC];
    topicVC.navigationItem.leftBarButtonItem = leftItem;
    

    GoodsViewController *goodsVC = [[GoodsViewController alloc] init];
    ASUINaViewController *goodsNAVC = [[ASUINaViewController alloc] initWithRootViewController:goodsVC];
    goodsVC.navigationItem.leftBarButtonItem = leftItem;
    
    [self addChildViewController:readNAVC];
    [self addChildViewController:radioNAVC];
    [self addChildViewController:topicNAVC];
    [self addChildViewController:goodsNAVC];
    self.showView = readNAVC.view;
    [self.view addSubview:self.showView];
}

- (void)setMainViewController:(UIViewController *)newVC {
    //判断一下是否已经添加这个控制器作为子视图控制器
    
    if (self.showView == newVC.view) {
        
        [self.parentViewController performSelector:@selector(close)];
        return;
    }

    
    //用当前主视图的frame作为新的视图的frame
    CGRect mainFeame = self.showView.frame;
    //先让将要出现的view处于屏幕的下方
    mainFeame.origin.y += kScreenHeight;
    
    newVC.view.frame = mainFeame;
    
    //第二个要去的地方是原来的位置
    mainFeame.origin.y -= kScreenHeight;
    
    //添加到视图上
    [self.view addSubview:newVC.view];
    
    CGRect goFrame = mainFeame;
    goFrame.origin.y -= kScreenHeight;
    
    LeftViewController *leftVC = self.parentViewController.childViewControllers[0];
    
    //加点特效
    [UIView animateWithDuration:0.3 animations:^{
        newVC.view.frame = mainFeame;
        //让原来的view滑到上面去
        self.showView.frame = goFrame;
        
        leftVC.view.userInteractionEnabled = NO;
    }completion:^(BOOL finished) {
        //做完动画再将原来的view删除
        //移除旧的视图
        [self.showView removeFromSuperview];
        //移除平移手势
        //让MainView的指针指向新的MainView
        self.showView = newVC.view;
        //给新的mainView添加手势
        leftVC.view.userInteractionEnabled = YES;
        
        //切换完成 关闭抽屉
        [self.parentViewController performSelector:@selector(close)];
    }];

    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
