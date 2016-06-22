//
//  RadioTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RadioTableViewCell.h"

@implementation RadioTableViewCell



- (void)setContentWithModel:(RadioTypeModel *)model {
    
    self.titleLabel.text = model.title;
    
    self.author.text = [NSString stringWithFormat:@"by:%@", model.userinfo[@"uname"]];
    
    self.countLabel.text = model.count.stringValue;
    
    
    self.contentLabel.text = model.desc;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"u58"]];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
