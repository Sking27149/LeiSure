//
//  CommentViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentModel.h"
#import "CommentTableViewCell.h"
@interface CommentViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSMutableArray *commentArr;


@end

@implementation CommentViewController

- (NSMutableArray *)commentArr {
    if (_commentArr == nil) {
        _commentArr = [@[] mutableCopy];
    }
    return _commentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSubViews];
    
    [self request];
    
    
}

- (void)request {
    [ASRequestTool requestWithType:POST URLString:GETCOMMENT_url Parameter:@{@"contentid" : self.contentid, @"start" : @(self.commentArr.count)} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        if ([jsonDic[@"result"] integerValue] == 1) {
            NSLog(@"%@", jsonDic);
            
            for (NSDictionary *dic in jsonDic[@"data"][@"list"]) {
                
                CommentModel *comment = [[CommentModel alloc] init];
                
                [comment setValuesForKeysWithDictionary:dic];
                
                [self.commentArr addObject:comment];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
                [self.tableView.mj_header endRefreshing];
                
                [self.tableView.mj_footer endRefreshing];
                
            });
            
        }else {
            //请求数据失败
        }
    }];
}

- (void)creatSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentCell"];
    
    [self.view addSubview:self.tableView];
    
    self.inputView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 100)];
    self.inputView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.inputView];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 40 - 50, 80)];
    self.textView.backgroundColor = [UIColor lightGrayColor];
    self.textView.delegate = self;
    [self.inputView addSubview:self.textView];
    
    UIButton *sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    sendButton.frame = CGRectMake(kScreenWidth - 90 + 5, 10, 45, 80);
    sendButton.backgroundColor = [UIColor darkGrayColor];
    [sendButton setTitle:@"发送" forState:(UIControlStateNormal)];
    [sendButton addTarget:self action:@selector(sendBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.inputView addSubview:sendButton];
    
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"u49"] style:(UIBarButtonItemStylePlain) target:self action:@selector(editBtn)];
    
    self.navigationItem.rightBarButtonItem = editBtn;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.commentArr removeAllObjects];
        [self request];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self request];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)sendRequest {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    [ASRequestTool requestWithType:POST URLString:ADDCOMMENT_url Parameter:@{@"contentid" : self.contentid, @"content" : self.textView.text, @"auth" : userDic[@"auth"]} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        NSLog(@"%@", jsonDic);
        
        if ([jsonDic[@"result"] integerValue] == 1) {
            [self.commentArr removeAllObjects];
            [self request];
        }
    }];
}



- (void)sendBtn {
    [self.textView resignFirstResponder];
    [self sendRequest];
}

- (void)editBtn {
    
    [self.textView becomeFirstResponder];
    
}


//键盘即将弹出
- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *dic = note.userInfo;
    
    NSValue *value = dic[@"UIKeyboardBoundsUserInfoKey"];
    CGRect bounds = [value CGRectValue];
    
    NSString *durationStr = dic[@"UIKeyboardAnimationDurationUserInfoKey"];
    CGFloat duration = durationStr.floatValue;
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.inputView.frame;
        frame.origin.y = kScreenHeight - bounds.size.height - 100;
        self.inputView.frame = frame;
    }];
}
- (void)keyboarWillHidden:(NSNotification *)note {
    NSDictionary *dic = note.userInfo;
    
    NSString *durationStr = dic[@"UIKeyboardAnimationDurationUserInfoKey"];
    CGFloat duration = durationStr.floatValue;
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.inputView.frame;
        frame.origin.y = kScreenHeight;
        self.inputView.frame = frame;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    CommentModel *model = self.commentArr[indexPath.row];
    [cell setcontentWithModel:model];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    cell.deleteBtn.hidden = YES;
    if (userDic[@"uid"] == model.userinfo[@"uid"]) {
        cell.deleteBtn.hidden = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCom:) name:@"deleteCom" object:nil];
    cell.commentModel = model;
    return cell;
}

- (void)deleteCom:(NSNotification *)no {
    
    CommentModel *comment = no.object;
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    [ASRequestTool requestWithType:POST URLString:DELCOMMENT_url Parameter:@{@"contentid" : self.contentid, @"auth" : userDic[@"auth"], @"commentid" : comment.contentid} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"----%@", jsonDic);
        if ([jsonDic[@"result"] integerValue] == 1) {
            [self.commentArr removeAllObjects];
            [self request];
        }
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"deleteCom"];
}

@end
