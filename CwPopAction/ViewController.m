//
//  ViewController.m
//  CwPopAction
//
//  Created by WangZHW on 15/7/7.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import "ViewController.h"
#import "CwNavigationController.h"
#import "UINavigationController+CWShouldPopExtention.h"
@interface ViewController ()<UIAlertViewDelegate,
                  CwNavigationControllerProtocol,
                  UINavigationControllerShouldPop>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)Cw_navigationControllershouldPopWhenSystemBackSelected:(CwNavigationController *)navigationController{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前正在编辑的内容么？" delegate:self cancelButtonTitle:@"留在此页" otherButtonTitles:@"放弃编辑", nil];
    [al show];
    return NO;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationItem setHidesBackButton:YES];
        [self.navigationItem setHidesBackButton:NO];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前正在编辑的内容么？" delegate:self cancelButtonTitle:@"留在此页" otherButtonTitles:@"放弃编辑", nil];
    [al show];
    return NO;
}

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前正在编辑的内容么？" delegate:self cancelButtonTitle:@"留在此页" otherButtonTitles:@"放弃编辑", nil];
    [al show];
    return NO;
}
@end
