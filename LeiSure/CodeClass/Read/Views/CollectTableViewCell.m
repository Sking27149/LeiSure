//
//  CollectTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/22.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CollectTableViewCell.h"

@implementation CollectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setContentWithModel:(ReadRealListModel *)model{
    self.titleLabel.text = model.title;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.contentLabel.text = model.content;
    
}

@end
