//
//  LXSelectPhotoCommon.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#ifndef LXSelectPhotoCommon_h
#define LXSelectPhotoCommon_h

#define kWeakSelf(obj)  __weak __typeof(&*obj)weakSelf = obj;

#define LX_DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
#define LX_DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DefaultNavigationBarTintColor UIColorFromRGB(0x2f3535)
#define DefaultNavigationTintColor    UIColorFromRGB(0xd5d5d5)
#define DefaultNavigationTitleColor   UIColorFromRGB(0xd5d5d5)

// NSNotification
static NSString *PICKER_TAKE_DONE = @"PICKER_TAKE_DONE";

static NSString *PICKER_DELETE_DONE = @"PICKER_DELETE_DONE";
//最多显示9张
static NSInteger const KPhotoShowMaxCount = 9;

//图片路径
#define LXSelectPhotoSrcName(file) [@"LXSelectPhoto.bundle" stringByAppendingPathComponent:file]

#endif /* LXSelectPhotoCommon_h */
