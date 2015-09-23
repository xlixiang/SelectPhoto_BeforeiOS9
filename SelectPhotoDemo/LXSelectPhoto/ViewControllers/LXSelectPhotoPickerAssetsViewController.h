//
//  LXSelectPhotoPickerAssetsViewController.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/22.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXSelectPhotoCommon.h"
#import "LXSelectPhotoPickerGroupViewController.h"
@class LXSelectPhotoPickerGroup;
@interface LXSelectPhotoPickerAssetsViewController : UIViewController

@property (strong, nonatomic) LXSelectPhotoPickerGroupViewController *groupVC;
@property (assign, nonatomic) PickerViewShowStatus status;
@property (strong, nonatomic) LXSelectPhotoPickerGroup  *assetsGroup;
@property (assign, nonatomic) NSInteger minCount;
//记录选中值的数据
@property (strong, nonatomic) NSArray *selectPickerAssets;
//置顶展示图片
@property (assign, nonatomic) BOOL topShowPhotoPicker;

@end
