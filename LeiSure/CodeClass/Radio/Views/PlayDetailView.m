//
//  PlayDetailView.m
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "PlayDetailView.h"
#import "PlayViewTableViewCell.h"
#import "RadioDetailModel.h"
@interface PlayDetailView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation PlayDetailView

- (instancetype)initWithFrame:(CGRect)frame MusicList:(NSMutableArray *)musicList {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataArr = musicList;
        
        //初始化scrollView
        self.rootScroller = [[UIScrollView alloc] initWithFrame:frame];
        self.rootScroller.contentSize = CGSizeMake(frame.size.width * 3, 0);
        self.rootScroller.pagingEnabled = YES;
        //self.rootScroller.backgroundColor = [UIColor redColor];
        [self addSubview:self.rootScroller];
        
        self.backgroundColor = [UIColor whiteColor];
        
        //初始化tableView
        self.musicListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 64) style:(UITableViewStylePlain)];
        
        self.musicListTableView.delegate = self;
        self.musicListTableView.dataSource = self;
        [self.rootScroller addSubview:self.musicListTableView];
        
        [self.musicListTableView registerNib:[UINib nibWithNibName:@"PlayViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"playTableCell"];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_rootScroller.contentSize.width / 2 - frame.size.width * 0.8 / 2, 20, frame.size.width * 0.8, frame.size.width * 0.8)];
        
        self.imageView.backgroundColor = [UIColor redColor];
        
        [self.rootScroller addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width, _rootScroller.height + 20, frame.size.width, 30)];
        
        self.titleLabel.backgroundColor = [UIColor redColor];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        [self.rootScroller addSubview:self.titleLabel];
        
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(frame.size.width * 2, 0, frame.size.width, frame.size.height)];
        
        [self.rootScroller addSubview:self.webView];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playTableCell" forIndexPath:indexPath];
    
    //取出相应的model赋值
    RadioDetailModel *model = self.dataArr[indexPath.row];
    cell.titleLabel.text = model.title;
    
    cell.usernameLabel.text = model.playInfo[@"userinfo"][@"uname"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    //判断是否正在播放
    if ([model.tingid isEqualToString:_currentModel.tingid]) {
        cell.isSelectView.hidden = NO;
    }else{
        cell.isSelectView.hidden = YES;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

//重写set方法 对控件进行赋值
-(void)setCurrentModel:(RadioDetailModel *)currentModel{
    _currentModel = currentModel;
    //图片赋值
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:currentModel.coverimg]];
    //标题赋值
    self.titleLabel.text = currentModel.title;
    
    //加载网页
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:currentModel.playInfo[@"webview_url"]]];
    
    [self.webView loadRequest:request];
    
    //刷新table
    [self.musicListTableView reloadData];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断是tableView还是rootScroller
    if (scrollView != self.rootScroller) {
        return;
    }
    
    if (self.offsetChanged) {
        self.offsetChanged(scrollView.contentOffset.x);
    }
}

@end
