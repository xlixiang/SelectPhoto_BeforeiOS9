//
//  LXSelectPhotoPickerGroupTableViewCell.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/23.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerGroupTableViewCell.h"
#import "LXSelectPhotoPickerGroup.h"

@interface LXSelectPhotoPickerGroupTableViewCell()

@property (strong, nonatomic) UIImageView *groupImageView;
@property (strong, nonatomic) UILabel     *groupNameLabel;
@property (strong, nonatomic) UILabel     *groupPicCountLabel;

@end

@implementation LXSelectPhotoPickerGroupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter
- (UIImageView *)groupImageView {
    if (_groupImageView == nil) {
        _groupImageView = [[UIImageView alloc] init];
        _groupImageView.frame = CGRectMake(15, 5, 70, 70);
        _groupImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_groupImageView];
    }
    return _groupImageView;
}

- (UILabel *)groupNameLabel {
    if (_groupNameLabel == nil) {
        _groupNameLabel = [[UILabel alloc] init];
        _groupNameLabel.frame = CGRectMake(95, 15, self.frame.size.width - 100, 20);
        [self.contentView addSubview:_groupNameLabel];
    }
    return _groupNameLabel;
}

- (UILabel *)groupPicCountLabel {
    if (_groupPicCountLabel == nil) {
        _groupPicCountLabel = [[UILabel alloc] init];
        _groupPicCountLabel.font = [UIFont systemFontOfSize:13];
        _groupPicCountLabel.textColor = [UIColor lightGrayColor];
        _groupPicCountLabel.frame = CGRectMake(95, 40, self.frame.size.width - 100, 20);
        [self.contentView addSubview:_groupPicCountLabel];
    }
    return _groupPicCountLabel;
}

#pragma mark - setter
- (void)setGroup:(LXSelectPhotoPickerGroup *)group {
    _group = group;
    self.groupNameLabel.text = group.groupName;
    self.groupImageView.image = group.thumbImage;
    self.groupPicCountLabel.text = [NSString stringWithFormat:@"%ld",group.assetsCount];
}

@end
