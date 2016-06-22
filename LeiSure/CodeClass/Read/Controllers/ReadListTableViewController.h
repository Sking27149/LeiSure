//
//  ReadListTableViewController.h
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadListTableViewController : UITableViewController

//当前类型
@property (nonatomic) NSInteger TypeId;

//数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
