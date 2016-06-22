//
//  TableViewCellFactory.h
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTableViewCell.h"

@interface TableViewCellFactory : NSObject

+ (BaseTableViewCell *)createCellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier IndexPath:(NSIndexPath *)indexPath;


@end
