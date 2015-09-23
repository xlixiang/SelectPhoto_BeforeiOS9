//
//  LXSelectPhotoPickerDatas.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerDatas.h"
#import "LXSelectPhotoPickerGroup.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface LXSelectPhotoPickerDatas()

@property (strong, nonatomic) ALAssetsLibrary *library;

@end

@implementation LXSelectPhotoPickerDatas

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

- (ALAssetsLibrary *)library {
    if (_library == nil) {
        _library = [self.class defaultAssetsLibrary];
    }
    return _library;
}
#pragma mark - getter
+ (instancetype)defaultPicker {
    return [[self alloc] init];
}

#pragma mark - get all group
- (void)getAllGroupWithPhotos:(callBackBlock)callBack {
    [self getAllGroupAllPhotos:YES withResource:callBack];
}

- (void)getAllGroupWithVideos:(callBackBlock)callBack {
    [self getAllGroupAllPhotos:NO withResource:callBack];
}

- (void)getAllGroupAllPhotos:(BOOL)allPhotos withResource:(callBackBlock)callBack {
    NSMutableArray *groups = [NSMutableArray array];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultBlock = ^(ALAssetsGroup *group, BOOL *stop){
        if (group) {
            if (allPhotos) {
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            }else {
                [group setAssetsFilter:[ALAssetsFilter allVideos]];
            }
            //使用模型赋值
            LXSelectPhotoPickerGroup *pickerGroup = [[LXSelectPhotoPickerGroup alloc] init];
            pickerGroup.group = group;
            pickerGroup.groupName = [group valueForProperty:@"ALAssetsGroupPropertyName"];
            pickerGroup.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            pickerGroup.assetsCount = [group numberOfAssets];
            [groups addObject:pickerGroup];
        }else {
            callBack(groups);
        }
    };
    NSInteger type = ALAssetsGroupAll;
    [self.library enumerateGroupsWithTypes:type usingBlock:resultBlock failureBlock:nil];
}

#pragma mark - get point group Asset
- (void)getGroupPhotosWithGroup:(LXSelectPhotoPickerGroup *)pickerGroup finished:(callBackBlock)callBack {
    NSMutableArray *assets = [NSMutableArray array];
    ALAssetsGroupEnumerationResultsBlock result = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        if (asset) {
            [assets addObject:asset];
        }else {
            callBack(assets);
        }
    };
    [pickerGroup.group enumerateAssetsUsingBlock:result];
}

#pragma mark - get UIImage from AssetsURL
- (void)getAssetsPhotoWithURLs:(NSURL *)url callBack:(callBackBlock)callBack {
    [self.library assetForURL:url resultBlock:^(ALAsset *asset) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack([UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]);
        });
    } failureBlock:nil];
}

@end
