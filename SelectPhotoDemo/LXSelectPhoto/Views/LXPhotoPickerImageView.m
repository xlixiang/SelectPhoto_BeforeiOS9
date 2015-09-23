//
//  LXPhotoPickerImageView.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXPhotoPickerImageView.h"
#import "LXSelectPhotoCommon.h"

@interface LXPhotoPickerImageView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *tickImageView;
@property (nonatomic, strong) UIImageView *videoView;

@end

@implementation LXPhotoPickerImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - getter
- (UIView *)maskView {
    if (_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.frame = self.bounds;
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.hidden = YES;
        [self addSubview:_maskView];
    }
    return _maskView;
}

- (UIImageView *)videoView {
    if (_videoView == nil) {
        _videoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height - 40, 30, 30)];
        _videoView.image = [UIImage imageNamed:LXSelectPhotoSrcName(@"video")];
        _videoView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_videoView];
    }
    return _videoView;
}

- (UIImageView *)tickImageView {
    if (_tickImageView == nil) {
        _tickImageView = [[UIImageView alloc] init];
        _tickImageView.frame = CGRectMake(self.bounds.size.width - 30, 0, 30, 30);
        _tickImageView.image = [UIImage imageNamed:LXSelectPhotoSrcName(@"AssetsPickerChecked")];
        _tickImageView.hidden = YES;
        [self addSubview:_tickImageView];
    }
    return _tickImageView;
}

#pragma mark - setter
- (void)setIsVideoType:(BOOL)isVideoType {
    _isVideoType = isVideoType;
    self.videoView.hidden = !(isVideoType);
}

- (void)setMaskViewFlag:(BOOL)maskViewFlag {
    _maskViewFlag = maskViewFlag;
    self.animationRightTick = maskViewFlag;
}

- (void)setAnimationRightTick:(BOOL)animationRightTick {
    _animationRightTick = animationRightTick;
    self.tickImageView.hidden = !animationRightTick;
    
    CAKeyframeAnimation *scaoleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaoleAnimation.duration = 0.25;
    scaoleAnimation.autoreverses = YES;
    scaoleAnimation.values = @[[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:1.2], [NSNumber numberWithFloat:1.0]];
    scaoleAnimation.fillMode = kCAFillModeForwards;
    
    if (self.isVideoType) {
        [self.videoView.layer removeAllAnimations];
        [self.videoView.layer addAnimation:scaoleAnimation forKey:@"transform.scale"];
    }else {
        [self.tickImageView.layer removeAllAnimations];
        [self.tickImageView.layer addAnimation:scaoleAnimation forKey:@"transform.scale"];
    }
}

@end
