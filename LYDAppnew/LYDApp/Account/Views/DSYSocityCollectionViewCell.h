//
//  DSYSocityCollectionViewCell.h
//  LYDApp
//
//  Created by yidai on 16/11/11.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSYSocityCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;     /**< 社交平台的图片 */
@property (nonatomic, strong) UILabel *socityNameLabel;  /**< 社交平台的名 */

//+ (DSYSocityCollectionViewCell *)cellFotCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
