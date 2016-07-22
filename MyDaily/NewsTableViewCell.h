//
//  NewsTableViewCell.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/14.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"


@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *imageIcon;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NewsModel *newsModel;

+(instancetype) cellWithTableView:(UITableView *) tableView;
-(void) setNewsModel:(NewsModel *)newsModel  withType:(NSInteger) type;
@end
