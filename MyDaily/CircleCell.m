//
//  ItemCell.m
//  MyDaily
//
//  Created by Jiaxiang Li on 8/4/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentView.layer.cornerRadius = 45;
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        CGFloat width = self.contentView.frame.size.width;
        CGFloat height = self.contentView.frame.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        label.textAlignment = NSTextAlignmentCenter;
        self.itemLabel = label;
        [self.imageView addSubview:label];
        
        self.contentView.clipsToBounds = YES;
    }
    
    return self;
}

@end
