//
//  CustomNavigationBar.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/21.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "CustomNavigationBar.h"
#import "DVSwitch.h"

@implementation CustomNavigationBar

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self createUI];
    }
    
    return self;
}


-(void) createUI {
    CGFloat width = self.frame.size.width;
    CGFloat yPosition = self.frame.origin.y;
    self.backgroundColor = [UIColor colorWithRed:246.0/255.0f green:246.0/255.0f blue:247.0/255.0f alpha:1];

    
    DVSwitch *switcher = [DVSwitch switchWithStringsArray:@[@"图片",@"视频"]];
    switcher.frame = CGRectMake(width/2 - 60, yPosition + 20, 120, 30);
    switcher.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:0.8];
    switcher.sliderColor = [UIColor redColor];
    self.switcher = switcher;
    switcher.labelTextColorInsideSlider = [UIColor whiteColor];
    switcher.labelTextColorOutsideSlider = [UIColor redColor];
    [self addSubview:switcher];
    
    [switcher setPressedHandler:^(NSUInteger index) {
        self.block (index);
    }];
    
}


-(void) setIndex:(NSUInteger)index {
    [self.switcher selectIndex:index animated:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
