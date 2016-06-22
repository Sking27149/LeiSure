//
//  ReadListTabelViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadListTabelViewCell.h"
@implementation ReadListTabelViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setContentWithModel:(ReadRealListModel *)model{
    self.titleLabel.text = model.title;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.contentLabel.text = model.content;
    
}

@end
