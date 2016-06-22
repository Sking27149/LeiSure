//
//  ReadRealListModel.h
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface ReadRealListModel : BaseModel <NSCoding>


@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *ID;

@end
