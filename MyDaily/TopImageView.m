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
        
    }
    
    return self;
}



@end
