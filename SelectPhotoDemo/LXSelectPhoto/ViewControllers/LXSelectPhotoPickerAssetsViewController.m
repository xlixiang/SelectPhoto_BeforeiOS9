//
//  LXSelectPhotoPickerAssetsViewController.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/22.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerAssetsViewController.h"
#import "LXSelectPhotoPickerCollectionView.h"
#import "LXSelectPhotoPickerFooterCollectionReusableView.h"
#import "LXSelectPhotoPickerGroup.h"
#import "LXSelectPhotoPickerDatas.h"
#import "LXSelectPhotoCommon.h"
#import "LXSelectPhotoPickerCollectionViewCell.h"

static CGFloat CELL_ROW = 4;
static CGFloat CELL_MARGIN = 2;
static CGFloat CELL_LINE_MARGIN = 2;
static CGFloat TOOLBAR_HEIGHT = 44;

static NSString *const _cellIdentifier = @"collectionCell";
static NSString *const _footerIdentifier = @"FooterView";
static NSString *const _identifier = @"toolBarThumbCollectionViewCell";

@interface LXSelectPhotoPickerAssetsViewController ()<LXSelectPhotoPickerCollectionViewDelegate>

@property (nonatomic, strong) LXSelectPhotoPickerCollectionView *collectionView;
//标记View
@property (nonatomic, strong) UILabel *makeView;
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIToolbar *toolBar;

//datas
@property (nonatomic, assign) NSInteger privateTempMinCount;
//数据源
@property (nonatomic, strong) NSMutableArray *assets;
//记录选中的assets
@property (nonatomic, strong) NSMutableArray *selectAssets;

@end

@implementation LXSelectPhotoPickerAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.bounds = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    [self.view addSubview:self.toolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_TAKE_DONE object:nil userInfo:@{@"selectAssets":self.selectAssets}];
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - LXSelectPhotoPickerCollectionViewDelegate
//选择相片会调用
- (void)pickerCollectionViewDidSelected:(LXSelectPhotoPickerCollectionView *)pickerCollectionView deleteAsset:(LXSelectPhotoAssets *)deleteAssets {
    [self.makeView.layer removeAllAnimations];
    CAKeyframeAnimation *scaoleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaoleAnimation.duration = 0.25;
    scaoleAnimation.autoreverses = YES;
    scaoleAnimation.values = @[[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:1.2], [NSNumber numberWithFloat:1.0]];
    scaoleAnimation.fillMode = kCAFillModeForwards;
    [self.makeView.layer addAnimation:scaoleAnimation forKey:@"transform.scale"];
    
    if (self.selectPickerAssets.count == 0) {
        self.selectAssets = [NSMutableArray arrayWithArray:pickerCollectionView.selectAssets];
    }else if (deleteAssets == nil){
        [self.selectAssets addObject:[pickerCollectionView.selectAssets lastObject]];
    }
    
    NSInteger count = self.selectAssets.count;
    self.makeView.hidden = !count;
    self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.doneButton.enabled = (count > 0);
    self.previewButton.enabled = (count > 0);
    
    if (self.selectPickerAssets.count || deleteAssets) {
        LXSelectPhotoAssets *asset = [pickerCollectionView.lastDataArray lastObject];
        if (deleteAssets){
            asset = deleteAssets;
        }
        
        NSInteger selectAssetsCurrentPage = -1;
        for (NSInteger i = 0; i < self.selectAssets.count; i++) {
            LXSelectPhotoAssets *photoAsset = self.selectAssets[i];
            if([[[[asset.asset defaultRepresentation] url] absoluteString] isEqualToString:[[[photoAsset.asset defaultRepresentation] url] absoluteString]]){
                selectAssetsCurrentPage = i;
                break;
            }
        }
        
        if (
            (self.selectAssets.count > selectAssetsCurrentPage)
            &&
            (selectAssetsCurrentPage >= 0)
            ){
            if (deleteAssets){
                [self.selectAssets removeObjectAtIndex:selectAssetsCurrentPage];
            }
            [self.collectionView.selectIndexPath removeObject:@(selectAssetsCurrentPage)];
            self.makeView.text = [NSString stringWithFormat:@"%ld",self.selectAssets.count];
        }
        // 刷新下最小的页数
        self.minCount = self.selectAssets.count + (_privateTempMinCount - self.selectAssets.count);
    }
}
//点击拍照会调用
- (void)pickerCollectionViewDidCameraSelect:(LXSelectPhotoPickerCollectionView *)pickerCollectionView {

}

#pragma mark - Getter
- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] init];
        _toolBar.translatesAutoresizingMaskIntoConstraints = NO;
        _toolBar.backgroundColor = [UIColor grayColor];
        _toolBar.frame = CGRectMake(0, LX_DEVICE_HEIGHT - 44, LX_DEVICE_WIDTH, 44);
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.previewButton];
        UIBarButtonItem *fiexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.doneButton];
        
        _toolBar.items = @[leftItem,fiexItem,rightItem];
    }
    return _toolBar;
}

