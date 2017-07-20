//
//  DSYFinancingBaseController.h
//  LYDApp
//
//  Created by dai yi on 2016/11/5.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBDatePickerView.h"
#import "DSYFinancingDetailController.h"

@interface DSYFinancingBaseController : UIViewController

@property (nonatomic, strong) UIImageView *headerView;              /**< 头部视图 */

@property (nonatomic, strong) UILabel *startDateLabel;         /**< 起始日期 */

@property (nonatomic, strong) UILabel *deadLineDateLabel;      /**< 结束日期 */

@property (nonatomic, strong) UILabel *totalMoneyLabel;        /**< 金额 */

@property (nonatomic, strong) UIButton *queryBtn;              /**< 查询按钮 */

@property (nonatomic, strong) UITableView *contentTableView;   /**< 主要的tableView */


@property (nonatomic,   copy) NSString *startDate;
@property (nonatomic,   copy) NSString *endDate;

@property (nonatomic, strong) RBDatePickerView *startDatePicker;  /**< 开始日期 */
@property (nonatomic, strong) RBDatePickerView *endDatePicker;    /**< 结束日期 */

/**
 * 获取想要的日期字符串
 */
- (NSString*)showDateStringFromDate:(NSDate *)date formatterString:(NSString *)formatterString;

/**
 * 固定显示XXX(xxx)
 */
- (NSMutableAttributedString *)getAttributeWithTitle:(NSString *)title;

@end
