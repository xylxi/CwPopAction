//
//  CwNavigationController.h
//  CwPopAction
//
//  Created by WangZHW on 15/7/7.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//  

#import <UIKit/UIKit.h>

@class CwNavigationController;

@protocol CwNavigationControllerProtocol <NSObject>

- (BOOL)Cw_navigationControllershouldPopWhenSystemBackSelected:(CwNavigationController *)navigationController;

@end

@interface CwNavigationController : UINavigationController


@end
