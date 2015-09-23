//
//  LXSelectPhotoPickerViewController.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>

// 状态组
typedef NS_ENUM(NSInteger , PickerViewShowStatus) {
    PickerViewShowStatusGroup = 0, // default groups .
    PickerViewShowStatusCameraRoll ,
    PickerViewShowStatusSavePhotos ,
    PickerViewShowStatusPhotoStream ,
    PickerViewShowStatusVideo,
};

typedef void(^callBackBlock) (id obj);

@protocol LXPhotoPickerViewControllerDelegate <NSObject>

//返回所有的Asstes对象
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets;

@end

@interface LXSelectPhotoPickerViewController : UIViewController

//optional
@property (weak, nonatomic)id<LXPhotoPickerViewControllerDelegate>delegate;
//决定是否需要push到内容控制器，默认显示组
@property (assign, nonatomic) PickerViewShowStatus status;
//可以使用代理返回值  或者用block
@property (copy, nonatomic) callBackBlock callBack;
//每次选取图片的数量，默认是最大数9
@property (assign, nonatomic) NSInteger minCount;
//记录选中的值
@property (strong, nonatomic) NSArray *selectPickers;
//置顶展示图片
@property (assign, nonatomic) BOOL topShowPhotoPicker;
//展示控制器
- (void)showPickerViewController:(UIViewController *)vc;
//通过传入一个图片对象（LXSelectPhotoAssets/ALAsset）获取一张缩略图
+ (UIImage *)getImageWithImageObj:(id)imageObj;

@end
