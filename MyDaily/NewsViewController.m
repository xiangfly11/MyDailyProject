//
//  NewsViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/11.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "NewsViewController.h"
#import "HeadlineNews.h"
#import "NewsTableViewCell.h"
#import "OtherNews.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger _page;
   
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *newsArr;
@end

@implementation NewsViewController


-(void) viewDidLoad {
    [super viewDidLoad];
    [self initConfig];
    [self initTableView];
//    [self setupRefreshView];
    [self requestData];
}


-(void) initConfig {
    _page = 0;
    _newsArr = [NSMutableArray array];
    
}


-(void) initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,10, kScreenWidth, kScreenHeight - topCarouselViewHeight - topScrollButtonsViewHeight - navigationBarHeight - 50 ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

-(void) setupRefreshView {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    header.lastUpdatedTimeLabel.hidden = NO;
    header.stateLabel.hidden = NO;
    self.tableView.mj_header = header;
    [header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void) requestData {
    NSString *urlStr;
    if (self.content == nil) {
        urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%ld-20.html",(long)_page];
        self.type = headlineNews;
    }else {
        urlStr = [NSString stringWithFormat:@"http://api.huceo.com/%@/other/?key=c32da470996b3fdd742fabe9a2948adb&num=20",self.content];
        self.type = otherNews;
    }
    
    
    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlStr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
        [self fetchData:object withType:self.type];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error.localizedDescription);
    } progress:nil];
    
}

-(void) fetchData:(NSDictionary *) object withType:(newsType) type{
    
    switch (self.type) {
        case headlineNews:
        {
            NSArray *response = object[@"T1348647853363"];
            NSArray *resultArr = [HeadlineNews mj_objectArrayWithKeyValuesArray:response];
            
            NSInteger i = 0;
            for (HeadlineNews *news in resultArr) {
                NSLog(@"%ld,%@:%@",i,news.title,news.url_3w);
                i++;
                if (news.url_3w != nil) {
                    [self.newsArr addObject:news];
                }
            }
            
        }
        case otherNews:
        {
            NSArray *response = object[@"newslist"];
            NSArray *resultArr = [OtherNews mj_objectArrayWithKeyValuesArray:response];
            for (HeadlineNews *news in resultArr) {
                [self.newsArr addObject:news];
            }
        }
        break;
        
        default:
            break;
    }
    
    [self.tableView reloadData];
}

-(void) updateData {
    
}

-(void) loadMoreData {
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count:%ld",self.newsArr.count);
    return self.newsArr.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [NewsTableViewCell cellWithTableView:tableView];
        [cell setNewsModel:self.newsArr[indexPath.row] withType:self.type];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
