//
//  VideoModel.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/25.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *descriptionStr;
@property (nonatomic,strong) NSString *mp4_url;
@property (nonatomic,strong) NSString *videoSource;

@end
