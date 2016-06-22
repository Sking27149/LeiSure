//
//  PlayDetailView.h
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

typedef void(^playViewScrollViewBlock)(CGFloat offsetX);

#import <UIKit/UIKit.h>
#import "RadioDetailModel.h"
@interface PlayDetailView : UIView

@property (nonatomic, strong) UIScrollView *rootScroller;

@property (nonatomic, strong) UITableView *musicListTableView;

@property (nonatomic, strong) UIImageView *imageView;

//显示专辑名称
@property (nonatomic, strong) UILabel *titleLabel;

//最右边的webView
@property (nonatomic, strong) UIWebView *webView;

//当前正在播放的model
@property (nonatomic, strong) RadioDetailModel *currentModel;

//将当前scrollView的偏移量传递给外界
@property (nonatomic,copy) playViewScrollViewBlock offsetChanged;


//初始化方法 传入所有歌曲列表
- (instancetype)initWithFrame:(CGRect)frame MusicList:(NSMutableArray *)musicList;




@end