- (UIButton *)doneButton {
    if (_doneButton == nil) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitleColor:[UIColor colorWithRed:0/255.0 green:91/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _doneButton.frame = CGRectMake(0, 0, 45, 45);
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton addSubview:self.makeView];
    }
    return _doneButton;
}

- (NSMutableArray *)selectAssets {
    if (_selectAssets == nil) {
        _selectAssets = [NSMutableArray array];
    }
    return _selectAssets;
}

- (UIButton *)previewButton {
    return nil;
}

- (LXSelectPhotoPickerCollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat cellW = (self.view.frame.size.width - CELL_MARGIN*CELL_ROW + 1)/CELL_ROW;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellW, cellW);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = CELL_LINE_MARGIN;
        layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, TOOLBAR_HEIGHT * 2);
        
        _collectionView = [[LXSelectPhotoPickerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.status = LXPickerCollectionViewShowOrderStatusTimeDesc;
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_collectionView registerClass:[LXSelectPhotoPickerCollectionViewCell class] forCellWithReuseIdentifier:_cellIdentifier];
        [_collectionView registerClass:[LXSelectPhotoPickerFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:_footerIdentifier];
        _collectionView.contentInset = UIEdgeInsetsMake(5, 0, TOOLBAR_HEIGHT, 0);
        _collectionView.collectionViewDelegate = self;
        [self.view insertSubview:_collectionView belowSubview:self.toolBar];
        
        _collectionView.frame = self.view.bounds;
        
//        NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
//        
//        NSString *widthVfl = @"H:|-0-[collectionView]-0-|";
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:widthVfl options:0 metrics:nil views:views]];
//        
//        NSString *heightVfl = @"V:|-0-[collectionView]-0-|";
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:heightVfl options:0 metrics:nil views:views]];
    }
    return _collectionView;
}

- (UILabel *)makeView {
    if (_makeView == nil) {
        _makeView = [[UILabel alloc] init];
        _makeView.textColor = [UIColor whiteColor];
        _makeView.textAlignment = NSTextAlignmentCenter;
        _makeView.font = [UIFont systemFontOfSize:13];
        _makeView.frame = CGRectMake(-5, -5, 20, 20);
        _makeView.hidden = YES;
        _makeView.layer.cornerRadius = _makeView.frame.size.height / 2.0;
        _makeView.clipsToBounds = YES;
        _makeView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_makeView];
    }
    return _makeView;
}

#pragma mark - setter
- (void)setSelectPickerAssets:(NSArray *)selectPickerAssets {
    NSSet *set = [NSSet setWithArray:selectPickerAssets];
    _selectPickerAssets = [set allObjects];
    if (!self.assets) {
        self.assets = [NSMutableArray arrayWithArray:selectPickerAssets];
    }else {
        [self.assets addObjectsFromArray:selectPickerAssets];
    }
    
    for (LXSelectPhotoAssets *assets in selectPickerAssets) {
        if ([assets isKindOfClass:[LXSelectPhotoAssets class]]) {
            [self.selectAssets addObject:assets];
        }
    }
    
    self.collectionView.lastDataArray = nil;
    self.collectionView.isRecoderSelcetPicker = YES;
    self.collectionView.selectAssets = self.selectAssets;
    NSInteger count = self.selectAssets.count;
    self.makeView.hidden = !count;
    self.makeView.text = [NSString stringWithFormat:@"%ld",(long)count];
    self.doneButton.enabled = (count > 0);
    self.previewButton.enabled = (count > 0);
}

- (void)setMinCount:(NSInteger)minCount {
    _minCount = minCount;
    
    if (!_privateTempMinCount) {
        _privateTempMinCount = minCount;
    }
    
    if (self.selectAssets.count == minCount) {
        minCount = 0;
    }else if(self.selectPickerAssets.count - self.selectAssets.count > 0){
        minCount = _privateTempMinCount;
    }
    self.collectionView.minCount = minCount;
}

- (void)setupAssets {
    if (!self.assets) {
        self.assets = [NSMutableArray array];
    }
    
    __block NSMutableArray *assetsM = [NSMutableArray array];
    kWeakSelf(self);
    [[LXSelectPhotoPickerDatas defaultPicker] getGroupPhotosWithGroup:self.assetsGroup finished:^(NSArray *assets) {
        [assets enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL *stop) {
            LXSelectPhotoAssets *zlAsset = [[LXSelectPhotoAssets alloc] init];
            zlAsset.asset = asset;
            [assetsM addObject:zlAsset];
        }];
        weakSelf.collectionView.dataArray = assetsM;
    }];
}

- (void)setAssetsGroup:(LXSelectPhotoPickerGroup *)assetsGroup {
    if (!assetsGroup.groupName.length) {
        return;
    }
    
    _assetsGroup = assetsGroup;
    self.title = assetsGroup.groupName;
    [self setupAssets];
}

@end
