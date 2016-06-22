//
//  CollectionTableViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "CollectTableViewCell.h"
#import "ReadDetailViewController.h"
#import "CollectManager.h"
@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    
    self.navigationItem.leftBarButtonItem = backItem;
   
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"删除"] style:(UIBarButtonItemStylePlain) target:self action:@selector(deleteAll)];
    
    self.navigationItem.rightBarButtonItem = deleteItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"collectCell"];
    
}

- (void)deleteAll {
    CollectManager *manager = [CollectManager sharedInstance];
    
    [manager removeAllDataFromCurrentUser];
    
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];
    
}

- (void)dismiss {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
    
    [cell setContentWithModel:self.dataArr[indexPath.row]];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出相应的ID
    ReadRealListModel *model = self.dataArr[indexPath.row];
    ReadDetailViewController *readDetailVC = [[ReadDetailViewController alloc] init];
    readDetailVC.contentid = model.ID;
    readDetailVC.model = model;
    [self.navigationController pushViewController:readDetailVC animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        ReadRealListModel *model = self.dataArr[indexPath.row];
        
        [[CollectManager sharedInstance] deleteDataWithID:model.ID];
        
        [self.dataArr removeObject:model];
        
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [self.tableView endUpdates];
}

- (void)setView:(UIView *)view {
    
    NSLog(@"lala");
    CGRect frame = view.frame;
    frame.origin.x = 100;
    view.frame = frame;
    
    [super setView:view];
    
    
}



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
