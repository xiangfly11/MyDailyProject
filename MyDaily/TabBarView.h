//
//  TabBarView.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBarView;
@protocol TabBarViewDelegate <NSObject>

@optional
-(void) tabBarView:(TabBarView *) tabBar didSelectedButtonFrom:(int) from to:(int) to;


@end

@interface TabBarView : UIView
-(void) addTabBarButtonWithItem:(UITabBarItem *) item;

@property (nonatomic,weak) id<TabBarViewDelegate> delegate;

@end
