//
//  CollectTableViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReadRealListModel.h"

@interface CollectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)setContentWithModel:(ReadRealListModel *)model;

@end
