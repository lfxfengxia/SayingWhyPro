//
//  DSYAccountQRCodeController.m
//  LYDApp
//
//  Created by yidai on 16/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountQRCodeController.h"

@interface DSYAccountQRCodeController ()

@property (nonatomic, strong) UILabel *noticeLabel;  /**< 提示 */
@property (nonatomic, strong) UIImageView *qrCodeView; /**< 二维码 */

@end

@implementation DSYAccountQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigaTitle = @"二维码邀请";
    
    [self noticeLabel];
    [self qrCodeView];
    
    // 生成二维码
    [self creatQRCode];
}

- (UILabel *)noticeLabel {
    if (!_noticeLabel) {
        _noticeLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, 64 + Y(10), self.view.width, H(30)) andTextColor:rgba(49, 49, 49, 1) fontOfSystemSize:H(13.0f)];
        [self.view addSubview:_noticeLabel];
        _noticeLabel.text = @"请您的好友扫描以下二维码";
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noticeLabel;
}

- (UIImageView *)qrCodeView {
    if (!_qrCodeView) {
        _qrCodeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.noticeLabel.maxY + Y(62), W(174), W(174))];
        [self.view addSubview:_qrCodeView];
        _qrCodeView.centerX = self.view.centerX;
        
//        _qrCodeView.image = DSYImage(@"account_lingyongdai_QRcode.png");
    }
    return _qrCodeView;
}

- (void)creatQRCode {
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 3. 将字符串转换成NSData
    NSData *data = [self.QRCode dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    //    UIImage *codeImage = [UIImage imageWithCIImage:outputImage scale:1.0 orientation:UIImageOrientationUp];
    
    self.qrCodeView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:W(174)];//重绘二维码,使其显示清晰
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
