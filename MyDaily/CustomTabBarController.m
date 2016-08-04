//
//  CustomTabBarController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "CustomTabBarController.h"
#import "TabBarView.h"
#import "CustomNavigationViewController.h"
#import "NewsNavViewController.h"
#import "VideoViewController.h"
#import "GalleryViewController.h"
#import "SettingViewController.h"
#import "MediaViewController.h"
//#import "DailyInforViewController.h"
#import "HotArticlesViewController.h"

@interface CustomTabBarController ()<TabBarViewDelegate>

@property (nonatomic,strong) TabBarView *tabBarView;
@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTabView];
    [self initController];
    
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) createTabView {
    TabBarView *tabBarView = [[TabBarView alloc] init];
    tabBarView.frame = self.tabBar.bounds;
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
    self.tabBarView = tabBarView;
    
    
}


-(void) tabBarView:(TabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}

-(void) initController {
    NewsNavViewController *newsController = [[NewsNavViewController alloc] init];
    [self setupChildViewController:newsController title:@"新闻" imageName:@"tabbar_news" selectedImage:@"tabbar_news_hl"];
    MediaViewController *mediaController = [[MediaViewController alloc] init];
    [self setupChildViewController:mediaController title:@"媒体" imageName:@"tabbar_picture" selectedImage:@"tabbar_picture_hl"];
//
//    DailyInforViewController *dailyInfroViewController = [[DailyInforViewController alloc] init];
//    [self setupChildViewController:dailyInfroViewController title:@"每日助手" imageName:@"tabbar_video"  selectedImage:@"tabbar_video_hl"];
    
    HotArticlesViewController *dailyInfroViewController = [[HotArticlesViewController alloc] init];
    [self setupChildViewController:dailyInfroViewController title:@"热读" imageName:@"tabbar_video"  selectedImage:@"tabbar_video_hl"];
    SettingViewController *settingController = [[SettingViewController alloc] init];
    [self setupChildViewController:settingController title:@"设置" imageName:@"tabbar_setting"  selectedImage:@"tabbar_setting_hl"];
    
}


-(void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage
{
    
    //set tab bar proerty
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //create customer navigation view controller
    CustomNavigationViewController *nav = [[CustomNavigationViewController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    [self.tabBarView addTabBarButtonWithItem:childVc.tabBarItem];
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
