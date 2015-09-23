//
//  LXSelectPhotoPickerGroup.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LXSelectPhotoPickerGroup : NSObject

//组名
@property (copy, nonatomic) NSString *groupName;
//组的真实名
@property (copy, nonatomic) NSString *realGroupName;
//缩略图
@property (strong, nonatomic) UIImage *thumbImage;
//组里面的图片个数
@property (assign, nonatomic) NSInteger assetsCount;
//类型：Saved Photos
@property (copy, nonatomic) NSString *type;

@property (strong, nonatomic) ALAssetsGroup *group;

@end
