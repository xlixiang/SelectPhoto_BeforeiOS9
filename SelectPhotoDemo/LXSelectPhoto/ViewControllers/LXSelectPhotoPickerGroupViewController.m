//
//  LXSelectPhotoPickerGroupViewController.m
//  SelectPhotoDemo
//
//  Created by lixiang_x on 15/9/21.
//  Copyright © 2015年 lixiang_x. All rights reserved.
//

#import "LXSelectPhotoPickerGroupViewController.h"
#import "LXSelectPhotoCommon.h"
#import "LXSelectPhotoPickerDatas.h"
#import "LXSelectPhotoPickerGroup.h"
#import "LXSelectPhotoPickerAssetsViewController.h"
#import "LXSelectPhotoPickerGroupTableViewCell.h"

@interface LXSelectPhotoPickerGroupViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView  *tableView;
@property (strong, nonatomic) NSArray      *groups;

@end

@implementation LXSelectPhotoPickerGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择相册";
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];
    [self initItemButtons];
    [self getImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init 
- (void)initItemButtons {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - Navigation Action
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)jumpToDetailVC {
    //相册
    LXSelectPhotoPickerGroup *group = nil;
    for (LXSelectPhotoPickerGroup *groupItem in self.groups) {
        if ((self.status == PickerViewShowStatusCameraRoll || self.status == PickerViewShowStatusVideo) && ([groupItem.groupName isEqualToString:@"Camera Roll"] || [groupItem.groupName isEqualToString:@"相机胶卷"])) {
            group = groupItem;
            break;
        }else if (self.status == PickerViewShowStatusSavePhotos && ([groupItem.groupName isEqualToString:@"Saved Photos"] || [groupItem.groupName isEqualToString:@"保存相册"])) {
            group = groupItem;
            break;
        }else if (self.status == PickerViewShowStatusPhotoStream && ([groupItem.groupName isEqualToString:@"Stream"] || [groupItem.groupName isEqualToString:@"我的照片流"])){
            group = groupItem;
            break;
        }
    }
    if (!group) {
        return;
    }
    LXSelectPhotoPickerAssetsViewController *assetsVC = [[LXSelectPhotoPickerAssetsViewController alloc] init];
    assetsVC.selectPickerAssets = self.selectAsstes;
    assetsVC.assetsGroup = group;
    assetsVC.topShowPhotoPicker = self.topShowPhotoPicker;
    assetsVC.groupVC = self;
    assetsVC.minCount = self.minCount;
    [self.navigationController pushViewController:assetsVC animated:NO];
}

#pragma mark - pravite
- (void)getImages {
    LXSelectPhotoPickerDatas *datas = [LXSelectPhotoPickerDatas defaultPicker];
    kWeakSelf(self);
    //获取所有图片的URL
    if (self.status == PickerViewShowStatusVideo) {
        [datas getAllGroupWithVideos:^(NSArray *groups) {
            self.groups = groups;
            if (self.status) {
                [self jumpToDetailVC];
            }
            [weakSelf.tableView reloadData];
        }];
    }else {
        [datas getAllGroupWithPhotos:^(NSArray *groups) {
            self.groups = groups;
            if (self.status) {
                [self jumpToDetailVC];
            }
            [weakSelf.tableView reloadData];
        }];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"GroupCell";
    LXSelectPhotoPickerGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[LXSelectPhotoPickerGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    cell.group = self.groups[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXSelectPhotoPickerGroup *group = self.groups[indexPath.row];
    LXSelectPhotoPickerAssetsViewController *assetsVC = [[LXSelectPhotoPickerAssetsViewController alloc] init];
    assetsVC.selectPickerAssets = self.selectAsstes;
    assetsVC.groupVC = self;
    assetsVC.assetsGroup = group;
    assetsVC.topShowPhotoPicker = self.topShowPhotoPicker;
    assetsVC.minCount = self.minCount;
    [self.navigationController pushViewController:assetsVC animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LX_DEVICE_WIDTH, LX_DEVICE_HEIGHT) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
