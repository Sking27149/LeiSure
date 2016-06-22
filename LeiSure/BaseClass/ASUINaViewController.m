//
//  ASUINaViewController.m
//  LeiSure
//
//  Created by lanou on 16/6/18.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ASUINaViewController.h"

@interface ASUINaViewController ()

@end

@implementation ASUINaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"u9_start"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
        
        
        viewController.navigationItem.leftBarButtonItem = item;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
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
