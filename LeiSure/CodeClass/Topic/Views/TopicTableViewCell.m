//
//  TopicTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "TopicTableViewCell.h"
@interface TopicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *jingBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *addTimeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contenConstaint;


@end

@implementation TopicTableViewCell


- (void)setContentModel:(TopicModel *)contentModel {
    self.titleLabel.text = contentModel.title;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:contentModel.coverimg] placeholderImage:[UIImage imageNamed:@"u58"]];
    self.contentLabel.text = contentModel.content;
    self.addTimeLabel.text = contentModel.addtime_f;
    
    if (!contentModel.ishot) {
        self.jingBtn.hidden = YES;
        self.titleConstraint.constant = 20;
    }else {
        self.jingBtn.hidden = NO;
        self.titleConstraint.constant = 85;
    }
    
    if (contentModel.coverimg.length <= 5) {
        self.headView.hidden = YES;
        self.contenConstaint.constant = 20;
    }else {
        self.headView.hidden = NO;
        self.contenConstaint.constant = 75;
    }
    
    self.countLabel.text = [contentModel.counterList[@"comment"] stringValue];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
