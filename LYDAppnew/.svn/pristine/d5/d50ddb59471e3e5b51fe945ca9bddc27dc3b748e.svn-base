//
//  STPhotoDesBrowserController.h
//  NanTongApp
//
//  Created by dookay_73 on 16/4/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPhotoDesBrowserController;
@protocol STPhotoDesBrowserDelegate <NSObject>

- (UIImage *_Nonnull)photoDesBrowser:(STPhotoDesBrowserController *_Nullable)browser
         placeholderImageForIndex:(NSInteger)index;

- (NSURL *_Nullable)photoDesBrowser:(STPhotoDesBrowserController *_Nullable)browser
     highQualityImageURLForIndex:(NSInteger)index;


@end


@interface STPhotoDesBrowserController : UIViewController


/** 1.原图片的容器，即图片来源的父视图 */
@property ( nonatomic, weak, nullable)UIView *sourceImagesContainerView;
/** 2.当前的标签 */
@property (nonatomic, assign)NSInteger currentPage;
/** 3.图片的总数目 */
@property (nonatomic, assign)NSInteger countImage;

@property (nonatomic, copy ,nullable) NSArray *titleArr;
@property (nonatomic, copy ,nullable) NSArray *desArr;
@property (nonatomic, copy ,nullable) NSString *mainTitle;

@property (nonatomic, weak, nullable) id <STPhotoDesBrowserDelegate>delegate;

- (void)createUI;

- (void)show;


@end
