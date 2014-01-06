//
//  LHSTuckUnderAnimator.m
//  LHSCustomTransitionCollection
//
//  Created by Dan Loewenherz on 1/5/14.
//  Copyright (c) 2014 Lionheart Software LLC. All rights reserved.
//

#import "LHSTuckUnderAnimator.h"
#import <UIKit/UIKit.h>

@implementation LHSTuckUnderAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];
    
    fromViewController.view.frame = containerView.frame;
    toViewController.view.frame = containerView.frame;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1 / -500.;
    
    // Rotate on Y-axis
    transform = CATransform3DRotate(transform, - M_PI / 32, 0, 1, 0);
    
    // Scale on Y-axis
    transform.m22 = 0.8;
    
    // Scale on X-axis
    transform.m11 = 0.8;
    
    // Translate on X-axis
    transform.m41 = 0;
    
    CATransform3D translateTransform = CATransform3DIdentity;
    translateTransform.m41 = -300;
    
    if (self.reverse) {
        toViewController.view.frame = CGRectOffset(containerView.frame, -CGRectGetWidth(containerView.frame), 0);
        [containerView bringSubviewToFront:toViewController.view];

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toViewController.view.frame = containerView.frame;
                             fromViewController.view.layer.transform = transform;
                         }
                         completion:^(BOOL finished) {
                             [fromViewController.view removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    }
    else {
        [containerView bringSubviewToFront:fromViewController.view];
        toViewController.view.layer.transform = transform;
        fromViewController.view.frame = containerView.frame;

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toViewController.view.layer.transform = CATransform3DIdentity;
                             fromViewController.view.frame = CGRectOffset(containerView.frame, -CGRectGetWidth(containerView.frame), 0);
                         }
                         completion:^(BOOL finished) {
                             [fromViewController.view removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}


@end
