//
//  VideoCell.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/25.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "CustomVideoTableCell.h"

@implementation CustomVideoTableCell

+(instancetype) cellWithTableView:(UITableView *) tableView {
    static NSString *cellID = @"cell";
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CustomVideoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[CustomVideoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(10, 5, kScreenWidth - 20, 150)];
        view.layer.cornerRadius = 10;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth, 160);
        [self.contentView addSubview:view];
        self.contentView.backgroundColor = [UIColor redColor];
        view.backgroundColor = [UIColor lightGrayColor];
    }
    
    return self;
}

@end
