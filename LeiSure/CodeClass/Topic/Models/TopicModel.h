//
//  TopicModel.h
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseModel.h"

@interface TopicModel : BaseModel

@property (nonatomic, copy) NSString *addtime_f;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *contentid;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic) BOOL ishot;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSDictionary *counterList;

@property (nonatomic, copy) NSDictionary *userinfo;

@property (nonatomic, copy) NSString *songid;


@end
