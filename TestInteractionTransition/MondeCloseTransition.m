//
//  MondeCloseTransition.m
//  PrivateBank
//
//  Created by Yannick Heinrich on 18/02/15.
//  Copyright (c) 2015 yageek
//  
//

#import "MondeCloseTransition.h"
#define SCALE_FACTOR 0.5f

@implementation MondeCloseTransition

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.9f;
}
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //Basic container
    __block UIView * container = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    toVC.view.transform = CGAffineTransformMakeScale(SCALE_FACTOR, SCALE_FACTOR);

    [container addSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        
        CGRect fromVCRect = fromVC.view.frame;
        fromVC.view.frame = CGRectMake(0, CGRectGetHeight(fromVCRect), CGRectGetWidth(fromVCRect), CGRectGetHeight(fromVCRect));
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished){

        [transitionContext completeTransition:finished];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.transform = CGAffineTransformIdentity;
    }];
    
}

@end
