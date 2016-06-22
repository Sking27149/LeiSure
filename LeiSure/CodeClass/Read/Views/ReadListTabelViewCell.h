//
//  ReadListTabelViewCell.h
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ReadRealListModel.h"

@interface ReadListTabelViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end
