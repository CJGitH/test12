//
//  ViewController.m
//  获取相册图片02-多张CJ
//
//  Created by chen on 16/4/22.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>

@interface ViewController () <CTAssetsPickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // github的搜索关键字：image picker photo asset
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        if (status != PHAuthorizationStatusAuthorized) return;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.delegate = self;
            // 显示选择的索引
            picker.showsSelectionIndex = YES;
            // 设置相册的类型：相机胶卷 + 自定义相册
            picker.assetCollectionSubtypes = @[
                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                               @(PHAssetCollectionSubtypeAlbumRegular)];
            // 不需要显示空的相册
            picker.showsEmptyAlbums = NO;
            [self presentViewController:picker animated:YES completion:nil];
        });
    }];
}

#pragma mark - <CTAssetsPickerControllerDelegate>
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 2;
    
    if (picker.selectedAssets.count >= max) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
        [picker presentViewController:alert animated:YES completion:nil];
        // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
        return NO;
    }
    
    return YES;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 基本配置
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode   = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // 遍历选择的所有图片
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
        
        // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = result;
            imageView.frame = CGRectMake((i % 3) * 110, (i / 3) * 110, 100, 100);
            [self.view addSubview:imageView];
        }];
    }
}
@end
