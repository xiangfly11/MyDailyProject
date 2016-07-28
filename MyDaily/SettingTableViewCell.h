//
//  SettingTableViewCell.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/28.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@end
