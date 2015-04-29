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
static inline void PrintViewHierachy(UIView * view, UIView * fromView, UIView* toView){
    
    NSString * frameName = @"Unknown View";
    for(UIView * subview in view.subviews)
    {
        if(subview == fromView)
            frameName = @"fromVC View";
        if(subview == toView)
            frameName = @"toVC View";
        
        NSLog(@"\t %@:%@", frameName, NSStringFromCGRect(subview.frame));
    }
};
@implementation MondeCloseTransition

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.9f;
}
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    //Screen Dimensions
    NSLog(@"Screen ===");
    NSLog(@"\tBounds:%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    NSLog(@"Controllers ====");
    //Basic container
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NSLog(@"\tFromVC:%@ - Frame:%@", NSStringFromClass(fromVC.class), NSStringFromCGRect(fromVC.view.frame));
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSLog(@"\ttoVC:%@ - Frame:%@", NSStringFromClass(fromVC.class), NSStringFromCGRect(fromVC.view.frame));
    
    
    //Initial Frame
    NSLog(@"Initial Frame ===");
    CGRect fromVCInitialFrame = [transitionContext initialFrameForViewController:fromVC];
    NSLog(@"\tFromVC:%@", NSStringFromCGRect(fromVCInitialFrame));
    
    CGRect toVCInitialFrame = [transitionContext initialFrameForViewController:toVC];
    NSLog(@"\ttoVC:%@", NSStringFromCGRect(toVCInitialFrame));
    
    //Final Frame
    NSLog(@"Final Frame ===");
    CGRect fromVCFinalFrame= [transitionContext finalFrameForViewController:fromVC];
    NSLog(@"\tFromVC:%@", NSStringFromCGRect(fromVCFinalFrame));
    
    CGRect toVCFinalFrame = [transitionContext finalFrameForViewController:toVC];
    NSLog(@"\ttoVC :%@", NSStringFromCGRect(toVCFinalFrame));
    
    
    //View Hierarchy
    NSLog(@"Container View =====");
    UIView * containerView = [transitionContext containerView];
    NSLog(@"\tFrame:%@", NSStringFromCGRect(containerView.frame));
    NSLog(@"View hierarchy Before =====");
    PrintViewHierachy(containerView, fromVC.view, toVC.view);

    //Basic container
    __block UIView * container = [transitionContext containerView];
        
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];

    [container addSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        
        CGRect fromVCRect = fromVC.view.frame;
        fromVC.view.frame = CGRectMake(0, CGRectGetHeight(fromVCRect), CGRectGetWidth(fromVCRect), CGRectGetHeight(fromVCRect));
        
    } completion:^(BOOL finished){

        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        [transitionContext completeTransition:finished];
        NSLog(@"View hierarchy After =====");
        PrintViewHierachy(containerView, fromVC.view, toVC.view);
    }];
    
}

@end
