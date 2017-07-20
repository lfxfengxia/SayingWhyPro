//
//  DSYFinancingBaseTableViewCell.h
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DSYFinancingCellButtonClickType) {
    DSYFinancingCellButtonClickTypeServerBook,   // 服务协议
    DSYFinancingCellButtonClickTypeDetail,       // 账单详情
    DSYFinancingCellButtonClickTypeInvest,       // 投资组合
    DSYFinancingCellButtonClickTypeAssign,       // 债权转让
    DSYFinancingCellButtonClickTypeCommen        // 客户评语
};

@interface DSYFinancingBaseTableViewCell : UITableViewCell

@end
