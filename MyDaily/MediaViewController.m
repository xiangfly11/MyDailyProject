//
//  MediaViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/21.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "MediaViewController.h"
#import "CustomNavigationBar.h"
#import "GalleryViewController.h"
#import "VideoViewController.h"

@interface MediaViewController ()<UIScrollViewDelegate> {
    NSUInteger _currentIndex;
}

@property (nonatomic,strong) CustomNavigationBar *navBar;
@property (nonatomic,strong) UIScrollView *mainView;
@property (nonatomic,strong) NSMutableArray *controllerArray;
@end

@implementation MediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initController];
    [self configController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) initController {
    _controllerArray = [NSMutableArray array];
    
    
}


-(void) configController {
    self.navigationController.navigationBar.hidden = YES;
    CustomNavigationBar *navBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationBarHeight)];
    self.navBar = navBar;
    [self.view addSubview:navBar];
    __weak __typeof(self) weakSelf = self;
    self.navBar.block = ^(NSUInteger index) {
        [weakSelf changeViewController:index];
    };
    
    
    GalleryViewController *galleryViewController = [[GalleryViewController alloc] init];
    [_controllerArray addObject:galleryViewController];
    VideoViewController *videoViewController = [[VideoViewController alloc] init];
    [_controllerArray addObject:videoViewController];
    
    [self initMainView];

}


-(void) initMainView {
    _mainView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, navigationBarHeight, kScreenWidth, kScreenHeight - navigationBarHeight)];
    _mainView.pagingEnabled = YES;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.delegate = self;
    _mainView.contentSize = CGSizeMake(kScreenWidth * self.controllerArray.count, 0);
    [self.view addSubview:_mainView];
    
    UIViewController *mainViewController = (UIViewController *) self.controllerArray[0];
    mainViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_mainView addSubview:mainViewController.view];
    [self addChildViewController:mainViewController];
    
}


-(void) changeViewController:(NSUInteger) index {
    [_mainView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
}


#pragma mark -- UIScrollViewDelegate 

-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentIndex = scrollView.contentOffset.x / kScreenWidth;
    [self.navBar setIndex:_currentIndex];
    
    
    UIViewController *viewController = (UIViewController *)self.controllerArray[_currentIndex];
    viewController.view.frame = CGRectMake(_currentIndex * kScreenWidth, 0, kScreenWidth, _mainView.frame.size.height);
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
