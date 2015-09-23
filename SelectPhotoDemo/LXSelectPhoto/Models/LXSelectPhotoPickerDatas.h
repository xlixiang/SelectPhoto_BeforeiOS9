//
//  LXSelectPhotoPickerDatas.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXSelectPhotoPickerGroup;

typedef void(^callBackBlock)(id obj);

@interface LXSelectPhotoPickerDatas : NSObject

//获取所有组
+ (instancetype)defaultPicker;

//获取所有组对应的图片
- (void)getAllGroupWithPhotos:(callBackBlock)callBack;
//获取多有组对应的Videos
- (void)getAllGroupWithVideos:(callBackBlock)callBack;
//传入一个组 获取组里面的Asset
- (void)getGroupPhotosWithGroup:(LXSelectPhotoPickerGroup *)pickerGroup finished:(callBackBlock)callBack;
//传入一个AssetsURL来获取UIImage
- (void)getAssetsPhotoWithURLs:(NSURL *)url callBack:(callBackBlock)callBack;

@end
