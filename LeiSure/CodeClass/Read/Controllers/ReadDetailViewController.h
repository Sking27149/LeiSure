//
//  ReadDetailViewController.h
//  LeiSure
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadRealListModel.h"
@interface ReadDetailViewController : UIViewController


@property (nonatomic, copy) NSString *contentid;

@property (nonatomic, strong) ReadRealListModel *model;

@end
