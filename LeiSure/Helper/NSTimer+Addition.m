//
//  NSTimer+Addition.m
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

- (void)pauseTimer {
    [self setFireDate:[NSDate distantFuture]];
}

- (void)resumeTimer {
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
