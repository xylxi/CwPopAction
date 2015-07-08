//
//  UINavigationController+CWShouldPopExtention.h
//  CwPopAction
//
//  Created by WangZHW on 15/7/7.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;
- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end
@interface UINavigationController (CWShouldPopExtention)

@end
