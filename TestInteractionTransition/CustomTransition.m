//
//  CustomTransition.m
//  TestInteractionTransition
//
//  Created by Yannick Heinrich on 11/03/15.
//  Copyright (c) 2015 OpenWT. All rights reserved.
//

#import "CustomTransition.h"
#import "MondeOpenTransition.h"
#import "MondeCloseTransition.h"
#import "InteractiveCloseTransition.h"
@interface CustomTransition() <UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) InteractiveCloseTransition * closeTransition;
@end
@implementation CustomTransition
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
    
        self.modalPresentationStyle = UIModalPresentationPopover;
        NSLog(@"Modal Presentation Style of:%@", NSStringFromClass(self.class));
        self.transitioningDelegate = self;
    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    _closeTransition =[[InteractiveCloseTransition alloc] initWithViewController:self];
}
- (IBAction)click:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[MondeOpenTransition alloc] init];
}
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//    return [[MondeCloseTransition alloc] init];
//}
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//    return _closeTransition;
//}
@end
