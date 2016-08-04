//
//  DailyInforViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/8/1.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "DailyInforViewController.h"
#import "CircleLayout.h"
#import "CircleCell.h"


static NSString *const cellID = @"myCell";
@interface DailyInforViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSArray *itemArr;
@property (nonatomic,strong) UICollectionView *collectionView;


@end

@implementation DailyInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initControlelr];
    [self createViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initControlelr {
    _itemArr = @[@"",@"天气",@"股票",@"火车",@"航班",@"电影",@"汇率",@"金价"];
    
    
}

-(void) createViews {
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    CircleLayout *layout = [[CircleLayout alloc ] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, navBarHeight, kScreenWidth, kScreenHeight - navBarHeight) collectionViewLayout:layout];
    [collectionView registerClass:[CircleCell class] forCellWithReuseIdentifier:cellID];
    self.collectionView = collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    [self.view addSubview:collectionView];
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:241.0/255.0 blue:234.0/255.0 alpha:1.0];
    
}


#pragma mark -- UICollecitonViewDataSource && UICollectionViewDelegate

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemArr.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CircleCell *circleCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    circleCell.itemLabel.text = _itemArr[indexPath.item];
//    [circleCell.imageView setImage:[UIImage imageNamed:@"circle_cell_background"]];
    if (indexPath.item == 0) {
        circleCell.imageView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:137.0/255.0 blue:79.0/60.0 alpha:1.0];
    } else {
        circleCell.imageView.backgroundColor = [UIColor colorWithRed:112.0/255.0 green:184.0/255.0 blue:164.0/60.0 alpha:1.0];
    }
    return circleCell;
    
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
