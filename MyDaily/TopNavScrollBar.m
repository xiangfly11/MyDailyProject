//
//  TopNavScrollBar.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/10.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "TopNavScrollBar.h"
#import "NSString+Extension.h"
static const CGFloat btnGap = 20.0f;
static const CGFloat scrollHeight = 50.0f;
@interface TopNavScrollBar () {
    UIScrollView *_scrollView;
    NSArray *_itemsWidth;
    NSMutableArray *_btnXPostionArr;
    UIView *_underscoreLine;
}

@property (nonatomic,strong) UIButton *btn;

@end

@implementation TopNavScrollBar

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    
    return  self;

}


-(void) initConfig {
    _items = [[NSMutableArray alloc] init];
    _itemTitles = [NSArray array];
    _lineColor = [UIColor colorWithRed:238.0/255.0 green:99.0/255.0 blue:99.0/255.0 alpha:0.8];
    _itemColor = [UIColor clearColor];
    _btnXPostionArr = [[NSMutableArray alloc] init];
    
    [self viewConfig];
}

-(void) viewConfig {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, scrollHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
}


-(void) setupNavScrollBarWithItems:(NSArray *)itemsArr {
    _itemTitles = itemsArr;
    _itemsWidth = [self getItemsWidthWithItemTitles:_itemTitles];
    CGFloat btnXPosition = 5.0f;
    [_btnXPostionArr addObject:[NSNumber numberWithFloat:btnXPosition]];
    int i = 0;
    if (_itemsWidth.count) {
        for (NSNumber *btnWidth in _itemsWidth) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat width = [btnWidth floatValue];
            btn.frame = CGRectMake(btnXPosition, 5.0f, width+btnGap, 40);
            btn.backgroundColor = self.itemColor;
            [btn setTitle:self.itemTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                btn.selected = YES;
                self.btn = btn;
            }
            btn.tag = i + 200;
//            self.btn = btn;
            [_scrollView addSubview:btn];
            [self.items addObject:btn];
            
            btnXPosition += width + btnGap;
            [_btnXPostionArr addObject:[NSNumber numberWithFloat:btnXPosition]];
            
            i++;
        }
        
        [_scrollView setContentSize:CGSizeMake(btnXPosition, 0)];
    }
    
    [self showLineWithBtnWidth:[_itemsWidth[0] floatValue]];
    
    
}

-(void) setCurrentItemIndex:(NSInteger)currentItemIndex {
    _currentItemIndex = currentItemIndex;
    CGFloat flag = kScreenWidth - 40;
    
    CGFloat xPosiont = [_btnXPostionArr[_currentItemIndex] floatValue];
    CGFloat btnWidth = [_itemsWidth[_currentItemIndex] floatValue];
    if (xPosiont + btnWidth + 50 >= flag)
    {
        CGFloat offsetX = xPosiont + btnWidth - flag;
        if (_currentItemIndex < [_itemTitles count]-1)
        {
            offsetX = offsetX + btnWidth;
        }
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    }
    else
    {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    [UIView animateWithDuration:0.1f animations:^{
        _underscoreLine.frame = CGRectMake([_btnXPostionArr[_currentItemIndex] floatValue], 45.0 - 3, [_itemsWidth[_currentItemIndex] floatValue] + btnGap, 2.0f);
    }];
    
    UIButton *btn = self.items[currentItemIndex];
    btn.selected = YES;
    self.btn.selected = NO;
    [self.btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.btn = btn;
    [self.btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [self.btn setTitle:@"Hello" forState:UIControlStateSelected];
    
}


-(NSArray *) getItemsWidthWithItemTitles:(NSArray *) itemTitles {
    NSMutableArray *itemsWidth = [[NSMutableArray alloc] init];
    for (NSString *itemTitle in itemTitles) {
        CGSize maxSize = CGSizeMake(kScreenWidth, MAXFLOAT);
        CGSize realSize = [itemTitle sizeWithFont:[UIFont boldSystemFontOfSize:16.0f] maxSize:maxSize];
        
        [itemsWidth addObject:[NSNumber numberWithFloat:realSize.width]];
    }
    
    return itemsWidth;
}

-(void)  showLineWithBtnWidth:(CGFloat) width {
    _underscoreLine = [[UIView alloc] initWithFrame:CGRectMake([_btnXPostionArr[0] floatValue], 45.0 - 3.0, [_itemsWidth[0] floatValue] + btnGap, 2.0f)];
    _underscoreLine.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_underscoreLine];
    
}


-(void) selectedItem:(UIButton *) btn {
    
    if (self.selectedBlock) {
        self.selectedBlock(btn);
    }
    
    
}

@end
