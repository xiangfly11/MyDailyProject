//
//  DropDownTransitionController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/20.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "DropDownTransitionController.h"

@implementation DropDownTransitionController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.5;
}

// 转场动画实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 通过 key 取到 fromVC 和 toVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 把 toVC 加入到 containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    // 一些动画要用的的数据
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 动画过程
    if (toVC.isBeingPresented) {
        toVC.view.frame = CGRectOffset(finalFrame, 0, -finalFrame.size.height);

        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:10.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            toVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    
    if (fromVC.isBeingDismissed) {
        [containerView sendSubviewToBack:toVC.view];
        [UIView animateWithDuration:duration
                         animations:^{
                             fromVC.view.frame = CGRectOffset(finalFrame, 0, -finalFrame.size.height);
                         }
                         completion:^(BOOL finished) {
                             // dismiss 动画添加了手势后可能出现转场取消的状态，所以要根据状态来判定是否完成转场
                             BOOL isComplete = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:isComplete];
                         }];
    }
    
}


@end
