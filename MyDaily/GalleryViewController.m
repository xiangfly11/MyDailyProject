//
//  GalleryViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "GalleryViewController.h"
#import "HMWaterflowLayout.h"
#import "PhotoModel.h"
#import "PhotoCell.h"
#import "PhotoViewController.h"
#import "DropDownTransitionController.h"
#import "InteractionController.h"
#import "CustomNavigationBar.h"
#import "TopNavScrollBar.h"

static NSString *const cellID = @"photoCell";
static NSString *const headerView = @"headerView";
static const CGFloat topNavScrollBarHeight = 70;
@interface GalleryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HMWaterflowLayoutDelegate,UIViewControllerTransitioningDelegate>{
}

@property (nonatomic,strong) UICollectionView *collectionVeiw;
@property (nonatomic,strong) NSMutableArray *itemsArray;
@property (nonatomic,strong) PhotoModel *photo;

@property (nonatomic,strong) id<UIViewControllerAnimatedTransitioning> animationController;
@property (nonatomic,strong) InteractionController *interactiveTransition;
@property (nonatomic,strong) CustomNavigationBar *navBar;
@property (nonatomic,strong) TopNavScrollBar *topNavScrollBar;
@property (nonatomic,strong) NSArray *topNavItems;
@property (nonatomic,strong) NSString *colName;
@property (nonatomic,strong) NSString *tagName;
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initController];
    [self createViews];
    [self requestData];
//    [self setupRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initController {
    _topNavItems = @[@"美女",@"明星",@"汽车",@"宠物",@"设计",@"家居",@"婚嫁",@"摄影",@"美食"];
    _colName = @"美女";
    _tagName = @"小清新";
    _itemsArray = [NSMutableArray array];
    _animationController = [DropDownTransitionController new];
    _interactiveTransition = [InteractionController new];
    self.navigationController.navigationBar.hidden = YES;

//    CustomNavigationBar *navBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, navigationBarHeight)];
//    self.navBar = navBar;
//    [self.view addSubview:navBar];
    
}


-(void) createViews {
    TopNavScrollBar *scrollNavBar = [[TopNavScrollBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,topNavScrollBarHeight)];
    [scrollNavBar setupNavScrollBarWithItems:_topNavItems];
    __weak typeof(self) weakSelf = self;
    scrollNavBar.selectedBlock = ^(UIButton *btn) {
        [weakSelf selectedTopic:btn];
    };
    
    self.topNavScrollBar = scrollNavBar;
    [self.view addSubview:scrollNavBar];
    
    HMWaterflowLayout *flowLayout = [[HMWaterflowLayout alloc] init];
    flowLayout.columnsCount = 2;
    flowLayout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,topNavScrollBarHeight, kScreenWidth, kScreenHeight - topNavScrollBarHeight) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionVeiw = collectionView;

    
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    
    [self.view addSubview:collectionView];
}

-(void)setupRefreshView
{
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
//    header.lastUpdatedTimeLabel.hidden = NO;
//    header.stateLabel.hidden = NO;
//    self.collectionVeiw.mj_header = header;
//    [header beginRefreshing];
//    
//    self.collectionVeiw.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void) updateData {
    [self requestData];
}


-(void) loadMoreData {
    
}

-(void) requestData {
    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/data/imgs?col=%@&tag=%@&sort=0&pn=0&rn=20&p=channel&from=1",_colName,_tagName];
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlstr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
//       NSLog(@"Images:%@",object);
       
       [self fetchData:object];
   } withFailureBlock:^(NSError *error) {
       NSLog(@"Error:%@",error.localizedDescription);
   } progress:nil];
}



-(void) fetchData:(NSDictionary *) object {
    NSArray *response = object[@"imgs"];
    [_itemsArray removeAllObjects];
    for (int i = 0; i < 20; i ++) {
        PhotoModel *photo = [[PhotoModel alloc] init];
        NSDictionary *result = response[i];
//        NSLog(@"%@",result);
        
        
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

-(void) selectedTopic:(UIButton *) btn {
    
    [_collectionVeiw setContentOffset:CGPointMake(0, topNavScrollBarHeight)];
    NSUInteger index = btn.tag - 200;
    if (index == 0) {
        _colName = _topNavItems[0];
        _tagName = @"小清新";
    }else {
        _colName = _topNavItems[index];
        _tagName = @"全部";
    }
    
    [self requestData];
    [_topNavScrollBar setCurrentItemIndex:index];
    
}


//-(void) presentVieiwController:(Photo *) photo {
//    NSLog(@"Photo image url:%@",photo.imageUrl);
//}

#pragma mark -- UICollectionDataSource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    PhotoModel *photo = self.itemsArray[indexPath.item];
    [cell setCellWithPhoto:photo];
    
    return cell;
    
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoModel *photo = self.itemsArray[indexPath.item];
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.photo = photo;
    photoVC.transitioningDelegate = self;
    [_interactiveTransition prepareForViewController:photoVC];
//    [self.navigationController pushViewController:photoVC animated:YES ];
    
    [self presentViewController:photoVC animated:YES completion:nil];
    
}

#pragma mark -- HMWaterFlowLayoutDelegate

-(CGFloat) waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    
    PhotoModel *photo = self.itemsArray[indexPath.item];
    return photo.thumbnailHeight / photo.thumbnailWidth *width * 1.5;
}


#pragma mark -- UIViewControllerTransitioningDelegate 

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animationController;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    return _animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return _interactiveTransition.isInteracting ? _interactiveTransition : nil;
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
