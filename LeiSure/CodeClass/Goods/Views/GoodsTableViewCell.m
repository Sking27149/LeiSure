//
//  GoodsTableViewCell.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "GoodsModel.h"

@interface GoodsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation GoodsTableViewCell

- (IBAction)buyClick:(id)sender {
    
    NSLog(@"lala");
}

- (void)setContentWithModel:(GoodsModel *)model {
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"u58"]];
    
    self.titleLabel.text = model.title;
}




@end
