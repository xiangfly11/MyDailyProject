//
//  NewsViewController.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/11.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    headlineNews = 1,
    otherNews,
} newsType;

@interface NewsViewController : UIViewController

@property (nonatomic,assign) newsType type;
@property (nonatomic,strong) NSString *content;

@end
