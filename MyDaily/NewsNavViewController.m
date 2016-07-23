//
//  HomeViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 6/28/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "NewsNavViewController.h"
#import "TopCarouselView.h"
#import "TopNewsImageModel.h"
#import "TopNavScrollBar.h"
#import "TopButtonsTitleModel.h"
#import "NewsViewController.h"


// URL to request top carousel images
static NSString *const urlStr = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html";


@interface NewsNavViewController ()<UIScrollViewDelegate> {
    TopCarouselView *_topCarouselView;
    TopNavScrollBar *_topNavScrollBar;
    
    //scroll view which will contain different categories of news
    UIScrollView *_mainView;
    
    //index to indicate which kind of news is selected
    NSInteger _currentItemIndex;
}

// a set of TopNewsImageModel objects 
@property (nonatomic,strong) NSMutableArray *topImagesArr;

// a set of titles of news
@property (nonatomic,strong) NSArray *topButtonTitles;

// a set of view controllers to show different categories of news
@property (nonatomic,strong) NSArray *subViewControllers;

// a set of NSString to indicate diffent content in different news categories
@property (nonatomic,strong) NSArray *contentArr;
@end

@implementation NewsNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initController];
    
    //figure out scroll view content offset (-20)
    self.automaticallyAdjustsScrollViewInsets = NO;
}


-(void) viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initController {
    _topButtonTitles = @[@"头条",@"国内",@"国际",@"娱乐",@"体育",@"科技",@"奇闻趣事",@"生活健康"];
    _contentArr = @[@"guonei",@"world",@"huabian",@"tiyu",@"keji",@"qiwen",@"health"];
    _topImagesArr = [NSMutableArray array];
    _subViewControllers = [NSArray array];
    [self requestDataWithUrlStr: urlStr];
}

-(void) createTopViews {
    _topCarouselView = [[TopCarouselView alloc] initWithFrame:CGRectMake(0, navigationBarHeight, kScreenWidth, topCarouselViewHeight)];
  
    [_topCarouselView setTopNews:self.topImagesArr];
    [self.view addSubview:_topCarouselView];
    
    _topNavScrollBar = [[TopNavScrollBar alloc] initWithFrame:CGRectMake(0, topCarouselViewHeight + navigationBarHeight, kScreenWidth, topScrollButtonsViewHeight)];
    [_topNavScrollBar setupNavScrollBarWithItems:_topButtonTitles];
    __weak __typeof(self) weakSelf = self;
    _topNavScrollBar.selectedBlock = ^(UIButton *btn) {
        [weakSelf selectedBtn:btn];
    };

    [self.view addSubview:_topNavScrollBar];
    
    NSMutableArray *viewsArr = [NSMutableArray array];
    for (int i = 0; i < self.topButtonTitles.count; i ++) {
        NewsViewController *viewController = [[NewsViewController alloc] init];
        viewController.title = _topButtonTitles[i];
        if (i != 0) {
            viewController.content = self.contentArr[i - 1];
        }
        [viewsArr addObject:viewController];
    }
    _subViewControllers = viewsArr;
    
    [self createMainView];
}

-(void) createMainView {
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topCarouselViewHeight + topScrollButtonsViewHeight + navigationBarHeight, kScreenWidth, kScreenHeight - topCarouselViewHeight - topScrollButtonsViewHeight - navigationBarHeight)];
    _mainView.pagingEnabled = YES;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.delegate = self;
    _mainView.contentSize = CGSizeMake(kScreenWidth * _subViewControllers.count, 0);
    [self.view addSubview:_mainView];
    
    UIViewController *mainViewController = (UIViewController *) _subViewControllers[0];
    mainViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - topCarouselViewHeight - topScrollButtonsViewHeight);
    [_mainView addSubview:mainViewController.view];
    [self addChildViewController:mainViewController];
}


-(void) requestDataWithUrlStr:(NSString *) urlStr {
//    NSMutableArray *topNews = [NSMutableArray array];
    
    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlStr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
        [self fetchData:object];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error.localizedDescription);
    } progress:nil];
    
   
}


-(void) fetchData:(NSDictionary *) object {
    NSArray *response = [TopNewsImageModel mj_objectArrayWithKeyValuesArray:object[@"T1348647853363"][0][@"ads"]];
    
    for (TopNewsImageModel *news in response) {
        [self.topImagesArr addObject:news];
    }
    
    [self createTopViews];

}

-(void) selectedBtn:(UIButton *) btn {
    NSInteger tag = btn.tag - 200;
    [self setCurrentItemIndex:tag];
}


-(void) setCurrentItemIndex:(NSInteger) index {
    [_mainView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
    
}


#pragma mark -- UIScrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentItemIndex = scrollView.contentOffset.x / kScreenWidth;
    NSLog(@"Index: %ld", _currentItemIndex);
    [_topNavScrollBar setCurrentItemIndex:_currentItemIndex];
    
    UIViewController *viewController = (UIViewController *)_subViewControllers[_currentItemIndex];
    viewController.view.frame = CGRectMake(_currentItemIndex * kScreenWidth, 0, kScreenWidth, _mainView.frame.size.height);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
