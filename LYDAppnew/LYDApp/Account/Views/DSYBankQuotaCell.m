//
//  DSYBankQuotaCell.m
//  LYDApp
//
//  Created by dai yi on 2017/1/3.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYBankQuotaCell.h"
#import "DSYBankLimitModel.h"

@interface DSYBankQuotaCell ()

@property (nonatomic, strong) UILabel *bankNameLabel;       /**< 银行卡名称 */
@property (nonatomic, strong) UILabel *characterLabel;           /**< 银行卡性质 */

@property (nonatomic, strong) UILabel *singleAmountLabel;        /**< 单笔限额 */

@property (nonatomic, strong) UILabel *dayAmountLabel;           /**< 单卡单日限额 */


@end

@implementation DSYBankQuotaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYBankQuotaCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"DSYBankQuotaCell";
    DSYBankQuotaCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYBankQuotaCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        [cell.contentView insertLayoutLineWithWidth:H(1.5) align:(UIViewLineAlignmentBottom)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setLimit:(DSYBankLimitModel *)limit {
    if (_limit != limit) {
        _limit = limit;
    }
    [self updateUI];
}

- (void)updateUI {
    self.bankNameLabel.text     = self.limit.bankName;
    self.singleAmountLabel.text = [self showWithAmount:self.limit.singleTransQuota];
    self.dayAmountLabel.text    = [self showWithAmount:self.limit.cardDailyTransQuota];
    
}

- (NSString *)showWithAmount:(CGFloat)amount {
    NSString *str = @"";
    
    NSInteger tempAmount = (NSInteger)(amount / 1000);
    if (tempAmount % 10 == 0) {
        str = [NSString stringWithFormat:@"%ld万元", tempAmount / 10];
    } else {
        str = [NSString stringWithFormat:@"%.1f万元", tempAmount * 1.0 / 10];
    }
    
    return str;
}

- (void)creatSubviews {
    self.bankNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.bankNameLabel];
    self.bankNameLabel.numberOfLines = 0;
    
    self.characterLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.characterLabel];
    self.characterLabel.numberOfLines = 0;
    self.characterLabel.text = @"借记卡";
    
    self.singleAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.singleAmountLabel];
    self.singleAmountLabel.numberOfLines = 0;
    
    self.dayAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.dayAmountLabel];
    self.dayAmountLabel.numberOfLines = 0;
    
    CGFloat lMargin = 1.5;
    CGFloat rMargin = -1.5;
    
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.right.equalTo(self.characterLabel.mas_left).with.offset(rMargin);
        make.width.equalTo(self.characterLabel);
    }];
    
    [self.characterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.singleAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.bankNameLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.bankNameLabel);
    }];
    
    [self.singleAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.dayAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.characterLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.bankNameLabel);
    }];
    
    [self.dayAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.singleAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.bankNameLabel);
    }];
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
