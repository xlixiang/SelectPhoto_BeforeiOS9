//
//  LXSelectPhotoPickerGroupViewController.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXSelectPhotoPickerViewController.h"

@interface LXSelectPhotoPickerGroupViewController : UIViewController

@property (weak, nonatomic) id<LXPhotoPickerViewControllerDelegate>delegate;
@property (assign, nonatomic) PickerViewShowStatus status;
@property (assign, nonatomic) NSInteger minCount;
//记录选中
@property (strong, nonatomic) NSArray *selectAsstes;
@property (assign, nonatomic) BOOL topShowPhotoPicker;

@end
