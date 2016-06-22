//
//  ReadTypeCollectionCell.h
//  LeiSure
//
//  Created by lanou on 16/6/15.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "ReadListModel.h"
@interface ReadTypeCollectionCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
