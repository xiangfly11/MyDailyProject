//
//  CustomNavigationBar.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/21.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DVSwitch;

typedef void(^SwitcherBlock)(NSUInteger index);
@interface CustomNavigationBar : UIView

@property (nonatomic,strong) DVSwitch *switcher;
@property (nonatomic,strong) SwitcherBlock block;
@property (nonatomic,assign) NSUInteger index;


@end
