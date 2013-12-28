//
//  LHSSideMenuTransition.m
//  LHS Custom Transition Collection
//
//  Created by Dan Loewenherz on 12/28/13.
//  Copyright (c) 2013 Lionheart Software LLC. All rights reserved.
//

#import "LHSSideMenuTransition.h"
#import "LHSSideMenuAnimator.h"

@implementation LHSSideMenuTransition

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LHSSideMenuAnimator *animator = [LHSSideMenuAnimator new];
    animator.reverse = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [LHSSideMenuAnimator new];
}

@end
