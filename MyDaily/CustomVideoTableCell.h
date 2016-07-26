//
//  VideoCell.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/25.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;

@interface CustomVideoTableCell : UITableViewCell

@property (nonatomic,strong) VideoModel *videoModel;
@property (nonatomic,assign) CGFloat cellHeight;

+(instancetype) cellWithTableView:(UITableView *) tableView;

-(void) setVideoModel:(VideoModel *)videoModel;
@end
