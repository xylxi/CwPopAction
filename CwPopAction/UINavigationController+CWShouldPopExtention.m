
//
//  UINavigationController+CWShouldPopExtention.m
//  CwPopAction
//
//  Created by WangZHW on 15/7/7.
//  Copyright (c) 2015年 RobuSoft. All rights reserved.
//

#import "UINavigationController+CWShouldPopExtention.h"
#import <objc/runtime.h>

static NSString *const kOriginDelegate = @"kOriginDelegate";

@implementation UINavigationController (CWShouldPopExtention)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        //
        SEL originalSelector = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSelector = @selector(cw_navigationBar:shouldPopItem:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        SEL originalSelectorTwo = @selector(viewDidLoad);
        SEL swizzledSelectorTwo = @selector(cw_viewDidLoad);
        
        Method originalMethodTwo = class_getInstanceMethod(class, originalSelectorTwo);
        Method swizzledMethodTwo = class_getInstanceMethod(class, swizzledSelectorTwo);
        
        didAddMethod =
        class_addMethod(class,
                        originalSelectorTwo,
                        method_getImplementation(swizzledMethodTwo),
                        method_getTypeEncoding(swizzledMethodTwo));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelectorTwo,
                                method_getImplementation(originalMethodTwo),
                                method_getTypeEncoding(originalMethodTwo));
        }else{
            method_exchangeImplementations(originalMethodTwo, swizzledMethodTwo);
        }
    });
}

- (void)cw_viewDidLoad{
    [self cw_viewDidLoad];
    
    NSLog(@"before = %@",self.interactivePopGestureRecognizer.delegate);
    // 使用关联对象来保存以前的代理
    objc_setAssociatedObject(self, [kOriginDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    // 将手势的代理设置为当前的navigationController
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    NSLog(@"after  = %@",self.interactivePopGestureRecognizer.delegate);
    
}

- (BOOL)cw_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    UIViewController *vc = self.topViewController;
    if (item != vc.navigationItem) {
        return YES;
    }
    if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
        if ([(id<UINavigationControllerShouldPop>)vc navigationControllerShouldPop:self]) {
            return [self cw_navigationBar:navigationBar shouldPopItem:item];
        }else{
            return NO;
        }
    }else{
        return [self cw_navigationBar:navigationBar shouldPopItem:item];
    }
}


#pragma mark - 手势的代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if ([vc conformsToProtocol:@protocol(UINavigationControllerShouldPop)]) {
            if (![(id<UINavigationControllerShouldPop>)vc navigationControllerShouldStartInteractivePopGestureRecognizer:self]) {
                return NO;
            }
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}
@end
