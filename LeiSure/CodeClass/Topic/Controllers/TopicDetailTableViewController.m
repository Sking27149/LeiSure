//
//  TopicDetailTableViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "TopicDetailTableViewController.h"
#import "TopicDetailTableViewCell.h"
@interface TopicDetailTableViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TopicDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
    
    [self request];
}

- (void)creatSubView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 450)];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 250, kScreenWidth, 300)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [headView addSubview:self.webView];
    
    self.tableView.tableHeaderView = headView;
}

- (void)request {
    
    [ASRequestTool requestWithType:POST URLString:kTopicDetailURL Parameter:@{@"contentid" : self.contentid} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDictionary);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
          
           
            NSString *css = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
            [self.webView loadHTMLString:jsonDictionary[@"data"][@"postsinfo"][@"html"] baseURL:[NSURL fileURLWithPath:css]];
        });
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicDetailCell" forIndexPath:indexPath];
    
    
    return cell;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
