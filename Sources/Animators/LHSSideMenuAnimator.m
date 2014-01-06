//
//  LHSSideMenuAnimator.m
//  LHS Custom Transition Collection
//
//  Created by Dan Loewenherz on 12/28/13.
//  Copyright (c) 2013 Lionheart Software LLC. All rights reserved.
//

#import "LHSSideMenuAnimator.h"
#import "LHSSideMenuTransition.h"
#import <UIKit/UIKit.h>

@implementation LHSSideMenuAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:fromViewController.view];
    [containerView addSubview:toViewController.view];
    
    UIView *fromViewSnapshot = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    __unused UIView *toViewSnapshot = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    UIView *snapshotView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];

    UIViewController<LHSSideMenuDelegate> *sideMenuViewController;
    toViewController.view.frame = containerView.bounds;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1 / -500.;
    
    // Rotate on Y-axis
    transform = CATransform3DRotate(transform, - M_PI / 32, 0, 1, 0);
    
    // Scale on Y-axis
    transform.m22 = 0.8;
    
    // Scale on X-axis
    transform.m11 = 0.8;
    
    // Translate on X-axis
    transform.m41 = 260;
    
    void (^AnimationBlock)();
    void (^CompletionBlock)(BOOL finished);
    
    if (self.reverse) {
        fromViewSnapshot.clipsToBounds = YES;
        
        sideMenuViewController = (UIViewController<LHSSideMenuDelegate> *)fromViewController;
        UIView *rightSnapshotView = sideMenuViewController.rightSnapshotView;
        [containerView addSubview:rightSnapshotView];
        rightSnapshotView.frame = containerView.frame;
        rightSnapshotView.layer.transform = transform;
        rightSnapshotView.clipsToBounds = YES;
        
        // Replace the menu with the carbon copy of it
        fromViewSnapshot.frame = fromViewController.view.frame;
        [containerView addSubview:fromViewSnapshot];
        [fromViewController.view removeFromSuperview];
        
        // Set the converted coordinates to the toViewController's view's frame
        toViewController.view.hidden = YES;
        toViewController.view.frame = containerView.frame;
        toViewController.view.clipsToBounds = YES;
        
        AnimationBlock = ^{
            rightSnapshotView.layer.transform = CATransform3DIdentity;
            rightSnapshotView.frame = containerView.frame;
            
            fromViewSnapshot.frame = CGRectMake(-260, 0, 260, CGRectGetHeight(containerView.bounds));
        };
        
        CompletionBlock = ^(BOOL finished) {
            toViewController.view.hidden = NO;
            [rightSnapshotView removeFromSuperview];
            
            if (finished) {
                [transitionContext completeTransition:YES];
            }
        };
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:0
                         animations:AnimationBlock
                         completion:CompletionBlock];
    }
    else {
        
        fromViewController.view.hidden = YES;
        [fromViewController.view removeFromSuperview];
        
        [containerView addSubview:snapshotView];
        snapshotView.layer.transform = CATransform3DIdentity;
        snapshotView.frame = containerView.bounds;
        
        sideMenuViewController = (UIViewController<LHSSideMenuDelegate> *)toViewController;
        sideMenuViewController.view.layer.shadowOffset = CGSizeMake(0, 0);
        sideMenuViewController.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        sideMenuViewController.view.layer.shadowOpacity = 1;
        sideMenuViewController.view.frame = CGRectMake(-260, 0, 260, CGRectGetHeight(containerView.bounds));
        
        [containerView bringSubviewToFront:sideMenuViewController.view];
        containerView.backgroundColor = [UIColor darkGrayColor];
        
        CompletionBlock = ^(BOOL finished) {
            if (finished) {
                [sideMenuViewController setNeedsStatusBarAppearanceUpdate];
                [transitionContext completeTransition:YES];
                
                CGRect newFrame = [containerView convertRect:containerView.bounds toView:sideMenuViewController.view];
                [snapshotView removeFromSuperview];
                snapshotView.frame = newFrame;
                snapshotView.layer.transform = transform;
                
                [sideMenuViewController.view addSubview:snapshotView];
                sideMenuViewController.rightSnapshotView = snapshotView;
            }
        };
        
        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext]
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        sideMenuViewController.view.frame = CGRectMake(0, 0, 250, CGRectGetHeight(containerView.frame));
                                                                    }];
                                      
                                      /*
                                       [UIView addKeyframeWithRelativeStartTime:0
                                       relativeDuration:0.2
                                       animations:^{
                                       CATransform3D transform = CATransform3DIdentity;
                                       transform.m34 = 1 / -500.;
                                       
                                       // Translate on X-axis
                                       transform.m41 = 30;
                                       
                                       // Rotate on Y-axis
                                       transform = CATransform3DRotate(transform, - M_PI / 64, 0, 1, 0);
                                       
                                       // Scale on Y-axis
                                       transform.m22 = 0.96;
                                       
                                       // Scale on X-axis
                                       transform.m11 = 0.96;
                                       
                                       snapshotView.layer.transform = transform;
                                       }];
                                       */
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.4
                                                                    animations:^{
                                                                        CATransform3D transform = CATransform3DIdentity;
                                                                        transform.m34 = 1 / -500.;
                                                                        
                                                                        // Rotate on Y-axis
                                                                        transform = CATransform3DRotate(transform, - M_PI / 30, 0, 1, 0);
                                                                        
                                                                        // Scale on Y-axis
                                                                        transform.m22 = 0.76;
                                                                        
                                                                        // Scale on X-axis
                                                                        transform.m11 = 0.76;
                                                                        
                                                                        // Translate on X-axis
                                                                        transform.m41 = 262;
                                                                        
                                                                        snapshotView.layer.transform = transform;
                                                                    }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.4
                                                              relativeDuration:0.4
                                                                    animations:^{
                                                                        CATransform3D transform = CATransform3DIdentity;
                                                                        transform.m34 = 1 / -500.;
                                                                        
                                                                        // Rotate on Y-axis
                                                                        transform = CATransform3DRotate(transform, - M_PI / 32, 0, 1, 0);
                                                                        
                                                                        // Scale on Y-axis
                                                                        transform.m22 = 0.8;
                                                                        
                                                                        // Scale on X-axis
                                                                        transform.m11 = 0.8;
                                                                        
                                                                        // Translate on X-axis
                                                                        transform.m41 = 260;
                                                                        snapshotView.layer.transform = transform;
                                                                    }];
                                  }
                                  completion:CompletionBlock];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

@end
