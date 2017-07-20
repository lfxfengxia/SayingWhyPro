//
//  DSYFinancingBillDetailTableCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  债权列表的cell

#import "DSYFinancingBillDetailTableCell.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kTextThinFont [UIFont systemFontOfSize:W(13.0f) weight:UIFontWeightThin]

@interface DSYFinancingBillDetailTableCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;            /**< 汇款的title */
@property (nonatomic, strong) UILabel *statusLabel;           /**< 回款的情况 */
@property (nonatomic, strong) UILabel *receiveingMoneyLabel;  /**< 本期应收金额 */
@property (nonatomic, strong) UILabel *expiredStatusLabel;    /**< 是否预期 */
@property (nonatomic, strong) UILabel *deadLineDateLabel;     /**< 到期还款时间 */
@property (nonatomic, strong) UILabel *actualDateLabel;       /**< 实际还款时间 */

@end

@implementation DSYFinancingBillDetailTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYFinancingBillDetailTableCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"financingBillDetailTableCell";
    DSYFinancingBillDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYFinancingBillDetailTableCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (void)setModel:(DSYFinancingModel *)model {
    
    self.titleLabel.text = @"一个月0356";
    self.statusLabel.text = @"已收款";
    self.receiveingMoneyLabel.text = [NSString stringWithFormat:@"本期应收金额: %.2f元", 100.00];
    self.expiredStatusLabel.text = [NSString stringWithFormat:@"是否逾期: %@", @"否"];
    self.deadLineDateLabel.text = [NSString stringWithFormat:@"到期还款时间: %@", @"2016-08-21"];
    self.actualDateLabel.text = [NSString stringWithFormat:@"实际还款时间: %@", @"2016-08-21"];
    
}

- (void)creatSubviews {
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_titleLabel];
    self.titleLabel.textColor = kDSYTextGrayColor_102;
    self.titleLabel.font = DSY_NORMALFONT_16;
    
    self.statusLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_statusLabel];
    self.statusLabel.font = kTextThinFont;
    self.statusLabel.textColor = ORANGECOLOR;
    self.statusLabel.textAlignment = NSTextAlignmentRight;
    
    self.receiveingMoneyLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_receiveingMoneyLabel];
    self.receiveingMoneyLabel.font = kTextThinFont;
    self.receiveingMoneyLabel.textColor = kDSYTextGrayColor_102;
    
    self.expiredStatusLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_expiredStatusLabel];
    self.expiredStatusLabel.font = kTextThinFont;
    self.expiredStatusLabel.textColor = kDSYTextGrayColor_102;
    
    self.deadLineDateLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_deadLineDateLabel];
    self.deadLineDateLabel.font = kTextThinFont;
    self.deadLineDateLabel.textColor = kDSYTextGrayColor_102;
    
    self.actualDateLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_actualDateLabel];
    self.actualDateLabel.font = kTextThinFont;
    self.actualDateLabel.textColor = kDSYTextGrayColor_102;
}


- (void)layoutSubviews {
    [super  layoutSubviews];
    
    self.bgView.frame = CGRectMake(X(12), Y(12), self.contentView.width - 2 * X(12), self.contentView.height - Y(24));
    
    self.titleLabel.frame = CGRectMake(X(15), Y(10), (self.bgView.width - X(30)) / 2, H(26));
    
    self.statusLabel.frame = CGRectMake(self.titleLabel.maxX, self.titleLabel.y, self.titleLabel.width, self.titleLabel.height);
    
    self.receiveingMoneyLabel.frame = CGRectMake(self.titleLabel.x, self.titleLabel.maxY + Y(5), self.titleLabel.width * 2 , H(25));
    
    self.expiredStatusLabel.frame = CGRectMake(self.receiveingMoneyLabel.x, self.receiveingMoneyLabel.maxY, self.receiveingMoneyLabel.width, self.receiveingMoneyLabel.height);
    
    self.deadLineDateLabel.frame = CGRectMake(self.expiredStatusLabel.x, self.expiredStatusLabel.maxY, self.expiredStatusLabel.width, self.expiredStatusLabel.height);
    
    self.actualDateLabel.frame = CGRectMake(self.deadLineDateLabel.x, self.deadLineDateLabel.maxY, self.deadLineDateLabel.width, self.deadLineDateLabel.height);
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
