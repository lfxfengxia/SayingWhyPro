//
//  DSYDebtsTableViewCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYDebtsTableViewCell.h"
#import "DSYFinancingModel.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kDSYButtonTitleColor  rgba( 35, 132, 252, 1)

@interface DSYDebtsTableViewCell ()

@property (nonatomic, strong) UIView  *bgView;                /**< 底部背景视图 */
@property (nonatomic, strong) UILabel *financeTitleLabel;     /**< 投资标题 */
@property (nonatomic, strong) UILabel *financeStatusLabel;    /**< 投资状态 */
@property (nonatomic, strong) UILabel *origialRateLabel;      /**< 原始利率 */
@property (nonatomic, strong) UILabel *remainMoneyLabel;      /**< 剩余本金 */
@property (nonatomic, strong) UILabel *assignAmountLabel;     /**< 转让价 */
@property (nonatomic, strong) UILabel *endDateLabel;          /**< 结束日期的显示 */
@property (nonatomic, strong) UIImageView  *buttonBGView;          /**< button的背景视图 */


@property (nonatomic, strong) UIButton *serverBtn;   /**< 服务协议按钮 */
@property (nonatomic, strong) UIButton *detailBtn;   /**< 账单详情按钮 */

@end

@implementation DSYDebtsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYDebtsTableViewCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"debtsTableViewCell";
    
    DSYDebtsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYDebtsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}


- (void)setFinancing:(DSYFinancingModel *)financing {
    if (_financing != financing) {
        _financing = financing;
    }
    
    self.financeTitleLabel.text = self.financing.title;
    NSString *finaceStatusStr = nil;
    if (self.financing.financeingStatus == 1) {
        finaceStatusStr = @"持有中";
    } else if (self.financing.financeingStatus == 2) {
        finaceStatusStr = @"已完成";
    } else {
        finaceStatusStr = @"已完成";
    }
    self.financeStatusLabel.text = finaceStatusStr;
    
    self.origialRateLabel.text = [NSString stringWithFormat:@"原始利率: %.2f%%", 10.6];
    self.remainMoneyLabel.text = [NSString stringWithFormat:@"剩余本金: %.2f元", 5000.00];
    self.assignAmountLabel.text= [NSString stringWithFormat:@"转让价: %.2f元", 4500.00];
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd"];
    
    self.endDateLabel.text  = [NSString stringWithFormat:@"投资日期: %@", [matter stringFromDate:[NSDate date]]];
}


- (void)creatSubviews {
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    NSLog(@"%f", self.contentView.width);
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(X(12), Y(12), kSCREENW - X(24), H(225) - Y(24))];
    [self.contentView addSubview:_bgView];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = X(3);
    _bgView.layer.borderColor = rgba(236, 232, 227, 1).CGColor;
    _bgView.layer.borderWidth = X(0.5);
    
    self.financeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(30), Y(15), (self.bgView.width - X(60)) / 2, H(25))];
    [self.bgView addSubview:_financeTitleLabel];
    self.financeTitleLabel.font = DSY_NORMALFONT_16;
    self.financeTitleLabel.textColor = kDSYTextGrayColor_102;
    
    self.financeStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.financeTitleLabel.maxX, self.financeTitleLabel.y, self.financeTitleLabel.width, self.financeTitleLabel.height)];
    [self.bgView addSubview:_financeStatusLabel];
    self.financeStatusLabel.font = DSY_NORMALFONT_13;
    self.financeStatusLabel.textColor = ORANGECOLOR;
    self.financeStatusLabel.textAlignment = NSTextAlignmentRight;
    
    self.origialRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.financeTitleLabel.x, self.financeTitleLabel.maxY + Y(0), self.financeStatusLabel.maxX - self.financeTitleLabel.x, H(25))];
    [self.bgView addSubview:_origialRateLabel];
    self.origialRateLabel.textColor = kDSYTextGrayColor_102;
    self.origialRateLabel.font = DSY_NORMALFONT_13;
    
    self.remainMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.origialRateLabel.x, self.origialRateLabel.maxY, self.origialRateLabel.width, self.origialRateLabel.height)];
    [self.bgView addSubview:_remainMoneyLabel];
    self.remainMoneyLabel.font = DSY_NORMALFONT_13;
    self.remainMoneyLabel.textColor = kDSYTextGrayColor_102;
    
    self.assignAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.remainMoneyLabel.x, self.remainMoneyLabel.maxY, self.remainMoneyLabel.width, self.remainMoneyLabel.height)];
    [self.bgView addSubview:_assignAmountLabel];
    self.assignAmountLabel.font = DSY_NORMALFONT_13;
    self.assignAmountLabel.textColor = kDSYTextGrayColor_102;
    
    self.endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.assignAmountLabel.x, self.assignAmountLabel.maxY, self.assignAmountLabel.width, self.assignAmountLabel.height)];
    [self.bgView addSubview:_endDateLabel];
    self.endDateLabel.font = DSY_NORMALFONT_13;
    self.endDateLabel.textColor = kDSYTextGrayColor_102;
    
    self.buttonBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bgView.height - H(45), self.bgView.width, H(45))];
    [self.bgView addSubview:_buttonBGView];
    self.buttonBGView.image = DSYImage(@"account_financing_cell_twobutton_bg.png");
    self.buttonBGView.userInteractionEnabled = YES;
    
    [self creatBtnWithTitles:@[@"服务协议", @"账单详情"]];
}

- (void)creatBtnWithTitles:(NSArray *)titleArr {
    for (int i = 0; i < titleArr.count; i++) {
        NSString *title = titleArr[i];
        CGFloat width = self.buttonBGView.width / 2;
        CGFloat height = self.buttonBGView.height;
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.buttonBGView addSubview:button];
        button.titleLabel.font = DSY_NORMALFONT_14;
        button.frame = CGRectMake((i % 2 * width), 0, width, height);
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:kDSYButtonTitleColor forState:(UIControlStateNormal)];
        //        button.layer.borderColor = kDSYTextGrayColor_102.CGColor;
        //        button.layer.borderWidth = X(0.5);
        
        if (i == 0) {
            self.serverBtn = button;
        } else if (i == 1) {
            self.detailBtn = button;
        }
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)clickBtn:(UIButton *)btn {
    if (btn == self.serverBtn) {
        NSLog(@"服务协议");
        if (self.block) {
            self.block(self.currentIndex, DSYFinancingCellButtonClickTypeServerBook);
        }
    } else if (btn == self.detailBtn) {
        NSLog(@"账单详情");
        if (self.block) {
            self.block(self.currentIndex, DSYFinancingCellButtonClickTypeDetail);
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%f------%f", self.contentView.width, self.contentView.height);
    
}



@end
