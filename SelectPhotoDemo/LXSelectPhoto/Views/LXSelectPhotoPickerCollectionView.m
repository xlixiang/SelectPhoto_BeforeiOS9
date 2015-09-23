//
//  LXSelectPhotoPickerCollectionView.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerCollectionView.h"
#import "LXSelectPhotoPickerFooterCollectionReusableView.h"
#import "LXSelectPhotoPickerCollectionViewCell.h"
#import "LXPhotoPickerImageView.h"
#import "LXSelectPhotoCommon.h"

@interface LXSelectPhotoPickerCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong)LXSelectPhotoPickerFooterCollectionReusableView *footerView;

//判断是不是第一次加载
@property (nonatomic, assign, getter=isFirstLoadding) BOOL firstLoadding;

@end

@implementation LXSelectPhotoPickerCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        _selectAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXSelectPhotoPickerCollectionViewCell *cell = [LXSelectPhotoPickerCollectionViewCell cellWithCollectionView:collectionView cellForItemAtIndex:indexPath];
    LXPhotoPickerImageView *cellImageView = [[LXPhotoPickerImageView alloc] initWithFrame:cell.bounds];
    cellImageView.maskViewFlag = YES;
    
    if (indexPath.item == 0 && self.topShowPhotoPicker) {
        UIImageView *imageView = [[cell.contentView subviews] lastObject];
        //判断真实类型
        if (![imageView isKindOfClass:[UIImageView class]]) {
            imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = YES;
            [cell.contentView addSubview:imageView];
        }
        imageView.tag = indexPath.item;
        imageView.image = [UIImage imageNamed:LXSelectPhotoSrcName(@"camera")];
    }else {
        //需要记录选中的值的数据
        if (self.isRecoderSelcetPicker) {
            for (LXSelectPhotoAssets *asset in self.selectAssets) {
                LXSelectPhotoAssets *arrayAsset = self.dataArray[indexPath.item];
                if ([asset.asset.defaultRepresentation.url isEqual:arrayAsset.asset.defaultRepresentation.url]) {
                    [self.selectIndexPath addObject:@(indexPath.row)];
                }
            }
        }
        [cell.contentView addSubview:cellImageView];
        cellImageView.maskViewFlag = [self.selectIndexPath containsObject:@(indexPath.row)];
        LXSelectPhotoAssets *asset = self.dataArray[indexPath.item];
        cellImageView.isVideoType = asset.isVideoType;
        if ([asset isKindOfClass:[LXSelectPhotoAssets class]]) {
            cellImageView.image = asset.thumbImage;
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.topShowPhotoPicker && indexPath.item == 0) {
        if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidCameraSelect:)]) {
            [self.collectionViewDelegate pickerCollectionViewDidCameraSelect:self];
        }
        return;
    }
    if (!self.lastDataArray) {
        self.lastDataArray = [NSMutableArray array];
    }
    LXSelectPhotoPickerCollectionViewCell *cell = (LXSelectPhotoPickerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    LXSelectPhotoAssets *asset = self.dataArray[indexPath.row];
    LXPhotoPickerImageView *pickerImageView = [cell.contentView.subviews lastObject];
    //如果没有就添加到数组，有的话就移除
    if (pickerImageView.isMaskViewFlag) {
        [self.selectIndexPath removeObject:@(indexPath.row)];
        [self.selectAssets removeObject:asset];
        [self.lastDataArray removeObject:asset];
    }else {
        //判断图片数量是否超过最大数或者小于0
        NSInteger minCount = (self.minCount < 0) ? KPhotoShowMaxCount : self.minCount;
        if (self.selectAssets.count >= minCount) {
            NSString *format = [NSString stringWithFormat:@"最多只能选择%ld张图片",(long)minCount];
            if (minCount == 0) {
                format = [NSString stringWithFormat:@"您已经选满了图片"];
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:format delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            [alertView show];
            return;
        }
        [self.selectIndexPath addObject:@(indexPath.row)];
        [self.selectAssets addObject:asset];
        [self.lastDataArray addObject:asset];
    }
    //通知代理现在被点击了
    if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidSelected:deleteAsset:)]) {
        if (pickerImageView.isMaskViewFlag) {
            //删除的情况
            [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:asset];
        }else {
            [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:nil];
        }
    }
    
    pickerImageView.maskViewFlag = ([pickerImageView isKindOfClass:[LXPhotoPickerImageView class]]) && !pickerImageView.isMaskViewFlag;
}

#pragma mark - 底部View
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LXSelectPhotoPickerFooterCollectionReusableView *resusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        LXSelectPhotoPickerFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.count = self.dataArray.count;
        resusableView = footerView;
        self.footerView = footerView;
    }
    return resusableView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //时间置顶的话
    if (self.status == LXPickerCollectionViewShowOrderStatusTimeDesc) {
        if (!self.firstLoadding && self.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
            //滚动到底部
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            //展示图片数
            self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + 100);
            self.firstLoadding = YES;
        }
    }
}

#pragma mark - getter
- (NSMutableArray *)selectIndexPath {
    if (_selectIndexPath == nil) {
        _selectIndexPath = [NSMutableArray array];
    }
    return _selectIndexPath;
}

#pragma mark - setter
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    //需要记录选中值的数据
    if (self.isRecoderSelcetPicker) {
        NSMutableArray *selectAssets = [NSMutableArray array];
        for (LXSelectPhotoAssets *asset in self.selectAssets) {
            for (LXSelectPhotoAssets *asset2 in self.dataArray) {
                if ([asset.asset.defaultRepresentation.url isEqual:asset2.asset.defaultRepresentation.url]) {
                    [selectAssets addObject:asset2];
                }
            }
        }
        _selectAssets = selectAssets;
    }
    [self reloadData];
}

@end
