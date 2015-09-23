//
//  LXSelectPhotoPickerCollectionView.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXSelectPhotoAssets.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSUInteger, LXPickerCollectionViewShowOrderStatus){
    LXPickerCollectionViewShowOrderStatusTimeDesc = 0,//升序
    LXPickerCollectionViewShowOrderStatusTimeAsc      //降序
};

@class LXSelectPhotoPickerCollectionView;
@protocol LXSelectPhotoPickerCollectionViewDelegate <NSObject>
//选择相片会调用
- (void)pickerCollectionViewDidSelected:(LXSelectPhotoPickerCollectionView *)pickerCollectionView deleteAsset:(LXSelectPhotoAssets *)deleteAssets;
//点击拍照会调用
- (void)pickerCollectionViewDidCameraSelect:(LXSelectPhotoPickerCollectionView *)pickerCollectionView;
@end

@interface LXSelectPhotoPickerCollectionView : UICollectionView

@property (nonatomic, assign) LXPickerCollectionViewShowOrderStatus status;
//保存所有的数据
@property (nonatomic, strong) NSArray *dataArray;
//保存选中的图片
@property (nonatomic, strong) NSMutableArray *selectAssets;
//最后保存的一次图片
@property (nonatomic, strong) NSMutableArray *lastDataArray;
//delegate
@property (nonatomic, weak) id<LXSelectPhotoPickerCollectionViewDelegate>collectionViewDelegate;
//限制最大数
@property (nonatomic, assign) NSInteger minCount;
//置顶展示图片
@property (nonatomic, assign) BOOL  topShowPhotoPicker;
//选中的索引值，防止重用
@property (nonatomic, strong) NSMutableArray *selectIndexPath;
//记录选中的值
@property (nonatomic, assign) BOOL isRecoderSelcetPicker;
@end
