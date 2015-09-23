//
//  LXSelectPhotoNavigationViewController.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoNavigationViewController.h"
#import "LXSelectPhotoCommon.h"

@interface LXSelectPhotoNavigationViewController ()

@end

@implementation LXSelectPhotoNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    UINavigationController *rootVC = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        [self.navigationBar setValue:[rootVC.navigationBar valueForKeyPath:@"barTintColor"] forKeyPath:@"barTintColor"];
        [self.navigationBar setTintColor:rootVC.navigationBar.tintColor];
        [self.navigationBar setTitleTextAttributes:rootVC.navigationBar.titleTextAttributes];
    }else {
        [self.navigationBar setValue:DefaultNavigationBarTintColor forKeyPath:@"barTintColor"];
        [self.navigationBar setTintColor:DefaultNavigationTintColor];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:DefaultNavigationTitleColor}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
