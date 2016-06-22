//
//  CollectManager.m
//  LeiSure
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CollectManager.h"
#import <FMDB.h>

static CollectManager *collectManager = nil;

@interface CollectManager ()

@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, copy) NSString *DBPath;


@end


@implementation CollectManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        collectManager = [[CollectManager alloc] init];
    });
    return collectManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化数据需要制定数据库路径
        NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        
        self.DBPath = [filePath stringByAppendingPathComponent:@"leisure.sqlite"];
        
        NSLog(@"%@", self.DBPath);
        
        //初始化数据库
        self.db = [FMDatabase databaseWithPath:self.DBPath];
    }
    return self;
}

//添加数据
- (BOOL)insertDataWitnModel:(ReadRealListModel *)model {
    
    BOOL openResult = [self.db open];
    //创建sql语句
    if (openResult) {
        //创建sql语句
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (modelID, model) values(?,?)", self.username];
        NSMutableData *data = [NSMutableData dataWithCapacity:0];
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        [archiver encodeObject:model forKey:model.ID];
        
        [archiver finishEncoding];
        
        
        //执行语句
        BOOL executeResult = [self.db executeUpdate:sql, model.ID, data];
        if (executeResult) {
            NSLog(@"插入成功");
        }else {
            NSLog(@"插入失败");
        }
    }
    [self.db close];
    
    
    
    return YES;
}

//删除数据
- (BOOL)deleteDataWithID:(NSString *)modelID {
    
    if ([self.db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where modelID = ?;", self.username];
        [self.db executeUpdate:sql, modelID];
    }
    
    [self.db close];
    
    
    return YES;
}

//删除当前用户所有数据
- (BOOL)removeAllDataFromCurrentUser {
    
    if ([self.db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"delete from %@;", self.username];
        [self.db executeUpdate:sql];
    }
    
    [self.db close];
    
    
    return YES;
}

//返回当前用户所有的收藏
- (NSMutableArray *)selectAllData {
    
    NSMutableArray *mArr = @[].mutableCopy;
    if ([self.db open]) {
        NSString *sql = [NSString stringWithFormat:@"select *from %@", self.username];
        FMResultSet *resultSet = [self.db executeQuery:sql];
        while ([resultSet next]) {
            NSData *data = [resultSet dataForColumn:@"model"];
            NSString *modelID = [resultSet stringForColumn:@"modelID"];
            NSLog(@"%@", modelID);
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            ReadRealListModel *model = [unArchiver decodeObjectForKey: modelID];
            [mArr addObject:model];
        }
    }
    return mArr;
}
//查询单个
- (ReadRealListModel *)selectModelWithID:(NSString *)modelID {
    
    ReadRealListModel *model = nil;
    if ([self.db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"select *from %@ where modelID = ?", self.username];
        
        FMResultSet *resultSet = [self.db executeQuery:sql, modelID];
        while ([resultSet next]) {
            NSData *data = [resultSet dataForColumn:@"model"];
            NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            
            model = [unArchiver decodeObjectForKey:modelID];
        }
    }
    
    return model;
}

//创建数据库
- (void)creatDB {

    
    //连接数据库
    BOOL result = [self.db open];
    if (result) {
        NSLog(@"打开数据库成功");
        //创建一个表
        NSString *sql = [NSString stringWithFormat: @"create table if not exists %@ (modelID text primary key, model blob not null)", self.username];
        //执行sql语句 , 在FMDB中除了查询其他都视为update
        BOOL createResult = [self.db executeUpdate:sql];
        if (createResult) {
            NSLog(@"建表成功");
        }else {
            NSLog(@"建表失败");
        }
    }else {
        NSLog(@"打开数据库失败");
    }
}


@end
