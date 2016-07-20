//
//  TopCarouselView.h
//  MyDaily
//
//  Created by 李嘉翔 on 6/27/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopCarouselViewDelegate <NSObject>

-(void) didSelectItemWithTag:(NSInteger) tag;

@end


@interface TopCarouselView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
//@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak,nonatomic) id<TopCarouselViewDelegate> delegate;

-(void) setTopNews:(NSArray *) topNewsArr;

@end
