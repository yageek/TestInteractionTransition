//
//  InteractiveCloseTransition.m
//  TestInteractionTransition
//
//  Created by Yannick Heinrich on 11/03/15.
//  Copyright (c) 2015 OpenWT. All rights reserved.
//

#import "InteractiveCloseTransition.h"
#define ZOOM_OUT_DURATION 0.3f
#define SLIDE_TRANSITION 0.4f
#define SLIDE_TRANSITION_DELAY 0.3f

#define ANIMATION_TOTAL (ZOOM_OUT_DURATION + SLIDE_TRANSITION + SLIDE_TRANSITION_DELAY)

#define SCALE_FACTOR 0.9f
@interface InteractiveCloseTransition()

@property(nonatomic, strong) UIPanGestureRecognizer * panGesture;
@property(nonatomic, assign) UIViewController * controller;
@end
@implementation InteractiveCloseTransition

- (id) initWithViewController:(UIViewController*) viewController
{
    if(self = [super init])
    {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureTriggered:)];
        [viewController.view addGestureRecognizer:_panGesture];
        
        _controller = viewController;
        
    }
    return self;
}



-(void) panGestureTriggered:(UIPanGestureRecognizer* ) gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.controller dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percent = ABS([gesture locationInView:gesture.view.superview].y/CGRectGetHeight(gesture.view.bounds));
            NSLog(@"Update:%f", percent);
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ANIMATION_TOTAL;
}
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //Basic container

    //Basic container
    UIView * containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    
    CGAffineTransform tr = toVC.view.transform;
    toVC.view.transform = CGAffineTransformScale(tr, SCALE_FACTOR, SCALE_FACTOR);
    
    [containerView addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        
        CGRect fromVCRect = fromVC.view.frame;
        fromVC.view.frame = CGRectMake(0, CGRectGetHeight(fromVCRect), CGRectGetWidth(fromVCRect), CGRectGetHeight(fromVCRect));
        toVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished){
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.transform = CGAffineTransformIdentity;
    }];
    

}


@end
