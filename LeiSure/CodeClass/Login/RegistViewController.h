//
//  RegistViewController.h
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

typedef void(^registFinishBlock)(NSString *email, NSString *password);

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSeg;


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

//注册成功的block
@property (nonatomic, copy) registFinishBlock registOK;


@end
