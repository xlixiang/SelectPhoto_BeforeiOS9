//
//  ViewController.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "ViewController.h"
#import "LXSelectPhotoPickerViewController.h"
#import "LXSelectPhotoAssets.h"
#import "LXSelectPhotoCommon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)seclectPhotoButtonAction:(id)sender {
    LXSelectPhotoPickerViewController *pickerVC = [[LXSelectPhotoPickerViewController alloc] init];
    pickerVC.minCount = 3;
    kWeakSelf(self);
    pickerVC.callBack = ^(NSArray *assets){
        //assets为返回的数组  取出原图
//        for (LXSelectPhotoAssets *asset in weakSelf.assetsArray) {
//            UIImage *image = [LXSelectPhotoPickerViewController getImageWithImageObj:asset];
//            if (weakSelf.imageArray.count<3) {
//                [weakSelf.imageArray addObject:image];
//            }
//        }
    };
    [pickerVC showPickerViewController:self];
}

@end
