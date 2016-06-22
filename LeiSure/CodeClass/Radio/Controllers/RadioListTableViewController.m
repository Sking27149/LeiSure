//
//  RadioListTableViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RadioListTableViewController.h"
#import "RadioDetailModel.h"
#import "RadioListTableViewCell.h"
#import <MJRefresh.h>
#import "RadioPlayViewController.h"
@interface RadioListTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSNumber *musicvisitnum;

@property (nonatomic, copy) NSString *uname;


@end

@implementation RadioListTableViewController

- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RadioListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"radioList"];
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    
    NSNotificationCenter *notice = [NSNotificationCenter defaultCenter];
    [notice addObserver:self selector:@selector(playRadio:) name:@"radioList" object:nil];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArr removeAllObjects];
        [self request];
    }];
    
    [self request];
}

- (void)playRadio:(NSNotification *)no {
    
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    RadioDetailModel *model = self.dataArr[indexPath.row];
//    NSLog(@"%@", model.musicUrl);
    
    ASMusicManager *manager = [ASMusicManager sharedInstance];
    [manager playMusicWithURLString:no.object];
    NSLog(@"%@", no.object);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMoreData {
    
    [ASRequestTool requestWithType:POST URLString:kRadioDetailMoreURL Parameter:@{@"radioid" : self.radioID, @"start" : @(self.dataArr.count)} callBack:^(NSData *data, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options: (NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        
        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            RadioDetailModel *detailModel = [[RadioDetailModel alloc] init];
            [detailModel setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:detailModel];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
            [self.tableView.mj_footer endRefreshing];

        });
    }];

}

- (void)request {
    [ASRequestTool requestWithType:POST URLString:kRadioDetailURL Parameter:@{@"radioid" : self.radioID} callBack:^(NSData *data, NSError *error) {
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options: (NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        
        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            RadioDetailModel *detailModel = [[RadioDetailModel alloc] init];
            [detailModel setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:detailModel];
        }
        self.coverimg = jsonDic[@"data"][@"radioInfo"][@"coverimg"];
        self.desc = jsonDic[@"data"][@"radioInfo"][@"desc"];
        self.icon = jsonDic[@"data"][@"radioInfo"][@"userinfo"][@"icon"];
        self.musicvisitnum = jsonDic[@"data"][@"radioInfo"][@"musicvisitnum"];
        self.uname = jsonDic[@"data"][@"radioInfo"][@"userinfo"][@"uname"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
            
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:jsonDic[@"data"][@"radioInfo"][@"coverimg"]] placeholderImage:[UIImage imageNamed:@"u58"]];
            self.tableView.tableHeaderView = imageView;
            
            [self.tableView.mj_header endRefreshing];
        });
    }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
    [header sd_setImageWithURL:[NSURL URLWithString:self.icon]];
    header.layer.cornerRadius = 15;
    [headerView addSubview:header];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 20, 150, 20)];
    nameLabel.text = self.uname;
    [headerView addSubview:nameLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 300, 20)];
    descLabel.font = [UIFont systemFontOfSize:15];
    descLabel.text = self.desc;
    [headerView addSubview:descLabel];
    
    UILabel *musicvisitnumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 20, 80, 20)];
    musicvisitnumLabel.text = [NSString stringWithFormat:@"%@",self.musicvisitnum];
    [headerView addSubview:musicvisitnumLabel];
    
    UIImageView *play = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 130, 20, 20, 20)];
    play.image = [UIImage imageNamed:@"u58"];
    [headerView addSubview:play];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RadioListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioList" forIndexPath:indexPath];
    
    [cell setContentWithModel:self.dataArr[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    RadioDetailModel *model = self.dataArr[indexPath.row];
    RadioPlayViewController *radioPlayerVC = [[RadioPlayViewController alloc] init];
    radioPlayerVC.selectIndex = indexPath.row;
    radioPlayerVC.musicList = self.dataArr;
    
    [self.navigationController pushViewController:radioPlayerVC animated:YES];
}

@end
