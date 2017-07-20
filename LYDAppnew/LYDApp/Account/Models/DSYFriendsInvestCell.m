//
//  DSYFriendsInvestCell.m
//  LYDApp
//
//  Created by dai yi on 2017/1/2.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "DSYFriendsInvestCell.h"

@interface DSYFriendsInvestCell ()

@property (nonatomic, strong) UILabel *financingNameLabel;       /**< 理财名称 */
@property (nonatomic, strong) UILabel *startDateLabel;           /**< 开始日期, 结束日期 */

@property (nonatomic, strong) UILabel *investAmountLabel;        /**< 投资本金(优惠券金额) */

@property (nonatomic, strong) UILabel *earningLabel;             /**< 收益 */


@end

@implementation DSYFriendsInvestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYFriendsInvestCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"DSYFriendsInvestCell";
    DSYFriendsInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYFriendsInvestCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    }
    return cell;
}

- (void)setFinancing:(DSYFinancingModel *)financing {
    if (_financing != financing) {
        _financing = financing;
    }
    [self updateUI];
}



- (void)updateUI {
    //    CGFloat nameWith = [Helper widthOfString:self.financing.title font:self.financingNameLabel.font height:self.financingNameLabel.font.lineHeight];
    self.financingNameLabel.text = self.financing.bidTitle;
    if (self.financing.bidTitle.length > 4) {
        self.financingNameLabel.text = [NSString stringWithFormat:@"%@\n%@", [self.financing.bidTitle substringToIndex:4], [self.financing.bidTitle substringFromIndex:4]];
    }
    
    self.startDateLabel.text = [NSString stringWithFormat:@"%@\n%@", [[NSDate dateWithTimeIntervalSince1970:[self.financing.createTime integerValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"], [[NSDate dateWithTimeIntervalSince1970:[self.financing.repayTime integerValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"]];
    
    self.investAmountLabel.text = [NSString stringWithFormat:@"%.0f\n%.0f", self.financing.amount, self.financing.voucherAmount];
    self.earningLabel.text = [NSString stringWithFormat:@"%.2f", self.financing.totalIncome];
    
}

- (void)updateTransersUI {
    self.financingNameLabel.text = self.transers.bidTitle;
    if (self.transers.bidTitle.length > 4) {
        self.financingNameLabel.text = [NSString stringWithFormat:@"%@\n%@", [self.transers.bidTitle substringToIndex:4], [self.transers.bidTitle substringFromIndex:4]];
    }
    
    self.startDateLabel.text = [NSString stringWithFormat:@"%@\n%@", [[NSDate dateWithTimeIntervalSince1970:[self.transers.investTime integerValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"], [[NSDate dateWithTimeIntervalSince1970:[self.transers.repayTime integerValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"]];
    
    self.investAmountLabel.text = [NSString stringWithFormat:@"%.0f\n%.0f", self.transers.investAmount, self.transers.couponAmount];
    self.earningLabel.text = [NSString stringWithFormat:@"%.2f", self.transers.totalIncome];
}

- (void)creatSubviews {
    self.financingNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.financingNameLabel];
    self.financingNameLabel.numberOfLines = 0;
    
    self.startDateLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.startDateLabel];
    self.startDateLabel.numberOfLines = 0;
    
    self.investAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.investAmountLabel];
    self.investAmountLabel.numberOfLines = 0;
    
    self.earningLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.earningLabel];
    self.earningLabel.numberOfLines = 0;
    
    CGFloat lMargin = 2.5;
    CGFloat rMargin = -2.5;
    
    [self.financingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.right.equalTo(self.startDateLabel.mas_left).with.offset(rMargin);
        make.width.equalTo(self.startDateLabel);
    }];
    
    [self.startDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.investAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.financingNameLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    [self.investAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.earningLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.startDateLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    [self.earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.investAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:DSYImage(@"indicator_icon.png")];
    [self.contentView addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(indicatorView.size);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
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
