//
//  NewsTableViewCell.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/14.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

+(instancetype) cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"newsCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
        [self addSubview:imageView];
        self.imageIcon = imageView;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 10, kScreenWidth -CGRectGetMaxX(imageView.frame)-20, 40)];
        label.numberOfLines = 0;
        label.numberOfLines = 0;
        if (kScreenWidth == 320) {
            label.font = [UIFont systemFontOfSize:15];
        }else{
            label.font = [UIFont systemFontOfSize:16];
        }
        

        [self addSubview:label];
        self.label = label;
    }
    
    return self;
}


-(void) setNewsModel:(NewsModel *)newsModel  withType:(NSInteger) type {
    _newsModel = newsModel;
    
    if (type == 1) {
        [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc]];
    }else if(type == 2){
        [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.picUrl]];
    }
    
    self.label.text = self.newsModel.title;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:224.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.8].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(10, rect.size.height, rect.size.width - 20, 1));
}



@end
