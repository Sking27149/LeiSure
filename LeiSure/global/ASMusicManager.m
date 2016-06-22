//
//  ASMusicManager.m
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ASMusicManager.h"

static ASMusicManager *musicManager = nil;

@implementation ASMusicManager

{
    NSTimer *timer;
}

static NSString *currentURL = nil;


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicManager = [[ASMusicManager alloc] init];
    });
    return musicManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc] init];
        timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
        //加入到RUNLoop里
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

//定时器方法
- (void)timeAction {
    
    if (self.player.currentTime.timescale == 0 || self.player.currentItem.duration.timescale == 0) {
        return;
    }
    
    //获取当前时间
    CGFloat currentTime = self.player.currentTime.value / self.player.currentTime.timescale;
    
    CGFloat totalTime = self.player.currentItem.duration.value / self.player.currentItem.duration.timescale;
    
    //判断代理对象是否实现了代理方法
    if ([self.delegate respondsToSelector:@selector(currentTime:TotalTime:)]) {
        [self.delegate currentTime:currentTime TotalTime:totalTime];
    }
    
}

- (void)playMusicWithURLString:(NSString *)URLString {
    
    if ([URLString isEqualToString:currentURL]) {
        return;
    }
    currentURL = URLString;
    
    //先移除旧的Item上的观察着 因为一旦替换了资源 就得item就会被销毁
    if (self.currentItem != nil) {
        [self.currentItem removeObserver:self forKeyPath:@"status"];
    }
    
    //创建新的item
    self.currentItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:URLString]];
    
    //替换当前资源
    [self.player replaceCurrentItemWithPlayerItem:self.currentItem];
    
    
    [self.currentItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    //暂停定时器
    [timer setFireDate:[NSDate distantFuture]];
    
}

//观察者回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
  
    
    //判断当前缓冲的状态
    AVPlayerItem *playerItem = object;
    NSLog(@"lalal");
    switch (playerItem.status) {
        case AVPlayerItemStatusReadyToPlay:
            NSLog(@"缓冲成功");
            [self play];
            break;
        case AVPlayerItemStatusFailed:
            NSLog(@"缓冲失败");
            break;
        case AVPlayerItemStatusUnknown:
            NSLog(@"状态未知");
            break;
        default:
            break;
    }
    
}

- (void)play {
    [self.player play];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

- (void)pause {
    [self.player pause];
    //暂停是同事暂停定时器
    [timer setFireDate:[NSDate distantFuture]];
}

@end
