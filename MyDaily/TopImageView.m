//
//  TopImageView.m
//  MyDaily
//
//  Created by 李嘉翔 on 6/27/16.
//  Copyright © 2016 Jiaxiang Li. All rights reserved.
//

#import "TopImageView.h"

@interface TopImageView ()

@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@end



@implementation TopImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[[NSBundle mainBundle] loadNibNamed:@"TopImageView" owner:self options:nil] firstObject];
        
        _view.frame = self.bounds;
       [self addSubview:_view];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        _gradientLayer = [CAGradientLayer layer];
//        _gradientLayer.frame = self.imageView.bounds;
//        _gradientLayer.colors = @[
//                                  (id)[UIColor colorWithWhite:0.2 alpha:0.6].CGColor,
//                                  (id)[UIColor clearColor].CGColor,
//                                  (id)[UIColor clearColor].CGColor,
//                                  (id)[UIColor colorWithWhite:0.2 alpha:0.6].CGColor
//                                  ];
//        _gradientLayer.locations = @[ @0.0, @0.4, @0.7, @1.0 ];
//        
//        [self.imageView.layer addSublayer:_gradientLayer];
    }
    
    return self;
}


- (void)layoutSubviews {
//    [super layoutSubviews];
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    self.gradientLayer.frame = self.imageView.bounds;
//    [CATransaction commit];
}


@end
