//
//  LHSSideMenuTransition.h
//  LHS Custom Transition Collection
//
//  Created by Dan Loewenherz on 12/28/13.
//  Copyright (c) 2013 Lionheart Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LHSSideMenuDelegate <NSObject>

@required

@property (nonatomic, strong) UIView *rightSnapshotView;

@end

@interface LHSSideMenuTransition : NSObject <UIViewControllerTransitioningDelegate>

@end
