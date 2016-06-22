//
//  RadioViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioTypeModel.h"
#import "Carousel.h"
#import "RadioTableViewCell.h"
#import <MJRefresh.h>
#import "RadioListTableViewController.h"
@interface RadioViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    self.dataArr = @[].mutableCopy;

    [self createSubViews];
    
    [self request];
}

- (void)createSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RadioType"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    //添加上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"aa");
        //调用加载更多的方法
        [self loadMoreData];
    }];
    
    //添加下拉加载数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArr removeAllObjects];
        [self request];
    }];
}

- (void)request {
    [ASRequestTool requestWithType:POST URLString:kRadioListURL Parameter:nil callBack:^(NSData *data, NSError *error) {
        if (data == nil) {
            return;
        }
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSMutableArray *imageURLS = [NSMutableArray array];
        
        //轮播图图片地址数组
        for (NSDictionary *dic in jsonDic[@"data"][@"carousel"]) {
            [imageURLS addObject:dic[@"img"]];
        }
        
        for (NSDictionary *dic in jsonDic[@"data"][@"alllist"]) {
            RadioTypeModel *model = [[RadioTypeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //判断是否已经有了headerBire
            if (self.tableView.tableHeaderView == nil) {
                //初始化轮播图
                Carousel *carousel = [[Carousel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) ImageURLS:imageURLS];
                //设置为tableHeader
                self.tableView.tableHeaderView = carousel;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    }];
}

//加载更多
- (void)loadMoreData {
    
    [ASRequestTool requestWithType:POST URLString:kRadioListMoreURL Parameter:@{@"start" : @(self.dataArr.count)} callBack:^(NSData *data, NSError *error) {
        if (data == nil) {
            return ;
        }
        
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        
        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            RadioTypeModel *model = [[RadioTypeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_header.hidden = (self.dataArr == 0);
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RadioType" forIndexPath:indexPath];
    [cell setContentWithModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RadioTypeModel *model = self.dataArr[indexPath.row];
    
    RadioListTableViewController *listVC = [[RadioListTableViewController alloc] init];
    listVC.radioID = model.radioid;
    
    [self.navigationController pushViewController:listVC animated:YES];
    
}

@end
