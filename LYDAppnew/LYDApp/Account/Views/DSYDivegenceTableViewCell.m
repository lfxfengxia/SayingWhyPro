//
//  DSYDivegenceTableViewCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYDivegenceTableViewCell.h"
#import "DSYFinancingModel.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kDSYButtonTitleColor  rgba( 35, 132, 252, 1)

@interface DSYDivegenceTableViewCell ()

@property (nonatomic, strong) UIView  *bgView;                /**< 底部背景视图 */
@property (nonatomic, strong) UILabel *financeTitleLabel;     /**< 投资标题 */
@property (nonatomic, strong) UILabel *financeStatusLabel;    /**< 投资状态 */
@property (nonatomic, strong) UILabel *investMoneyLabel;      /**< 投资金额 */
@property (nonatomic, strong) UILabel *couponMoneyLabel;      /**< 优惠券的金额 */
@property (nonatomic, strong) UILabel *incomeLabel;           /**< 收益的金额 */
@property (nonatomic, strong) UILabel *investDateLabel;       /**< 投资日期的显示 */
@property (nonatomic, strong) UIImageView  *buttonBGView;          /**< button的背景视图 */


@property (nonatomic, strong) UIButton *serverBtn;   /**< 服务协议按钮 */
@property (nonatomic, strong) UIButton *detailBtn;   /**< 账单详情按钮 */
@property (nonatomic, strong) UIButton *rightsBtn;   /**< 债权转让按钮 */
@property (nonatomic, strong) UIButton *commenBtn;   /**< 客户评语按钮 */

@end

@implementation DSYDivegenceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYDivegenceTableViewCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"divergenceTableViewCell";
    DSYDivegenceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYDivegenceTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
        finaceStatusStr = @"转让中";
    } else if (self.financing.financeingStatus == 3) {
        finaceStatusStr = @"已转让";
    } else if (self.financing.financeingStatus == 4) {
        finaceStatusStr = @"已完成";
    }
    self.financeStatusLabel.text = finaceStatusStr;
    
    self.investMoneyLabel.text = [NSString stringWithFormat:@"真实投资金额: ￥%.2f", self.financing.investMoney];
    self.couponMoneyLabel.text = [NSString stringWithFormat:@"优惠券金额: ￥%.2f", self.financing.countPanMoney];
    self.incomeLabel.text      = [NSString stringWithFormat:@"累计收益: ￥%.2f", self.financing.incomeMoney];
    
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd"];
    
    self.investDateLabel.text  = [NSString stringWithFormat:@"投资日期: %@", [matter stringFromDate:[NSDate date]]];
}


- (void)creatSubviews {
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    NSLog(@"%f", self.contentView.width);
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(X(12), Y(12), kSCREENW - X(24), H(270) - Y(24))];
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
    
    self.investMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.financeTitleLabel.x, self.financeTitleLabel.maxY + Y(0), self.financeStatusLabel.maxX - self.financeTitleLabel.x, H(25))];
    [self.bgView addSubview:_investMoneyLabel];
    self.investMoneyLabel.textColor = kDSYTextGrayColor_102;
    self.investMoneyLabel.font = DSY_NORMALFONT_13;
    
    self.couponMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.investMoneyLabel.x, self.investMoneyLabel.maxY, self.investMoneyLabel.width, self.investMoneyLabel.height)];
    [self.bgView addSubview:_couponMoneyLabel];
    self.couponMoneyLabel.font = DSY_NORMALFONT_13;
    self.couponMoneyLabel.textColor = kDSYTextGrayColor_102;
    
    self.incomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.couponMoneyLabel.x, self.couponMoneyLabel.maxY, self.couponMoneyLabel.width, self.couponMoneyLabel.height)];
    [self.bgView addSubview:_incomeLabel];
    self.incomeLabel.font = DSY_NORMALFONT_13;
    self.incomeLabel.textColor = kDSYTextGrayColor_102;
    
    self.investDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.incomeLabel.x, self.incomeLabel.maxY, self.incomeLabel.width, self.incomeLabel.height)];
    [self.bgView addSubview:_investDateLabel];
    self.investDateLabel.font = DSY_NORMALFONT_13;
    self.investDateLabel.textColor = kDSYTextGrayColor_102;
    
    self.buttonBGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bgView.height - H(90), self.bgView.width, H(90))];
    [self.bgView addSubview:_buttonBGView];
    self.buttonBGView.image = DSYImage(@"account_financing_cell_button_bg.png");
    self.buttonBGView.userInteractionEnabled = YES;
    
    [self creatBtnWithTitles:@[@"服务协议", @"账单详情", @"债权转让", @"评论"]];
}

- (void)creatBtnWithTitles:(NSArray *)titleArr {
    for (int i = 0; i < titleArr.count; i++) {
        NSString *title = titleArr[i];
        CGFloat width = self.buttonBGView.width / 2;
        CGFloat height = self.buttonBGView.height / 2;
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.buttonBGView addSubview:button];
        button.titleLabel.font = DSY_NORMALFONT_14;
        button.frame = CGRectMake((i % 2 * width), (i / 2) * height, width, height);
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setTitleColor:kDSYButtonTitleColor forState:(UIControlStateNormal)];
        //        button.layer.borderColor = kDSYTextGrayColor_102.CGColor;
        //        button.layer.borderWidth = X(0.5);
        
        if (i == 0) {
            self.serverBtn = button;
        } else if (i == 1) {
            self.detailBtn = button;
        } else if (i == 2) {
            self.rightsBtn = button;
        } else if (i == 3) {
            self.commenBtn = button;
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
    } else if (btn == self.rightsBtn) {
        NSLog(@"投资组合");
        if (self.block) {
            self.block(self.currentIndex, DSYFinancingCellButtonClickTypeAssign);
        }
    } else if (btn == self.commenBtn) {
        NSLog(@"债权转让");
        if (self.block) {
            self.block(self.currentIndex, DSYFinancingCellButtonClickTypeCommen);
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%f------%f", self.contentView.width, self.contentView.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
