//
//  TableViewCellFactory.m
//  LeiSure
//
//  Created by lanou on 16/6/16.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "TableViewCellFactory.h"

@implementation TableViewCellFactory

+ (BaseTableViewCell *)createCellWithTableView:(UITableView *)tableView Identifier:(NSString *)identifier IndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

@end
