//
//  MondeOpenTransition.m
//  PrivateBank
//
//  Created by Yannick Heinrich on 16/02/15.
//  Copyright (c) 2015 yageek
//  
//

#import "MondeOpenTransition.h"

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
@implementation MondeOpenTransition

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
    

    __block UIView *container = [transitionContext containerView];

    //froVC
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    //ToVC
    CGRect toVCFrame = [transitionContext finalFrameForViewController:toVC];
    CGFloat height = CGRectGetHeight(toVC.view.bounds);
    toVCFrame.origin.y = height;
    toVC.view.frame = toVCFrame;


    [container addSubview:toVC.view];
   
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    } completion:^(BOOL finished){
        
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        [transitionContext completeTransition:finished];
        
        NSLog(@"View hierarchy After =====");
        PrintViewHierachy(containerView, fromVC.view, toVC.view);
    }];
    
}
@end
