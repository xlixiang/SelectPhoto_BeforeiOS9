//
//  LXSelectPhotoPickerCollectionViewCell.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXSelectPhotoPickerCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSIndexPath *)indexPath;

@property (nonatomic, strong) UIImage *cellImage;

@end
