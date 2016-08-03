//
//  VideoViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "VideoViewController.h"
#import "CustomVideoTableCell.h"
#import "VideoModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *itemsArr;
@property (nonatomic,strong) AVPlayerViewController *playerViewController;
@property (nonatomic,strong) NSMutableArray *cellHeightArr;
@property (nonatomic,assign) BOOL isPlayed;
@property (nonatomic,strong) AVPlayer *player;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initController];
    [self createViews];
    [self requestData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initController {
    _itemsArr = [NSMutableArray array];
    _cellHeightArr = [NSMutableArray array];
    _isPlayed = NO;
    
}


-(void) createViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 110)];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
}


-(void) requestData {
    NSString *url = @"http://c.m.163.com/nc/video/home/0-10.html";
    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:url withParameters:nil withSuccessBlock:^(NSDictionary *object) {
        [self fetchData:object];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error.description);
    } progress:nil];
}


-(void) fetchData:(NSDictionary *) object {
    NSArray *dataArr = object[@"videoList"];
    for (NSDictionary *dict in dataArr) {
        VideoModel *videoModel = [[VideoModel alloc] init];
        videoModel.cover = dict[@"cover"];
        videoModel.videoSource = dict[@"videosource"];
        videoModel.descriptionStr = dict[@"description"];
        videoModel.mp4_url = dict[@"mp4_url"];
        [self.itemsArr addObject:videoModel];
    }
    
    [self.tableView reloadData];
}


#pragma mark -- UITableViewDataSource & UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArr.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomVideoTableCell *cell = [CustomVideoTableCell cellWithTableView:tableView];
    [cell setVideoModel:self.itemsArr[indexPath.row]];
    [self.cellHeightArr addObject:[NSNumber numberWithFloat:cell.cellHeight]];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomVideoTableCell *cell = [CustomVideoTableCell cellWithTableView:tableView];
    [cell setVideoModel:self.itemsArr[indexPath.row]];
    return cell.cellHeight;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVPlayer *player;
    if (_isPlayed  == NO) {
        VideoModel *videoModel = self.itemsArr[indexPath.row];
        NSURL *url = [NSURL URLWithString:videoModel.mp4_url];
        player = [AVPlayer playerWithURL:url];
        self.player = player;
    }else {
        [self.player pause];
        [self.playerViewController.view removeFromSuperview];
        self.playerViewController = nil;
        VideoModel *videoModel = self.itemsArr[indexPath.row];
        NSURL *url = [NSURL URLWithString:videoModel.mp4_url];
        player = [AVPlayer playerWithURL:url];
    }
    
    self.playerViewController = [[AVPlayerViewController alloc] init];

    self.playerViewController.player = player;
    CGFloat cellHeight = [_cellHeightArr[indexPath.row] floatValue];
    NSInteger index = indexPath.row;
    CGFloat playViewOffset = 50.0;
    self.playerViewController.view.frame = CGRectMake(10, cellHeight * index + playViewOffset, kScreenWidth  - 20, kScreenWidth * 0.56);
    [self.tableView addSubview:self.playerViewController.view];
    [self.playerViewController.player play];
    self.isPlayed = YES;
    
}


-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.playerViewController) {
        if (fabs(scrollView.contentOffset.y) + 64 > CGRectGetMaxY(self.playerViewController.view.frame)) {
            
            [self.playerViewController.player pause];
            [self.playerViewController.view removeFromSuperview];
            self.playerViewController = nil;
            self.isPlayed = NO;
            
            //            [self setupSmallmpc];
            
        }else{
            //            NSLog(@"hahah");
            //                        self.smallmpc = NO;
            //                        VideoDataFrame *videoframe = self.videoArray[self.currtRow];
            //                        self.mpc.view.frame = CGRectMake(0, videoframe.cellH*self.currtRow+videoframe.coverF.origin.y, SCREEN_WIDTH, videoframe.coverF.size.height);
            //                        [self.tableview addSubview:self.mpc.view];
        }
    }
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [CustomVideoTableCell appearCell:cell andScale:0.5];
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
