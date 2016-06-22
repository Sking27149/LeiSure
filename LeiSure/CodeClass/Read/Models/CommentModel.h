//
//  CommentModel.h
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel

@property (nonatomic, copy) NSString *contentid;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSDictionary *userinfo;

@property (nonatomic, copy) NSString *addtime_f;



@end

