//
//  RadioListTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RadioListTableViewCell.h"


@interface RadioListTableViewCell ()
@property (nonatomic, copy) NSString *musicRUL;

@end

@implementation RadioListTableViewCell


- (IBAction)playBtn:(id)sender {
    NSNotificationCenter *notice = [NSNotificationCenter defaultCenter];
    [notice postNotificationName:@"radioList" object:self.musicRUL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setContentWithModel:(RadioDetailModel *)model {
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"u58"]];
    
    self.titleLabel.text = model.title;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld", model.musicVisit];
    
    self.musicRUL = model.musicUrl;

}

@end
