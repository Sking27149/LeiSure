//
//  RegistViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/21.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)sexSegment:(id)sender {
}

- (IBAction)confirmBtn:(id)sender {
    //获取用户输入的数据
    NSDictionary *paras = @{@"email" : self.emailTextField.text, @"passwd" : self.passwordTextField.text, @"uname" : self.nameTextField.text, @"gender" : @(self.sexSeg.selectedSegmentIndex)};
    
    //请求注册接口
    [ASRequestTool requestWithType:POST URLString:REGIST_URL Parameter:paras callBack:^(NSData *data, NSError *error) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSLog(@"%@", jsonDic);
        
//        NSNumber *result = jsonDic[@"data"][@"msg"];
        
        NSNumber *result = jsonDic[@"result"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result.intValue == 0) {
                //注册失败
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:jsonDic[@"data"][@"msg"] preferredStyle:(UIAlertControllerStyleAlert)];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"重试" style:(UIAlertActionStyleDefault) handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }else {
                //注册成功
                if (self.registOK) {
                    self.registOK(self.emailTextField.text, self.passwordTextField.text);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
        
        
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
