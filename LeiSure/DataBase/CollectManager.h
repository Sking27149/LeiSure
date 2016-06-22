//
//  CollectManager.h
//  LeiSure
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadRealListModel.h"
@interface CollectManager : NSObject

@property (nonatomic, copy) NSString *username;

//返回单列
+ (instancetype)sharedInstance;

//添加数据
- (BOOL)insertDataWitnModel:(ReadRealListModel *)model;

//删除数据
- (BOOL)deleteDataWithID:(NSString *)modelID;

//删除当前用户所有数据
- (BOOL)removeAllDataFromCurrentUser;

//返回当前用户所有的收藏
- (NSMutableArray *)selectAllData;

- (void)creatDB;

//根据id查询某个
- (ReadRealListModel *)selectModelWithID:(NSString *)modelID;

@end
