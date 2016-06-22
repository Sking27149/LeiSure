//
//  ReadListModel.h
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseModel.h"

@interface ReadListModel : BaseModel

@property (nonatomic, copy) NSString *coverimg;
//英文名
@property (nonatomic, copy) NSString *enname;
//中文名
@property (nonatomic, copy) NSString *name;
//类型
@property (nonatomic) NSInteger type;



@end
