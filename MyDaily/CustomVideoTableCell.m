//
//  VideoCell.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/25.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "CustomVideoTableCell.h"
#import "VideoModel.h"

static const CGFloat padding = 5;
@interface CustomVideoTableCell ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *playImageView;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) UIView *background;
@property (nonatomic,assign,readwrite) CGFloat cellHeight;
@end

@implementation CustomVideoTableCell

+(instancetype) cellWithTableView:(UITableView *) tableView {
    static NSString *cellID = @"cell";
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CustomVideoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[CustomVideoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGFloat backGroundViewHeight = 260;
    if (self) {
//        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(10, 20, kScreenWidth - 20, backGroundViewHeight)];
//        [view setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:0.7]];
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor darkGrayColor]];
        view.layer.cornerRadius = 10;
        [self.contentView addSubview:view];
        self.background = view;
        
//        [self.contentView setBackgroundColor:[UIColor colorWithRed:221.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:0.8]];
        [self.contentView setBackgroundColor:[UIColor lightGrayColor]];
        
//        view.layer.cornerRadius = 10;
//        self.backgroundView = view;
//        self.contentView.frame = CGRectMake(0, 0, kScreenWidth - 20, 340);
//        [self.contentView addSubview:view];
//        self.contentView.backgroundColor = [UIColor redColor];
//        view.backgroundColor = [UIColor lightGrayColor];
        
        CGFloat titleX = padding;
        CGFloat titleY = padding * 2;
        CGFloat titleWidth = kScreenWidth;
        CGFloat titleHeight = 20;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleWidth - 20,titleHeight)];
        self.titleLable = titleLabel;
        [self.titleLable setTextColor:[UIColor lightGrayColor]];
        [self.background addSubview: titleLabel];
//
        CGFloat coverImageViewY = titleY + titleHeight;
        CGFloat coverImageVeiwHeight = kScreenWidth * 0.56;
        UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, coverImageViewY , kScreenWidth - 20,coverImageVeiwHeight)];
        self.coverImageView = coverImageView;
        [self.background addSubview:coverImageView];
        
        UIImageView *playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30, coverImageVeiwHeight/2, 60, 60)];
        playImageView.image = [UIImage imageNamed:@"play120"];
        [self.background addSubview:playImageView];
        
        CGFloat descLabelY = coverImageViewY + coverImageVeiwHeight;
        CGFloat descLabelHeight = 20;
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, descLabelY, kScreenWidth - padding,descLabelHeight)];
        self.desLabel = descLabel;
        [self.desLabel setTextColor:[UIColor lightGrayColor]];
        [self.background addSubview:descLabel];
        
        self.cellHeight = backGroundViewHeight + 20;
        
        self.background.frame = CGRectMake(0, 0, -(kScreenWidth - 20), backGroundViewHeight);
//        [UIView animateWithDuration:1.5 animations:^{
//            self.background.frame = CGRectMake(10, 20, kScreenWidth - 20, backGroundViewHeight);
//        }];
        
        [UIView animateWithDuration:1.5 delay:0.5 usingSpringWithDamping:30 initialSpringVelocity:15 options:0 animations:^{
            self.background.frame = CGRectMake(10, 20, kScreenWidth - 20, backGroundViewHeight);
        } completion:nil];
    }
    
    return self;
}

-(void) setVideoModel:(VideoModel *)videoModel {
//    self.videoModel = videoModel;
    self.titleLable.text = videoModel.videoSource;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.cover]];
    self.desLabel.text = videoModel.descriptionStr;
}

@end
