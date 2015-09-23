//
//  LXSelectPhotoAssets.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoAssets.h"

@implementation LXSelectPhotoAssets

- (UIImage *)thumbImage {
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}

- (UIImage *)originImage {
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}

- (BOOL)isIsVideoType {
    NSString *type = [self.asset valueForProperty:ALAssetPropertyType];
    return [type isEqualToString:ALAssetTypeVideo];
}

@end
