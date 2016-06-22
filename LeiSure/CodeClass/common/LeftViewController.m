//
//  LeftViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "LeftViewController.h"
#import "TopicViewController.h"
#import "GoodsViewController.h"
#import "RadioViewController.h"
#import "ReadViewController.h"
#import "MainViewController.h"
#import "CollectionTableViewController.h"
#import "CollectManager.h"
#import "LoginViewController.h"
#define kProportion 0.7

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *titleArr;

//用户头像
@property (nonatomic, strong) UIImageView *userImage;



@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建彩虹layer
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    //设置frame
    layer.frame = self.view.frame;
    //彩虹的颜色
    layer.colors = @[(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    //添加到你要添加的地方
    [self.view.layer addSublayer:layer];
    
    //初始化数组
    self.titleArr = @[@"阅读", @"电台", @"话题", @"良品"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, self.view.frame.size.height - 160)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftCell"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:(UITableViewScrollPositionNone)];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //选中第一行
    self.userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 50, 50)];
    
    self.userImage.backgroundColor = [UIColor redColor];
   
    [self.userImage setImage:[UIImage imageNamed:@"userDefault"]];
    
    [self.view addSubview:self.userImage];
    
    
    UIButton *loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    loginButton.frame = CGRectMake(65, 40, 80, 50);
    
    [loginButton setTitle:@"登录/注册" forState:(UIControlStateNormal)];
    
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    loginButton.tag = 101;
    
    
    [self.view addSubview:loginButton];
    
    
    UIButton *downLoadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    downLoadBtn.frame = CGRectMake(0, 110, self.view.frame.size.width * (kProportion / 2), 30);
    [downLoadBtn setImage:[UIImage imageNamed:@"u161_end"] forState:(UIControlStateNormal)];
    [downLoadBtn addTarget:self action:@selector(downLoadClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:downLoadBtn];
    
    UIButton *collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    collectBtn.frame = CGRectMake(self.view.frame.size.width * (kProportion / 2), 110, self.view.frame.size.width * (kProportion / 2), 30);
    [collectBtn setImage:[UIImage imageNamed:@"u35"] forState:(UIControlStateNormal)];
    [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:collectBtn];
    
}

- (void)collectClick {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"%@", userDic);
    if (userDic) {
        
        CollectManager *collectManager = [CollectManager sharedInstance];
        
        collectManager.username = userDic[@"uname"];
        NSMutableArray *mArray = [collectManager selectAllData];
         NSLog(@"%@", mArray);
        
        CollectionTableViewController *collectionVC = [[CollectionTableViewController alloc] init];
        collectionVC.dataArr = mArray;
        
       
        
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:collectionVC];
        
        [self presentViewController:navc animated:YES completion:nil];
    }else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    
    
}


- (void)downLoadClick {
    
}

//登录按钮方法
- (void)loginAction {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否要注销？" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //删除用户数据
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
            //把登陆按钮标题改回原来的
            UIButton *loginBtn = [self.view viewWithTag:101];
            [loginBtn setTitle:@"登陆/注册" forState:(UIControlStateNormal)];
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"不" style:(UIAlertActionStyleDefault) handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    //获取
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    //获取管理者登录界面的导航控制器
    UINavigationController *NAVC = [story instantiateViewControllerWithIdentifier:@"loginAndRegist"];
    
    //跳转至登录界面
    [self presentViewController:NAVC animated:YES completion:nil];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    MainViewController *mainVC = self.parentViewController.childViewControllers[1];
    
    UINavigationController *NAVC = mainVC.childViewControllers[indexPath.row];
    
    

    
    
    [mainVC setMainViewController:NAVC];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//视图将要显示的时候修改登录按钮的标题
- (void)viewWillAppear:(BOOL)animated {
    //取出当前用户信息
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (dic) {
        [self.userImage sd_setImageWithURL:dic[@"icon"] placeholderImage:nil];
        
        UIButton *button = [self.view viewWithTag:101];
        
        [button setTitle:dic[@"uname"] forState:(UIControlStateNormal)];
    }
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
