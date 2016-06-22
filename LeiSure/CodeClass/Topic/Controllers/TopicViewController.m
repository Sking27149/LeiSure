//
//  TopicViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicModel.h"
#import "TopicTableViewCell.h"
#import "TopicDetailTableViewController.h"
@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *sort;
@end

@implementation TopicViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
    [self request];
}

- (void)createSubViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 119, kScreenWidth, kScreenHeight - 119) style:(UITableViewStylePlain)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"topicCell"];
    
    [self.view addSubview:self.tableView];
    
    self.sort = @"hot";
    
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"Hot", @"New"]];
    segControl.frame = CGRectMake(0, 74, 150, 25);
    CGPoint center = segControl.center;
    center.x = kScreenWidth / 2;
    segControl.center = center;
    [segControl addTarget:self action:@selector(seg:) forControlEvents:(UIControlEventValueChanged)];
    segControl.selectedSegmentIndex = 0;
    
    
    NSDictionary *attributeDic = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:21], NSForegroundColorAttributeName : [UIColor blackColor]};
    [segControl setTitleTextAttributes:attributeDic forState:(UIControlStateNormal)];
    [self.view addSubview:segControl];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self request];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self request];
    }];
    
}

- (void)request {
    
    [ASRequestTool requestWithType:POST URLString:kTopicURL Parameter:@{@"start" : @(self.dataArr.count), @"sort" : self.sort} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            TopicModel *topicModel = [[TopicModel alloc] init];
            [topicModel setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:topicModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)seg:(UISegmentedControl *)segControl {
    if (segControl.selectedSegmentIndex == 0) {
        self.sort = @"hot";
        [self.dataArr removeAllObjects];
        [self request];
    }else {
        self.sort = @"addtime";
        [self.dataArr removeAllObjects];
        [self request];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_header.hidden = (self.dataArr.count == 0);
    return self.dataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
    
    [cell setContentModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicDetailTableViewController *topicDetailVC = [[TopicDetailTableViewController alloc] init];
    
    topicDetailVC.contentid = [self.dataArr[indexPath.row] contentid];
    
    [self.navigationController pushViewController:topicDetailVC animated:YES];
}



@end
