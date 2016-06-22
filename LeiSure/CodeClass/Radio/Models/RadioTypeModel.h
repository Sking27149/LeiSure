//
//  RadioTypeModel.h
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseModel.h"

@interface RadioTypeModel : BaseModel

@property (nonatomic, copy) NSNumber *count;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *radioid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDictionary *userinfo;


@end
