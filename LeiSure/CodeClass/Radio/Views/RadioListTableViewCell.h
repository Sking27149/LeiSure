//
//  RadioListTableViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioDetailModel.h"
@interface RadioListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)setContentWithModel:(RadioDetailModel *)model;

@end
