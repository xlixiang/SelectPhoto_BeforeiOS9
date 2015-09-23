//
//  LXPhotoPickerImageView.h
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXPhotoPickerImageView : UIImageView

//是否有蒙版层
@property (nonatomic, assign, getter=isMaskViewFlag) BOOL maskViewFlag;
//是否有右上角打钩的按钮
@property (nonatomic, assign) BOOL animationRightTick;
//是否为视频类型
@property (nonatomic, assign) BOOL isVideoType;

@end
