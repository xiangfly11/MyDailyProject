//
//  SettingTableViewCell.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/28.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell
+(instancetype) cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"cell";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (cell == nil) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        NSArray *nib = [[NSBundle mainBundle]
                        loadNibNamed:@"SettingTableViewCell" owner:self options:nil];
        if (nib.count > 0) {
            cell = [nib firstObject];
            
            //Notice: if use the both of default textLabel and custom textLabel in the same time, we must set backgroundColor of default textLabel as clearColor. Then the custom text label can be show properly.
            cell.textLabel.backgroundColor = [UIColor clearColor];
        }
        
    }
    
    return cell;
}




@end
