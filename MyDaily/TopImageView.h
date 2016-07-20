//
//  TopImageView.h
//  MyDaily
//
//  Created by 李嘉翔 on 6/27/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopImageView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
