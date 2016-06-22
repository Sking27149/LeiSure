//
//  ReadTypeCollectionCell.m
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ReadTypeCollectionCell.h"
#import "BaseCollectionViewCell.h"

@implementation ReadTypeCollectionCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setContentWithModel:(ReadListModel *)model {
    self.titleLabel.text = model.name;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"1"]];
}


@end
