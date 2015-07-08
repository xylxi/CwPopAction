//
//  CwNavigationController.m
//  CwPopAction
//
//  Created by WangZHW on 15/7/7.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import "CwNavigationController.h"

@interface UINavigationController (UINavgationControllerNeedshouldPopItem)
/**
 *  为什么要在分类中定义一个UINavigationController实现
 *  UINavigationBarDelegate的协议方法，因为，我们不能通过
 *  super 去调用这个方法，因为实现协议，一般不会讲方法名放在
 *  .h文件中，所以我们无法用super调用，所以在分类中定义这个接口
 *  调用时候，自然在父类中找方法
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincomplete-implementation"
@implementation UINavigationController (UINavgationControllerNeedshouldPopItem)
@end
#pragma clang diagonstic pop

@interface CwNavigationController ()<UINavigationBarDelegate>

@end

@implementation CwNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    UIViewController *vc = self.topViewController;
    NSLog(@"class = %@",[vc class]);
    // 都会调用这个方法，如果连续两个页面都有这种处理，我们怎么办呢？？
    
    if (item != vc.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
    if ([vc conformsToProtocol:@protocol(CwNavigationControllerProtocol)])
    {
        if ([(id<CwNavigationControllerProtocol>)vc Cw_navigationControllershouldPopWhenSystemBackSelected:self])
        {
            return [super navigationBar:navigationBar shouldPopItem:item];
        }else{
            return NO;
        }
    }else{
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
}


@end
