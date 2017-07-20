//
//  AlertFenXiangGuoDongVCNew.m
//  LYDApp
//
//  Created by fcl on 2017/5/27.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "AlertFenXiangGuoDongVCNew.h"
#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
@interface AlertFenXiangGuoDongVCNew ()
{
    CGFloat _font;
}

@property (nonatomic, copy) PictureBlock pictureBlock;
@property (nonatomic, copy) NSString *imageName;
@end

@implementation AlertFenXiangGuoDongVCNew

- (instancetype)initWithImageName:(NSString *)imageName ButtonName:(NSString *)btnName  Amount:(NSString  *)amount  JumpBlock:(PictureBlock)pictureBlock
{
    self = [super init];
    if (self) {
        
        _pictureBlock = pictureBlock;
        _imageName = imageName;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    //    self.view.backgroundColor = [UIColor cyanColor];
    if (HEIGHT==736)
    {
        _font=15;
    }
    else
    {
        _font=myFontSize;
    }
    
    
    
    [self configUI];
    
    
    
    
}

- (void)configUI {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha  = 0.5;
    [self.view addSubview:view];
    
    
    UIView *uv=[[UIView alloc] initWithFrame:CGRectMake((WIDTH-200*hx)/2, 180*hx, 200*hx, 267*hx)];
    [self.view addSubview:uv];
    /**
     *  图片
     */
    UIImageView *pictureView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageName]];
    pictureView.frame = CGRectMake(0, 0, 200*hx, 267*hx);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
    // 允许用户交互
    pictureView.userInteractionEnabled = YES;
    
    [pictureView addGestureRecognizer:tap];
    [uv addSubview:pictureView];
    
    
    
    
}






- (void)jump {
    
    [self dismissViewControllerAnimated:NO completion:^{
        
        if (_pictureBlock != nil) {
            _pictureBlock();
        }
        
    }];
    
}

- (void)close {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
