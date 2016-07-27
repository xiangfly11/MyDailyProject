//
//  SettingViewController.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/18.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImageVeiw;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong,nonatomic) UITableView *tableVeiw;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    self.navigationController.navigationBar.hidden = YES;
    [self.headerView setBackgroundColor:[UIColor colorWithRed:186/255.0f green:71/255.0f blue:58/255.0f alpha:1]];
    CGRect frame = self.photoImageVeiw.frame;
    frame.size.height = 80;
    frame.size.width = 60;
    self.photoImageVeiw.frame = frame;
    self.photoImageVeiw.layer.cornerRadius = 30;
    [self.photoImageVeiw setImage:[UIImage imageNamed:@"comment_profile_default"]];
    
    CGFloat headerViewHeight = self.headerView.frame.size.height;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headerViewHeight + 20, kScreenWidth, kScreenHeight - headerViewHeight) style:UITableViewStylePlain];
    self.tableVeiw = tableView;
    self.tableVeiw.dataSource = self;
    self.tableVeiw.delegate = self;
    self.tableVeiw.scrollEnabled = NO;
    self.tableVeiw.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    [self.tableVeiw reloadData];
}


#pragma mark -- UITableVeiwDataSource & UITableViewDelegate 
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
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
            cell.textLabel.text = @"清除内存";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
        }
            
        default:
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",index];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
    }
   
    

//    cell.backgroundColor = [UIColor redColor];
//    [cell.contentView setBackgroundColor:[UIColor redColor]];
    return cell;
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
