//
//  RadioPlayViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RadioPlayViewController.h"
#import "PlayDetailView.h"
#import "MusicControllerView.h"
#import "RadioDetailModel.h"
@interface RadioPlayViewController ()

//上面部分的复合视图
@property (nonatomic, strong) PlayDetailView *detailView;

//下面部分的控制按钮
@property (nonatomic,strong) MusicControllerView *musicControllre;

@end

@implementation RadioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView = [[PlayDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 100)MusicList:self.musicList];
    
    [self.view addSubview:self.detailView];
    
    //显示当前正在播放的model
    
    [self.detailView setCurrentModel:self.musicList[_selectIndex]];
    
    //加载按钮视图
    self.musicControllre = [[NSBundle mainBundle] loadNibNamed:@"MusicControllerView" owner:self options:nil].lastObject;
    //设置frame
    self.musicControllre.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100);
    [self.view addSubview:self.musicControllre];
    
    //添加点击事件
    //下一曲
    [self.musicControllre.nextBtn addTarget:self action:@selector(nextMusicAction) forControlEvents:(UIControlEventTouchUpInside)];
    //上一曲
    [self.musicControllre.lastBtn addTarget:self action:@selector(lastMusciAction) forControlEvents:(UIControlEventTouchUpInside)];
    //播放暂停
    [self.musicControllre.playOrPause addTarget:self action:@selector(playBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //slider事件
    [self.musicControllre.timerSlider addTarget:self action:@selector(sliderAction) forControlEvents:(UIControlEventValueChanged)];
    
    __block RadioPlayViewController * weakSelf = self;
    //通过block获取detailView的偏移量
    self.detailView.offsetChanged = ^(CGFloat offsetX){
        NSInteger index = offsetX/self.view.frame.size.width;
        NSLog(@"%ld",index);
        for (int i = 0; i < 3; i++) {
            UIView *view = [weakSelf.musicControllre viewWithTag:100 + i];
            if (index == i) {
                view.backgroundColor = [UIColor greenColor];
            }else{
                view.backgroundColor = [UIColor grayColor];
            }
        }
    };
    
}

//进度条
- (void)sliderAction{
    //设置当前播放时间
    [[ASMusicManager sharedInstance].player seekToTime:(CMTimeMake(self.musicControllre.timerSlider.value, 1))];
    
}
//播放按钮
- (void)playBtnAction{
    //判断当前播放状态
    if ([ASMusicManager sharedInstance].isPlay) {
        [[ASMusicManager sharedInstance] pause];
        //设置图片为播放按钮
        [self.musicControllre.playOrPause setImage:[UIImage imageNamed:@"player_play@2x"] forState:(UIControlStateNormal)];
    }else{
        [[ASMusicManager sharedInstance] play];
        //设置图片为暂停按钮
        [self.musicControllre.playOrPause setImage:[UIImage imageNamed:@"player_pause@2x"] forState:(UIControlStateNormal)];
    }
}
//上一曲
- (void)lastMusciAction{
    //如果已经到最后一个 回到第一个
    if (self.selectIndex == 0) {
        self.selectIndex = self.musicList.count - 1;
    }else{
        self.selectIndex -= 1;
    }
    //取出下一个model
    RadioDetailModel *mode = self.musicList[_selectIndex];
    //播放音频
    [[ASMusicManager sharedInstance] playMusicWithURLString:mode.musicUrl];
    //刷新界面
    [self.detailView setCurrentModel:mode];
}
//下一曲
- (void)nextMusicAction{
    //如果已经到最后一个 回到第一个
    if (self.selectIndex == self.musicList.count - 1) {
        self.selectIndex = 0;
    }else{
        self.selectIndex += 1;
    }
    //取出下一个model
    RadioDetailModel *mode = self.musicList[_selectIndex];
    //播放音频
    [[ASMusicManager sharedInstance] playMusicWithURLString:mode.musicUrl];
    //刷新界面
    [self.detailView setCurrentModel:mode];
    
}
//播放器代理方法
-(void)currentTime:(CGFloat)currentTime TotalTime:(CGFloat)totalTime{
    self.musicControllre.timerSlider.maximumValue = totalTime;
    self.musicControllre.timerSlider.value = currentTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
