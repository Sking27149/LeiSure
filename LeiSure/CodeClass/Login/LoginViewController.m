//
//  LoginViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//登录方法
- (IBAction)loginBtn:(id)sender {
    //请求登录接口
    [ASRequestTool requestWithType:POST URLString:LOGIN_URL Parameter:@{@"email" : self.loginTextField.text, @"passwd" : self.passwordTextField.text} callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        NSLog(@"%@", jsonDic);
        
        NSNumber *result = jsonDic[@"result"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result.intValue == 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:jsonDic[@"data"][@"msg"] preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"重试" style:(UIAlertActionStyleDefault) handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else {
                //立即保存
                [[NSUserDefaults standardUserDefaults] setObject:jsonDic[@"data"] forKey:@"user"];
                
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                //回到之前的页面
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        });
    }];
}

- (IBAction)backVC:(id)sender {
    //返回之前的控制器
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RegistViewController *registVC = [segue destinationViewController];
    
    registVC.registOK = ^(NSString *email, NSString *password) {
        self.loginTextField.text = email;
        self.passwordTextField.text = password;
    };
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
