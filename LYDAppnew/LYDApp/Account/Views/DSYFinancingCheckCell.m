//
//  DSYFinancingCheckCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingCheckCell.h"
#import "DSYCheckModel.h"

@interface DSYFinancingCheckCell ()

@property (nonatomic, strong) UILabel *financingNameLabel;       /**< 理财名称 */
@property (nonatomic, strong) UILabel *backAmountLabel;           /**< 回款金额 */

@property (nonatomic, strong) UILabel *backDateLabel;        /**< 回款日期 */

@property (nonatomic, strong) UILabel *actualDateLabel;             /**< 实际回款日期 */

@end

@implementation DSYFinancingCheckCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYFinancingCheckCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"DSYFinancingNewCell";
    DSYFinancingCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYFinancingCheckCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    }
    return cell;
}

- (void)setCheck:(DSYCheckModel *)check {
    if (_check != check) {
        _check = check;
    }
    [self updateUI];
}

- (void)updateUI {
    //    CGFloat nameWith = [Helper widthOfString:self.financing.title font:self.financingNameLabel.font height:self.financingNameLabel.font.lineHeight];
    self.financingNameLabel.text = self.check.title;
    if (self.check.title.length > 4) {
        self.financingNameLabel.text = [NSString stringWithFormat:@"%@\n%@", [self.check.title substringToIndex:4], [self.check.title substringFromIndex:4]];
    }
    self.backAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.check.receiveAmount];
    self.backDateLabel.text = [[NSDate dateWithTimeIntervalSince1970:([self.check.receiveTime doubleValue] / 1000)] getDateStringWithFormatterStr:@"yyyy-MM-dd"];
    
//    if ([self.check.realReceiveTime integerValue] / 1000 == 0) {
//        self.actualDateLabel.text = @"----";
//        self.actualDateLabel.textColor = ORANGECOLOR;
//    } else {
//        self.actualDateLabel.text = [[NSDate dateWithTimeIntervalSince1970:[self.check.realReceiveTime integerValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"];
//        self.actualDateLabel.textColor = RGB(102, 102, 102);
//    }
    
}

- (void)creatSubviews {
    self.financingNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    self.financingNameLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.financingNameLabel];
    self.financingNameLabel.numberOfLines = 0;
    
    self.backAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    self.backAmountLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.backAmountLabel];
    self.backAmountLabel.numberOfLines = 0;
    
    self.backDateLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    self.backDateLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.backDateLabel];
    self.backDateLabel.numberOfLines = 0;
    
//    self.actualDateLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
//    [self.contentView addSubview:self.actualDateLabel];
//    self.actualDateLabel.numberOfLines = 0;
    
    CGFloat lMargin = 2.5;
    CGFloat rMargin = -2.5;
    
    [self.financingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(X(10));
        make.right.equalTo(self.backAmountLabel.mas_left).with.offset(rMargin);
        make.width.equalTo(self.backAmountLabel).with.offset(X(-10));
    }];
    self.financingNameLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [self.backAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.backDateLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.financingNameLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel).with.offset(X(10));
    }];
    
    [self.backDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.backAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.backAmountLabel);
    }];
    
//    [self.actualDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.contentView);
//        make.right.equalTo(self.contentView.mas_right).with.offset(0);
//        make.left.equalTo(self.backDateLabel.mas_right).with.offset(lMargin);
//        make.width.equalTo(self.backAmountLabel);
//    }];
    
    
    
//    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:DSYImage(@"indicator_icon.png")];
//    [self.contentView addSubview:indicatorView];
//    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(indicatorView.size);
//        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
//        make.right.equalTo(self.contentView.mas_right).with.offset(X(-4));
//    }];
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
