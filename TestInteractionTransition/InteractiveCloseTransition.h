//
//  InteractiveCloseTransition.h
//  TestInteractionTransition
//
//  Created by Yannick Heinrich on 11/03/15.
//  Copyright (c) 2015 OpenWT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface InteractiveCloseTransition : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning>

@property(nonatomic, strong, readonly) UIPanGestureRecognizer * panGesture;

- (id) initWithViewController:(UIViewController*) viewController;
@end
