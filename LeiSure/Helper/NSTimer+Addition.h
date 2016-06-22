//
//  NSTimer+Addition.h
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

//暂停
- (void)pauseTimer;

//继续
- (void)resumeTimer;

//延迟多少秒后继续
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
