//
//  ReadDetailViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadDetailViewController.h"
#import "CommentViewController.h"
#import <FMDB.h>
#import "CollectManager.h"
@interface ReadDetailViewController ()




@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加收藏按钮    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"u205"] style:(UIBarButtonItemStylePlain) target:self action:@selector(collectionBtnAction)];
    
    //分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(sharedBtnItem)];
    
    //评论按钮
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"u40"] style:(UIBarButtonItemStylePlain) target:self action:@selector(commentBtn)];
    
    self.navigationItem.rightBarButtonItems = @[item, commentItem, shareItem];
    
    
}

- (void)commentBtn {
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    
    commentVC.contentid = self.contentid;
    
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

- (void)sharedBtnItem {
    
}

- (void)collectionBtnAction {
    
    CollectManager *dbManager = [CollectManager sharedInstance];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
//    NSLog(@"%@", userDic);
    
    if (userDic) {
        NSLog(@"111");
        
        dbManager.username = userDic[@"uname"];
        [dbManager creatDB];
        
        if ([dbManager selectModelWithID: self.model.ID] == nil) {
            
              [dbManager insertDataWitnModel:self.model];
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"收藏成功" preferredStyle:(UIAlertControllerStyleAlert)];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleDefault) handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该文章已被收藏过" preferredStyle:(UIAlertControllerStyleAlert)];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleDefault) handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
     

        
        
    }else {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        UINavigationController *loginNAVC = [story instantiateViewControllerWithIdentifier:@"loginAndRegist"];
        [self presentViewController:loginNAVC animated:YES completion:nil];
    }
    
    
    
}

- (void)requestData {
    [ASRequestTool requestWithType:POST URLString:kReadDetailURL Parameter:@{@"contentid" : self.contentid} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //如果请求数据成功就创建WebView
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
            [self.view addSubview:webView];
            self.automaticallyAdjustsScrollViewInsets = NO;
            //强大的HTML+CSS让人膜拜，但是只有HTML就强大不了，如果我们直接让webView加载HTML是没有布局的，不适配屏幕，我们的得给他指定一个CSS让他去布局
            //和加载网页是不同的， 网页自带CSS 所以不需要我们再去指定
            
            //加载HTML内容
          
            NSString *cssPath1 = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
            NSLog(@"--------%@", cssPath1);
            [webView loadHTMLString:jsonDic[@"data"][@"html"] baseURL:[NSURL fileURLWithPath: cssPath1]];
        });
        
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
