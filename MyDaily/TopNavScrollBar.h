//
//  TopNavScrollBar.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/10.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopNavScrollBarDelegate <NSObject>

-(void) didSelectBtn:(UIButton *) btn;

@end


typedef void(^btnSelectedBlock)(UIButton *btn);


@interface TopNavScrollBar : UIView

/* The block to send message when the button is clicked */
@property (nonatomic,strong) btnSelectedBlock selectedBlock;

@property (nonatomic,weak) id<TopNavScrollBarDelegate> delegate;

@property (nonatomic,strong) NSArray *itemTitles; //A set of NSString items of titles
@property (nonatomic,strong) UIColor *itemColor;  //Background color of button
@property (nonatomic,strong) NSMutableArray *items; //A set of UIButtons
@property (nonatomic,strong) UIColor *lineColor; //Color of underscore line
@property (nonatomic,assign) NSInteger currentItemIndex;

-(instancetype) initWithFrame:(CGRect)frame;
-(void) setupNavScrollBarWithItems:(NSArray *) itemsArr;

@end
