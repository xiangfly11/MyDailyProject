//
//  PhotoViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/20.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photo.h"
@interface PhotoViewController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation PhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_photo.imageUrl]];
    [self.view addSubview:_imageView];
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
