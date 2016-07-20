//
//  TabBarView.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarButton.h"

@interface TabBarView ()

@property (nonatomic,strong) TabBarButton *btn;
@property (nonatomic,strong) TabBarButton *selectedBtn;

@end

@implementation TabBarView

-(void) addTabBarButtonWithItem:(UITabBarItem *)item {
    TabBarButton *btn = [[TabBarButton alloc] init];
    btn.item = item;
    [self addSubview:btn];
    self.btn = btn;
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (self.subviews.count == 1) {
        [self clickBtn:btn];
    }
}

-(void) clickBtn:(TabBarButton *) btn {
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBarView:self didSelectedButtonFrom:(int)self.selectedBtn.tag to:(int)btn.tag];
    }
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}


-(void) layoutSubviews {
    CGFloat width = self.frame.size.width / self.subviews.count;
    CGFloat height = self.frame.size.height;
    CGFloat yPosition = 0;
    
    for (int i = 0; i < self.subviews.count; i ++) {
        TabBarButton *btn = self.subviews[i];
        btn.frame = CGRectMake(width * i, yPosition, width, height);
        btn.tag = i;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
