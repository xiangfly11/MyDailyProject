//
//  VideoViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "VideoViewController.h"
#import "CustomVideoTableCell.h"

@interface VideoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 50)];
//    label.text = @"Hello";
//    [self.view addSubview:label];
    
    [self initController];
    [self createViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initController {
    
}


-(void) createViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 120)];
//    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.frame;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView reloadData];
    
}



#pragma mark -- UITableViewDataSource & UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomVideoTableCell *cell = [CustomVideoTableCell cellWithTableView:tableView];
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  160;
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
