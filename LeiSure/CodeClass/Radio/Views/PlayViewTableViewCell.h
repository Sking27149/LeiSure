//
//  PlayViewTableViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/20.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayViewTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *isSelectView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;

@end
