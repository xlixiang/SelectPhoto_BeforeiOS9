//
//  LXSelectPhotoAssets.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LXSelectPhotoAssets : NSObject

@property (strong, nonatomic) ALAsset *asset;
//获取是否为视频类型，默认否
@property (assign, nonatomic) BOOL isVideoType;

//缩略图
- (UIImage *)thumbImage;

//原图
- (UIImage *)originImage;

@end
