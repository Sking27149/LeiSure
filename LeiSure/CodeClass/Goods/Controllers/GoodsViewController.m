//
//  GoodsViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
@interface GoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation GoodsViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self creatSubViews];
    
    [self request];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self request];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self request];
    }];
}

- (void)request {
    [ASRequestTool requestWithType:POST URLString:kGoodsURL Parameter:@{@"start" : @(self.dataArr.count)} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];

        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            GoodsModel *model = [[GoodsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)creatSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"goodsCell"];

    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_header.hidden = (self.dataArr == 0);
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [TableViewCellFactory createCellWithTableView:tableView Identifier:@"goodsCell" IndexPath:indexPath];
    
    [cell setContentWithModel:self.dataArr[indexPath.row]];
    [cell.contentView removeFromSuperview];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc] init];
    goodsDetailVC.contentid = [self.dataArr[indexPath.row] contentid];
    
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
}

@end
