//
//  NSString+Extension.m
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/10.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize) sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attr = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}


@end
