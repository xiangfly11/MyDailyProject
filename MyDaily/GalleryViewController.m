//
//  GalleryViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "GalleryViewController.h"
#import "HMWaterflowLayout.h"
#import "Photo.h"
#import "PhotoCell.h"

static NSString *const cellID = @"photoCell";
static NSString *const headerView = @"headerView";

@interface GalleryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HMWaterflowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionVeiw;
@property (nonatomic,strong) NSMutableArray *itemsArray;
@property (nonatomic,strong) Photo *photo;


@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initController];
    [self initCollectionView];
//    [self requestData];
    [self setupRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initController {
    _itemsArray = [NSMutableArray array];
}


-(void) initCollectionView {
    
    HMWaterflowLayout *flowLayout = [[HMWaterflowLayout alloc] init];
    flowLayout.columnsCount = 3;
    flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionVeiw = collectionView;

    
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    
    [self.view addSubview:collectionView];
}

-(void)setupRefreshView
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    header.lastUpdatedTimeLabel.hidden = NO;
    header.stateLabel.hidden = NO;
    self.collectionVeiw.mj_header = header;
    [header beginRefreshing];
    
    self.collectionVeiw.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void) updateData {
    [self requestData];
}


-(void) loadMoreData {
    
}

-(void) requestData {
//    NSString *urlstr = @"http://image.baidu.com/data/imgs?col=%E7%BE%8E%E5%A5%B3&tag=%E5%B0%8F%E6%B8%85%E6%96%B0&sort=0&pn=10&rn=10&p=channel&from=1&to=5";
//    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//NSString *urlstr = @"http://image.baidu.com/wisebrowse/data?tag1=%E7%BE%8E%E5%A5%B3&tag2=%E5%B0%8F%E6%B8%85%E6%96%B0";
//    NSString *urlstr = @"http://image.baidu.com/channel/listjson?pn=0&rn=30&tag1=%E7%BE%8E%E5%A5%B3&tag2=%E5%85%A8%E9%83%A8&ftags=%E5%B0%8F%E6%B8%85%E6%96%B0&ie=utf8";
    
    NSString *urlstr = @"http://image.baidu.com/data/imgs?col=%E7%BE%8E%E5%A5%B3&tag=%E5%B0%8F%E6%B8%85%E6%96%B0&sort=0&pn=0&rn=20&p=channel&from=1";
   [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlstr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
//       NSLog(@"Images:%@",object);
       
       [self fetchData:object];
   } withFailureBlock:^(NSError *error) {
       NSLog(@"Error:%@",error.localizedDescription);
   } progress:nil];
}



-(void) fetchData:(NSDictionary *) object {
    NSArray *response = object[@"imgs"];
//    NSArray *result = [Photo mj_objectArrayWithKeyValuesArray: response];
//    for (Photo *photo in result) {
//        [self.itemsArray addObject:photo];
//    }
//
//   int i = 0;
//    for (NSDictionary *result in response) {
//            Photo *photo = [[Photo alloc] init];
//            photo.desc = result[@"desc"];
//            photo.imageUrl = result[@"imageUrl"];
//            CGFloat width = [result[@"imageWidth"] floatValue];
//            photo.imageWidth = width;
//            CGFloat height = [result[@"imageheight"] floatValue];
//            photo.imageheight = height;
//            
//            photo.thumbnailUrl = result[@"thumbnailUrl"];
//            CGFloat thuWidth = [result[@"thumbnailWidth"] floatValue];
//            photo.thumbnailWidth = thuWidth;
//            CGFloat thuHeight = [result[@"thumbnailHeight"] floatValue];
//            photo.thumbnailHeight = thuHeight;
//            
//            [self.itemsArray addObject:photo];
//        
//    }
    
    for (int i = 0; i < 20; i ++) {
        Photo *photo = [[Photo alloc] init];
        NSDictionary *result = response[i];
        NSLog(@"%@",result);
        
        
        photo.desc = result[@"desc"];
        photo.imageUrl = result[@"imageUrl"];
        CGFloat width = [result[@"imageWidth"] floatValue];
        photo.imageWidth = width;
        CGFloat height = [result[@"imageheight"] floatValue];
        photo.imageheight = height;
        
        photo.thumbnailUrl = result[@"thumbnailUrl"];
        CGFloat thuWidth = [result[@"thumbnailWidth"] floatValue];
        photo.thumbnailWidth = thuWidth;
        CGFloat thuHeight = [result[@"thumbnailHeight"] floatValue];
        photo.thumbnailHeight = thuHeight;
        
        NSLog(@"thumbnailUrl:%@",photo.thumbnailUrl);
        [self.itemsArray addObject:photo];

    }
    
    
    [self.collectionVeiw reloadData];
}

#pragma mark -- UICollectionDataSource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1];
    
    Photo *photo = self.itemsArray[indexPath.item];
    [cell setCellWithPhoto:photo];
    
    return cell;
    
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- HMWaterFlowLayoutDelegate

-(CGFloat) waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    
    Photo *photo = self.itemsArray[indexPath.item];
    return photo.thumbnailHeight / photo.thumbnailWidth *width;
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
