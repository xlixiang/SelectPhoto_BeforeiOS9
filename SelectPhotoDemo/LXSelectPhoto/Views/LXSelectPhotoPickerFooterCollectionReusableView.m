//
//  LXSelectPhotoPickerFooterCollectionReusableView.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerFooterCollectionReusableView.h"

@interface LXSelectPhotoPickerFooterCollectionReusableView()

@property (nonatomic, strong) UILabel *footerLabel;

@end

@implementation LXSelectPhotoPickerFooterCollectionReusableView

#pragma mark - getter
- (UILabel *)footerLabel {
    if (_footerLabel == nil) {
        _footerLabel = [[UILabel alloc] init];
        _footerLabel.frame = self.bounds;
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_footerLabel];
    }
    return _footerLabel;
}

#pragma mark - setter
- (void)setCount:(NSInteger)count {
    _count = count;
    if (count > 0) {
        self.footerLabel.text = [NSString stringWithFormat:@"有%ld张图片",(long)count];
    }
}

@end
