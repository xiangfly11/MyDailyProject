//
//  NSString+Extension.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/10.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 * Return the size of text occupied on view
 * @param font:  the font of text
 * @param maxSize: the max size of text occupied
 */

-(CGSize) sizeWithFont:(UIFont *) font maxSize:(CGSize) maxSize;

@end
