//
//  SettingViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "MBProgressHUD.h"

#define headRect CGRectMake(0,0,self.view.bounds.size.width,280)
#define VCWidth self.view.bounds.size.width
#define VCHeight self.view.bounds.size.height
//the minimum height of head view when we scroll up table view
#define navHeight 44

@interface HeadView:UIView
@property (weak, nonatomic) UIImageView * backgroundView;
@property (weak, nonatomic) UIImageView * headView;
@property (weak, nonatomic) UILabel * signLabel;

@end

@implementation HeadView
- (instancetype)initWithFrame:(CGRect)frame backgroundView:(NSString *)name headView:(NSString *)headImgName headViewWidth:(CGFloat)width signLabel:(NSString *)signature
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -navHeight, frame.size.width, frame.size.height)];
        UIImage * image = [UIImage imageNamed:name];
        UIImage * newImg = [self image:image byScalingToSize:self.bounds.size];
        backgroundView.image = newImg;
        backgroundView.clipsToBounds = YES;
        [self addSubview:backgroundView];
        _backgroundView = backgroundView;

        
        UIImageView * headView = [[UIImageView alloc]initWithFrame:(CGRect){(frame.size.width - width) * 0.5,0.5 * (frame.size.height - width) - navHeight,width,width}];
        headView.layer.cornerRadius = width*0.5;
        headView.layer.masksToBounds = YES;
        headView.image = [UIImage imageNamed:headImgName];
        [self addSubview:headView];
        _headView = headView;
        
        UILabel * signLabel = [[UILabel alloc]initWithFrame:(CGRect){0,CGRectGetMaxY(headView.frame) ,self.bounds.size.width,40}];
        signLabel.text = signature;
        signLabel.textAlignment = NSTextAlignmentCenter;
        signLabel.textColor = [UIColor whiteColor];
        [self addSubview:signLabel];
        _signLabel = signLabel;
        
    }
    return self;
}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
@end

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate> {
    NSString *_sizeOfCache;
}
@property (weak, nonatomic) UITableView *myTableView;
@property (weak, nonatomic) HeadView * myView;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self createViews];
    [self initController];
}



-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)createViews {
    
    UITableView * myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navHeight + 20, VCWidth, VCHeight - navHeight - 20)];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.contentInset = UIEdgeInsetsMake(headRect.size.height-navHeight-navHeight, 0, 0, 0);
    myTableView.tableFooterView = [[UIView alloc] init];
    _myTableView = myTableView;
    
    [self.view addSubview:myTableView];
    
    HeadView * vc = [[HeadView alloc]initWithFrame:headRect backgroundView:@"background-1" headView:@"comment_profile_default" headViewWidth:(CGFloat)(VCWidth / 4) signLabel:@"请登录"];
    
    _myView = vc;
    _myView.backgroundColor = [UIColor clearColor];
    _myView.userInteractionEnabled = NO;
    [self.view addSubview:vc];
}


-(void) initController {
    float cacheSize = [[SDImageCache sharedImageCache] getSize];
    NSString *clearCacheName = cacheSize >= 1 ? [NSString stringWithFormat:@"%.1fMB",cacheSize/(1024*1024)] : [NSString stringWithFormat:@"%.1fKB",cacheSize * 1024];
    _sizeOfCache = clearCacheName;
    
//    [_myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden{
    
    return YES;
}

#pragma mark - tableview dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell *cell = [SettingTableViewCell cellWithTableView:tableView];

    NSInteger index = indexPath.row;
    switch (index) {
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"Services"]];
            cell.textLabel.text = @"设置";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
        }


        case 1:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"Change Theme"]];
            cell.textLabel.text = @"主题";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            break;
        }

        case 2:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"Feedback"]];
            cell.textLabel.text = @"反馈";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
        }
        case 3:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"Cache"]];
            cell.textLabel.text = @"清除缓存";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            
            [cell.detailLabel setText:_sizeOfCache];
            [cell.detailLabel setTextColor:[UIColor redColor]];
            [cell.detailLabel setTextAlignment:NSTextAlignmentCenter];
            [cell.detailLabel setTextColor:[UIColor lightGrayColor]];
            break;
        }

        default:
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",index];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
    }
    
        
    return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
        {

            MBProgressHUD *hud = [[MBProgressHUD alloc] init];
            [[[UIApplication sharedApplication].windows firstObject] addSubview:hud];
            hud.labelText = @"清理缓存中";
            hud.dimBackground = YES;
            hud.mode = MBProgressHUDModeDeterminate;
            [hud showAnimated:YES whileExecutingBlock:^{
                while (hud.progress < 1.0) {
                    hud.progress += 0.01;
                    [NSThread sleepForTimeInterval:0.02];
                }
                hud.labelText = @"清理完成";
            } completionBlock:^{
                [[SDImageCache sharedImageCache] clearDisk];
                [[SDImageCache sharedImageCache] clearMemory];
                _sizeOfCache = @"0.0KB";
                [self.myTableView reloadData];
                [hud removeFromSuperview];
            }];
            

        }
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offset_Y = scrollView.contentOffset.y + headRect.size.height-navHeight-navHeight;
    
    if  (offset_Y < 0) {
        
        _myView.backgroundView.contentMode = UIViewContentModeScaleToFill;
        
        _myView.backgroundView.frame = CGRectMake(offset_Y*0.5 , -navHeight, VCWidth - offset_Y, headRect.size.height - offset_Y);
    }else if (offset_Y > 0 && offset_Y <= (headRect.size.height-navHeight-navHeight)) {
        
        _myView.backgroundView.contentMode = UIViewContentModeTop;
        
        _myView.backgroundView.frame = CGRectMake(0 ,navHeight* offset_Y/(headRect.size.height-navHeight-navHeight)-navHeight , VCWidth , headRect.size.height -(navHeight + navHeight* offset_Y/(headRect.size.height-navHeight-navHeight)-navHeight) - offset_Y);
        
        
        CGFloat width = offset_Y*(40-(VCWidth / 4))/(headRect.size.height-navHeight-navHeight)+(VCWidth / 4);
        _myView.headView.frame =CGRectMake(0, 0, width,width);
        _myView.headView.layer.cornerRadius =width*0.5;
        _myView.headView.center = _myView.backgroundView.center;
        
        _myView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(_myView.headView.frame), VCWidth, 40);
        
        _myView.signLabel.alpha = 1 - (offset_Y*3 / (headRect.size.height-navHeight-navHeight) /2);
    }
}

@end

