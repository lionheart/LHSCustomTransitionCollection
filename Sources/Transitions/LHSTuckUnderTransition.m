//
//  LHSTuckUnderTransition.m
//  LHSCustomTransitionCollection
//
//  Created by Dan Loewenherz on 1/5/14.
//  Copyright (c) 2014 Lionheart Software LLC. All rights reserved.
//

#import "LHSTuckUnderTransition.h"
#import "LHSTuckUnderAnimator.h"

@implementation LHSTuckUnderTransition

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LHSTuckUnderAnimator *animator = [LHSTuckUnderAnimator new];
    animator.reverse = YES;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [LHSTuckUnderAnimator new];
}

@end
