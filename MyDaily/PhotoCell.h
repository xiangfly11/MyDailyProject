//
//  PhotoCell.h
//  MyDaily
//
//  Created by 李嘉翔 on 16/7/19.
//  Copyright © 2016年 Jiaxiang Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

//typedef void(^ClickImageBlock)(Photo *photo);

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
//@property (strong,nonatomic) ClickImageBlock block;

-(void) setCellWithPhoto:(Photo *) photo;

@end
