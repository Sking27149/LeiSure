//
//  BaseCollectionViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseCollectionViewCell : UICollectionViewCell

//空间赋值的方法 父类空实现 具体交给子类
- (void)setContentWithModel:(BaseModel *)model;



@end
