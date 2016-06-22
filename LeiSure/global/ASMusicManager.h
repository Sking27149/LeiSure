//
//  ASMusicManager.h
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol ASMusicManagerDelegate <NSObject>

@optional

//代理方法 将当前事件和总的事件传给外界
- (void)currentTime:(CGFloat)currentTime TotalTime:(CGFloat)totalTime;



@end

@interface ASMusicManager : NSObject

@property (nonatomic, strong) AVPlayer *player;

//媒体资源对象
@property (nonatomic, strong) AVPlayerItem *currentItem;


//声明代理属性
@property (nonatomic, weak) id<ASMusicManagerDelegate> delegate;

+ (instancetype)sharedInstance;

- (void)playMusicWithURLString:(NSString *)URLString;

//当前播放状态
@property (nonatomic,assign) BOOL isPlay;

//播放
- (void)play;

//暂停
- (void)pause;

@end
