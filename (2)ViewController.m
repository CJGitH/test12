//
//  ViewController.m
//  获取相册图片01-单张CJ
//
//  Created by chen on 16/4/22.
//  Copyright © 2016年 chen. All rights reserved.
//


/*
 获取相册中的图片
 1.单张
 1> UIImagePickerController
 2> AssetsLibrary框架
 3> Photos框架
 
 2.多张(>=2张)
 1> AssetsLibrary框架
 2> Photos框架
 */

/************************以下是简单的demo.点击屏幕就会来到相机图库,仅可以选取一张图**************/

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

/*
 UIImagePickerControllerSourceTypePhotoLibrary, 从所有相册中选择图片
 UIImagePickerControllerSourceTypeCamera, 利用照相机拍一张图片（自定义照相机AVCaptureSession）
 UIImagePickerControllerSourceTypeSavedPhotosAlbum 从Moments相册中选择图片
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 关闭选择图片界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 获得选择的图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = info[UIImagePickerControllerOriginalImage];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:imageView];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // .....
    
    // 关闭选择图片界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
