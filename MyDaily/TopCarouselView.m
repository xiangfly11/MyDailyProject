//
//  TopCarouselView.m
//  MyDaily
//
//  Created by 李嘉翔 on 6/27/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "TopCarouselView.h"
#import "TopNewsImage.h"
#import "TopImageView.h"


@interface TopCarouselView ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *newsArr;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) NSTimer *timer;
@end

@implementation TopCarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {

        _view = [[[NSBundle mainBundle] loadNibNamed:@"TopCarouselView" owner:self options:nil] firstObject];
        _view.frame = self.bounds;
        [self addSubview:_view];
        
        
        
        _scrollView.delegate = self;
        
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.f, self.view.frame.size.height - 20, kScreenWidth,20.f)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor greenColor];
        [self addSubview:_pageControl];
          

    }
    
    return self;
}


-(void) setTopNews:(NSArray *)topNewsArr {
    
    if (!topNewsArr) {
        return;
    }
    
    self.newsArr = [NSMutableArray arrayWithArray:topNewsArr];
    [self.newsArr insertObject:topNewsArr.lastObject atIndex:0];
    [self.newsArr addObject:topNewsArr.firstObject];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * self.newsArr.count, topCarouselViewHeight);
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = topNewsArr.count;

    

    UIView *lastTopImageView = nil;
    
    for (int i = 0; i < self.newsArr.count; i++) {
        TopNewsImage *news = self.newsArr[i];
        TopImageView *topImageView = [TopImageView new];
        [self.scrollView addSubview:topImageView];
        [topImageView.imageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
//        NSLog(@"image url:%@",news.imgsrc);
        
        NSAttributedString *titleStrAttr = [[NSAttributedString alloc] initWithString:news.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        CGSize size = [titleStrAttr boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  context:nil].size;
        topImageView.titleLabel.frame = CGRectMake(15, 180, kScreenWidth-30,size.height);
       
        topImageView.titleLabel.attributedText = titleStrAttr;
        topImageView.titleLabel.textAlignment = NSTextAlignmentCenter;
        [topImageView.titleLabel setTextColor:[UIColor grayColor]];
        
        [topImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [topImageView setTag:i+100];
        
        [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.scrollView.mas_height);
            make.width.mas_equalTo(kScreenWidth);
            make.top.equalTo(self.scrollView.mas_top);
            
            if (lastTopImageView) {
                make.left.equalTo(lastTopImageView.mas_right);
            }else {
                make.left.equalTo(self.scrollView.mas_left);
            }
        }];
        
        lastTopImageView = topImageView;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(displayNextStory) userInfo:nil repeats:YES];
    
}

#pragma mark -- Scroll View Delegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (offsetX == (_newsArr.count-1)* kScreenWidth) {
        _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        self.pageControl.currentPage = 0;
    }else if (offsetX == 0) {
        _scrollView.contentOffset = CGPointMake((_newsArr.count - 2) *kScreenWidth, 0);
        self.pageControl.currentPage = _newsArr.count - 2;
    }else {
        self.pageControl.currentPage = offsetX / kScreenWidth -1;
    }
}


-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.0f]];
}


-(void) tap:(UIGestureRecognizer *) recognizer {
    [self.delegate didSelectItemWithTag:recognizer.view.tag];
}


-(void) displayNextStory {
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + kScreenWidth, 0)];
}

@end
