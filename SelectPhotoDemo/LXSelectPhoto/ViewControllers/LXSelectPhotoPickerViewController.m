//
//  LXSelectPhotoPickerViewController.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "LXSelectPhotoPickerViewController.h"
#import "LXSelectPhotoNavigationViewController.h"
#import "LXSelectPhotoPickerGroupViewController.h"
#import "LXSelectPhotoCommon.h"
#import "LXSelectPhotoAssets.h"

@interface LXSelectPhotoPickerViewController ()

@property (weak, nonatomic) LXSelectPhotoPickerGroupViewController  *groupVC;

@end

@implementation LXSelectPhotoPickerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initNavigationController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotitication];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通过传入一个图片对象（LXSelectPhotoAssets/ALAsset）获取一张缩略图
+ (UIImage *)getImageWithImageObj:(id)imageObj{
    __block UIImage *image = nil;
    if ([imageObj isKindOfClass:[UIImage class]]) {
        return imageObj;
    }else if ([imageObj isKindOfClass:[ALAsset class]]){
        @autoreleasepool {
            ALAsset *asset = (ALAsset *)imageObj;
            return [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            //            [[self.asset defaultRepresentation] fullScreenImage]
        }
    }else if ([imageObj isKindOfClass:[LXSelectPhotoAssets class]]){
        return [imageObj originImage];
    }
    return image;
}

#pragma mark - init
- (void)initNavigationController {
    LXSelectPhotoPickerGroupViewController *groupVC = [[LXSelectPhotoPickerGroupViewController alloc] init];
    LXSelectPhotoNavigationViewController *navigationVC = [[LXSelectPhotoNavigationViewController alloc] initWithRootViewController:groupVC];
    navigationVC.view.frame = self.view.bounds;
    [self addChildViewController:navigationVC];
    [self.view addSubview:navigationVC.view];
    self.groupVC = groupVC;
}

- (void)addNotitication {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:PICKER_TAKE_DONE object:nil];
    });
}

- (void)done:(NSNotification *)notification {
    NSArray *selectArray = notification.userInfo[@"selectAssets"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
            [self.delegate pickerViewControllerDoneAsstes:selectArray];
        }else if (self.callBack) {
            self.callBack(selectArray);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - showVC
- (void)showPickerViewController:(UIViewController *)vc {
    __weak typeof (vc) weakVc = vc;
    if (weakVc != nil) {
        [weakVc presentViewController:self animated:YES completion:nil];
    }
}

#pragma mark - setter
- (void)setSelectPickers:(NSArray *)selectPickers {
    _selectPickers = selectPickers;
    self.groupVC.selectAsstes = selectPickers;
}

- (void)setStatus:(PickerViewShowStatus)status {
    _status = status;
    self.groupVC.status = status;
}

- (void)setMinCount:(NSInteger)minCount {
    if (minCount <= 0) {
        return;
    }
    _minCount = minCount;
    self.groupVC.minCount = minCount;
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker {
    _topShowPhotoPicker = topShowPhotoPicker;
    self.groupVC.topShowPhotoPicker = topShowPhotoPicker;
}

- (void)setDelegate:(id<LXPhotoPickerViewControllerDelegate>)delegate {
    _delegate = delegate;
    self.groupVC.delegate = delegate;
}

@end
