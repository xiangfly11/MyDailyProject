//
//  TabBarButton.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/15.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "TabBarButton.h"

static const float tabbarButtonRatio = 0.6;

//default color for button title
#define tabbarButtonTitleColor [UIColor blackColor]
//selected color for button title
#define tabbarButtonTitleSelectedColor [UIColor colorWithRed:219/255.0f green:86/255.0f blue:85/255.0f alpha:1]


@implementation TabBarButton

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    //set up title and image aligment in button center
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:tabbarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:tabbarButtonTitleSelectedColor forState:UIControlStateSelected];
    }
    
    return self;
}

//This method is override
//set up image rect
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imagew = contentRect.size.width;
    CGFloat imageH = contentRect.size.height *tabbarButtonRatio;
    return CGRectMake(0, 0, imagew, imageH);
}

//this method is orverride
//set up title rect
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height *tabbarButtonRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


-(void)setItem:(UITabBarItem *)item
{
    _item = item;
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
