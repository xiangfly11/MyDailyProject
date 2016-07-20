//
//  PhotoCell.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/19.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "PhotoCell.h"
#import "Photo.h"
@implementation PhotoCell


-(void) setCellWithPhoto:(Photo *)photo {
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/908fa0ec08fa513d17b6a2ea386d55fbb2fbd9e2.jpg"] placeholderImage:nil];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photo.imageUrl] placeholderImage:nil];
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:photo.desc attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    CGSize size = [attribute boundingRectWithSize:CGSizeMake(self.frame.size.width - 5, 20) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  context:nil].size;
    
//    UIGestureRecognizer *recognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
//    [self addGestureRecognizer:recognizer];
    CGRect frame = self.titlelabel.frame;
    frame.size.height = size.height;
    self.titlelabel.frame = frame;
//    self.titlelabel.text = photo.desc;
    self.titlelabel.attributedText = attribute;
    [self.titlelabel setTextColor:[UIColor lightGrayColor]];
    
    self.titlelabel.textAlignment = NSTextAlignmentCenter;
}

//-(void) clickImageView:(Photo *) photo {
//    self.block(photo);
//}

@end
