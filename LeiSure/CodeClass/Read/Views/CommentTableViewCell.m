//
//  CommentTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "CommentTableViewCell.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setcontentWithModel:(CommentModel *)comment {
    self.userNameLabel.text = comment.userinfo[@"uname"];
    
    self.timeLabel.text = comment.addtime_f;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:comment.userinfo[@"icon"]] placeholderImage:[UIImage imageNamed:@"u58"]];
    self.headView.layer.cornerRadius = 20;
    self.headView.clipsToBounds = YES;
    
    self.contentLabel.text = comment.content;
    
 
}

- (IBAction)deleteCom:(id)sender {
       [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteCom" object:self.commentModel];
}



@end
