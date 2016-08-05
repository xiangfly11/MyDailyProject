//
//  HotArticlesViewController.m
//  MyDaily
//
//  Created by Jiaxiang Li on 8/4/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "HotArticlesViewController.h"
#import "HotArticleModel.h"
#import "PhotoCell.h"
#import "HMWaterflowLayout.h"
#import "HotArticleDetailViewController.h"


static NSString *const cellID = @"photoCell";

@interface HotArticlesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray *articleArray;
@property (nonatomic,strong) UICollectionView *collectionView;
//@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation HotArticlesViewController

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
    _articleArray = [NSMutableArray array];
    
    
    
}

-(void) createViews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [imageView setImage:[UIImage imageNamed:@"HotArticleVeiw_background"]];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [imageView addSubview:effectView];
    
    [self.view addSubview:imageView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 30, 20, 30);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 20;
    
//    HMWaterflowLayout *flowLayout = [[HMWaterflowLayout alloc] init];
//    flowLayout.columnsCount = 2;
//    flowLayout.delegate = self;
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, navBarHeight, kScreenWidth, kScreenHeight - 2 * navBarHeight) collectionViewLayout:flowLayout];
    
    [collectionView registerNib:[UINib nibWithNibName:@"PhotoCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview: collectionView];
    
}

-(void) requestData {
    NSString *urlStr = @"http://v.juhe.cn/weixin/query?key=1339c5bd074c0e1ecb59a806003457b0";
    [AFNetworkingTools requestWithType:HttpRequestTypeGet withUrlString:urlStr withParameters:nil withSuccessBlock:^(NSDictionary *object) {
        [self fetchData:object];
    } withFailureBlock:^(NSError *error) {
        NSLog(@"Error:%@",error.localizedDescription);
    } progress:nil];
}

-(void) fetchData:(NSDictionary *) object {
    NSDictionary *dict = object[@"result"];
    NSArray *result = dict[@"list"];
    for (NSDictionary *response in result) {
        HotArticleModel *model = [[HotArticleModel alloc] init];
        model.url = response[@"url"];
        model.thumbnail = response[@"firstImg"];
        model.title = response[@"title"];
        
        [_articleArray addObject:model];
    }
    
    [self.collectionView reloadData];
    
}

#pragma mark -- UICollectionViewDataSource && UICollectionViewDelegate

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _articleArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    cell.layer.shadowOpacity = 0.75;
//    cell.layer.shadowOffset = CGSizeMake(4, 100);
//    cell.layer.shadowRadius = 4.0f;
//    cell.layer.cornerRadius = 20;
//    cell.layer.borderColor = [UIColor blackColor].CGColor;
//    cell.layer.borderWidth = 1.0;
    
    cell.imageView.layer.cornerRadius = 15;
    cell.imageView.layer.masksToBounds = YES;
    cell.contentView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:241.0/255.0 blue:234.0/255.0 alpha:1.0];
    [cell setCellWithArticle:_articleArray[indexPath.item]];
    
    return cell;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(140, 200);
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HotArticleDetailViewController *detailVC = [[HotArticleDetailViewController alloc] init];
    detailVC.articleModel = _articleArray[indexPath.item];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//-(CGFloat) waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
//    
//    return 200;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
