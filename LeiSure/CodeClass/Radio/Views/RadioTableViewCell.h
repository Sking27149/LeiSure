//
//  RadioTableViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioTypeModel.h"
@interface RadioTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *author;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

//空间赋值方法
- (void)setContentWithModel:(RadioTypeModel *)model;


@end
