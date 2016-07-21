//
//  NewsDetailViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/21.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "HeadlineNews.h"

@interface NewsDetailViewController ()

@property (nonatomic,strong) UIWebView *webVeiw;

@end

@implementation NewsDetailViewController

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
    
}

-(void) configController {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.news.url]];
    [webView loadRequest:request];
    self.webVeiw = webView;
    [self.view addSubview:webView];
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
