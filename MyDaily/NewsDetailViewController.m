//
//  NewsDetailViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/21.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "NewsDetailViewController.h"
#import "NewsModel.h"

@interface NewsDetailViewController ()

//@property (nonatomic,strong) UIWebView *webVeiw;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initController];
    [self createWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidDisappear:(BOOL)animated {
//    [self.webVeiw removeFromSuperview];
//    self.webVeiw = nil;
}

-(void) dealloc {
//    [self.webVeiw removeFromSuperview];
//    self.webVeiw = nil;
}
-(void) initController {
    
}

-(void) createWebView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.news.url]];
//    [webView loadRequest:request];
//    self.webVeiw = webView;
    
    [webView loadRequest:request];
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
