//
//  MusicControllerView.h
//  leiSure
//
//  Created by yuanhu on 16/6/20.
//  Copyright © 2016年 yuanhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicControllerView : UIView
@property (weak, nonatomic) IBOutlet UISlider *timerSlider;

@property (weak, nonatomic) IBOutlet UIButton *lastBtn;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIButton *playOrPause;




@end
