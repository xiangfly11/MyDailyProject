//
//  NewsViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/11.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "NewsDetailViewController.h"

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger _page;
    NSInteger _currentPages;
   
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *newsArr;
@end

@implementation NewsViewController


-(void) viewDidLoad {
    [super viewDidLoad];
    [self initController];
    [self createTableView];
    [self setupRefreshView];
//    [self requestData];
}


-(void) initController {
    _page = 0;
    _newsArr = [NSMutableArray array];
    _currentPages = 20;
    
}


-(void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,10, kScreenWidth, kScreenHeight - topCarouselViewHeight - topScrollButtonsViewHeight - navigationBarHeight - 50 ) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, kScreenWidth, 50)];
//    [lable setText:@"下拉刷新"];
//    [self.view addSubview:lable];
//    [self.tableView.tableHeaderView addSubview:lable];
    
    
    [self.view addSubview:_tableView];
}

-(void) setupRefreshView {

    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(requestDataWithControl:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    
    [self requestDataWithControl:refreshControl];
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
//    
//    // Enter the refresh status immediately
//    [self.tableView.mj_header beginRefreshing];
    
    
}



//-(void) requestData {
//    NSString *urlStr;
//    if (self.content == nil) {
//        urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%ld-%ld.html",(long)_page,_currentPages];
//        self.type = headlineNews;
//    }else {
//        urlStr = [NSString stringWithFormat:@"http://api.huceo.com/%@/other/?key=c32da470996b3fdd742fabe9a2948adb&num=%ld",self.content,_currentPages];
//        self.type = otherNews;
//    }
//    
//    
//    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlStr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
//        [self fetchData:object withType:self.type];
////        [control endRefreshing];
//    } withFailureBlock:^(NSError *error) {
//        NSLog(@"Error:%@",error.localizedDescription);
////        [control endRefreshing];
//    } progress:nil];
//
//}


-(void) requestDataWithControl:(UIRefreshControl *) control {
    NSString *urlStr;
    if (self.content == nil) {
        urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%ld-%ld.html",(long)_page,_currentPages];
        self.type = headlineNews;
    }else {
        urlStr = [NSString stringWithFormat:@"http://api.huceo.com/%@/other/?key=c32da470996b3fdd742fabe9a2948adb&num=%ld",self.content,_currentPages];
        self.type = otherNews;
    }
    
    
    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlStr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
        [self fetchData:object withType:self.type];
        [control endRefreshing];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error.localizedDescription);
        [control endRefreshing];
    } progress:nil];
    
}

-(void) fetchData:(NSDictionary *) object withType:(newsType) type{
    
    switch (self.type) {
        case headlineNews:
        {
            NSArray *response = object[@"T1348647853363"];
            NSArray *resultArr = [NewsModel mj_objectArrayWithKeyValuesArray:response];
            
            NSInteger i = 0;
            for (NewsModel *news in resultArr) {
//                NSLog(@"%ld,%@:%@",i,news.title,news.url_3w);
                i++;
                if (news.url_3w != nil) {
                    [self.newsArr addObject:news];
                }
            }
            
        }
        case otherNews:
        {
            NSArray *response = object[@"newslist"];
            NSArray *resultArr = [NewsModel mj_objectArrayWithKeyValuesArray:response];
            for (NewsModel *news in resultArr) {
                [self.newsArr addObject:news];
            }
        }
        break;
        
        default:
            break;
    }
    
    [self.tableView reloadData];
    
}

//-(void) updateData {
//    [self requestData];
//}

//-(void) loadMoreData {
//    _currentPages += _currentPages + 10;
//    [self requestData];
//    
//}

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
    NewsModel *news = self.newsArr[indexPath.row];
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc] init];
    detailViewController.news = news;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
