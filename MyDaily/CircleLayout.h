//
//  CircleLayout.h
//  MyDaily
//
//  Created by Jiaxiang Li on 8/4/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGPoint center;
@property (nonatomic,assign) NSInteger cellcount;

@end
