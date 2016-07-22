//
//  Photo.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/19.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject

@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,assign) CGFloat imageWidth;
@property (nonatomic,assign) CGFloat imageheight;
@property (nonatomic,strong) NSString *thumbnailUrl;
@property (nonatomic,assign) CGFloat thumbnailWidth;
@property (nonatomic,assign) CGFloat thumbnailHeight;
@property (nonatomic,strong) NSString *desc;
@end
