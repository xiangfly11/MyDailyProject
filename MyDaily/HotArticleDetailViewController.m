//
//  HotArticleDetailViewController.m
//  MyDaily
//
//  Created by Jiaxiang Li on 8/5/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "HotArticleDetailViewController.h"

@interface HotArticleDetailViewController ()

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation HotArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initController];
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initController {
    
}


-(void) createView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:webView];
    self.webView= webView;
    NSString *urlStr = _articleModel.url;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    
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
