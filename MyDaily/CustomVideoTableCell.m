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
@property (nonatomic,strong) UIView *backgroundView;
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
    
    if (self) {
//        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(50, 20, 50, 220)];
//        view.layer.cornerRadius = 10;
//        self.backgroundView = view;
        self.contentView.frame = CGRectMake(0, 0, kScreenWidth - 20, 340);
//        [self.contentView addSubview:view];
//        self.contentView.backgroundColor = [UIColor redColor];
//        view.backgroundColor = [UIColor lightGrayColor];
        
        CGFloat titleX = padding;
        CGFloat titleY = padding * 2;
        CGFloat titleWidth = kScreenWidth;
        CGFloat titleHeight = 20;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleWidth - padding,titleHeight)];
        self.titleLable = titleLabel;
        [self.titleLable setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview: titleLabel];
//
        CGFloat coverImageViewY = titleY + titleHeight;
        CGFloat coverImageVeiwHeight = kScreenWidth * 0.56;
        UIImageView *coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, coverImageViewY , kScreenWidth,coverImageVeiwHeight)];
        self.coverImageView = coverImageView;
        [self.contentView addSubview:coverImageView];
        
        UIImageView *playImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 30, coverImageVeiwHeight/2, 60, 60)];
        playImageView.image = [UIImage imageNamed:@"play120"];
        [self.contentView addSubview:playImageView];
        
        CGFloat descLabelY = coverImageViewY + coverImageVeiwHeight;
        CGFloat descLabelHeight = 20;
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, descLabelY, kScreenWidth - padding,descLabelHeight)];
        self.desLabel = descLabel;
        [self.desLabel setTextColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:descLabel];
        
        self.cellHeight = descLabelY + descLabelHeight + 10;
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
