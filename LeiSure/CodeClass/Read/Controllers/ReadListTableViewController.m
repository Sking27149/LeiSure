//
//  ReadListTableViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadListTableViewController.h"
#import "ReadRealListModel.h"
#import "TableViewCellFactory.h"
#import "BaseTableViewCell.h"
#import "ReadListTabelViewCell.h"
#import <MJRefresh.h>
#import "ReadDetailViewController.h"
#import "ReadListModel.h"
@interface ReadListTableViewController ()




@end

@implementation ReadListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.dataArray = @[].mutableCopy;
    [self requestData];
    [self addHeaderAndFooter];
}




//添加上拉和下拉控件
- (void)addHeaderAndFooter {
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self requestData];
    }];
    
    MJRefreshGifHeader *gif = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        
        [self requestData];
    }];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1; i < 23; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        [imageArr addObject:image];
    }
    [gif setImages:imageArr forState:(MJRefreshStateRefreshing)];
    
    self.tableView.mj_header = gif;
    
}


//请求数据
- (void)requestData {
    [ASRequestTool requestWithType:POST URLString:kReadListDeatilURL Parameter:@{@"typeid" : @(self.TypeId), @"start":@(self.dataArray.count)} callBack:^(NSData *data, NSError *error) {
        //解析
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
            ReadRealListModel *readListModel = [[ReadRealListModel alloc] init];
            [readListModel setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:readListModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [TableViewCellFactory createCellWithTableView:tableView Identifier:@"readList" IndexPath:indexPath ];
    [cell setContentWithModel:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出相应的ID
    ReadRealListModel *model = self.dataArray[indexPath.row];
    ReadDetailViewController *readDetailVC = [[ReadDetailViewController alloc] init];
    readDetailVC.contentid = model.ID;
    readDetailVC.model = model;
    [self.navigationController pushViewController:readDetailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
