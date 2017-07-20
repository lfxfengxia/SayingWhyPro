//
//  DSYFinancingInvestTCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingInvestCell.h"

#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kDSYTextGrayColor_51  rgba( 51,  51,  51, 1)
#define kDSYTextGrayColor_153 rgba(153, 153, 153, 1)
#define kTextThinFont [UIFont systemFontOfSize:W(11.0f) weight:UIFontWeightThin]

@interface DSYFinancingInvestCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *deadLineDateLabel;
@property (nonatomic, strong) UILabel *annulRateLabel;

@property (nonatomic, strong) UILabel *borrowAmountLabel;
@property (nonatomic, strong) UILabel *myInvestAmountLabel;

@end

@implementation DSYFinancingInvestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYFinancingInvestCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"financingInvestCell";
    DSYFinancingInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYFinancingInvestCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (void)creatSubviews {
    
    [self bgView];
    [self addressLabel];
    [self deadLineDateLabel];
    [self annulRateLabel];
    [self borrowAmountLabel];
    [self myInvestAmountLabel];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    self.addressLabel.text = @"浙江省-杭州市-余杭......";
    self.deadLineDateLabel.text = [NSString stringWithFormat:@"到期时间: %@", @"2017-05-14"];
    self.annulRateLabel.text    = [NSString stringWithFormat:@"%ld%%", (NSInteger)(0.19 * 100)];
    self.borrowAmountLabel.text = [NSString stringWithFormat:@"%d元", 6000];
    self.myInvestAmountLabel.text = [NSString stringWithFormat:@"%d元", 1000];
                                   
}


- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(100))];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(X(12), Y(8), (self.bgView.width - X(24)) / 2, H(20)) andTextColor:kDSYTextGrayColor_102 fontOfSystemSize:KWidth(12.0f)];
        [self.bgView addSubview:_addressLabel];
    }
    return _addressLabel;
}

- (UILabel *)deadLineDateLabel {
    if (!_deadLineDateLabel) {
        _deadLineDateLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(self.addressLabel.maxX, self.addressLabel.y, self.addressLabel.width, self.addressLabel.height) andTextColor:kDSYTextGrayColor_153 fontOfSystemSize:KWidth(11.0f)];
        [self.bgView addSubview:_deadLineDateLabel];
        _deadLineDateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _deadLineDateLabel;
}

- (UILabel *)annulRateLabel {
    if (!_annulRateLabel) {
        _annulRateLabel = [self creatLabelWithTag:0 title:@"年化利率"];
    }
    return _annulRateLabel;
}

- (UILabel *)borrowAmountLabel {
    if (!_borrowAmountLabel) {
        _borrowAmountLabel = [self creatLabelWithTag:1 title:@"借款金额"];
    }
    return _borrowAmountLabel;
}

- (UILabel *)myInvestAmountLabel {
    if (!_myInvestAmountLabel) {
        _myInvestAmountLabel = [self creatLabelWithTag:2 title:@"我的投资金额"];
    }
    return _myInvestAmountLabel;
}

- (UILabel *)creatLabelWithTag:(NSInteger)tag title:(NSString *)title {
    CGFloat width = self.bgView.width / 3;
    UIView *labelBgView = [[UIView alloc] initWithFrame:CGRectMake(tag * width, 0, width, H(50))];
    [self.bgView addSubview:labelBgView];
    labelBgView.centerY = (self.bgView.height - self.addressLabel.maxY) / 2 + self.addressLabel.maxY;
    
    UIColor *textColor = nil;
    CGFloat fontSize = 0;
    if (tag == 0) {
        textColor = ORANGECOLOR;
        fontSize = KWidth(18.0f);
    } else {
        textColor = kDSYTextGrayColor_51;
        fontSize = KWidth(15.0f);
    }
    
    UILabel *returnLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, 0, width, H(28)) andTextColor:textColor fontOfSystemSize:fontSize];
    [labelBgView addSubview:returnLabel];
    returnLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, returnLabel.maxY, width, H(22)) andTextColor:kDSYTextGrayColor_153 fontOfSystemSize:KWidth(11.0f)];
    [labelBgView addSubview:showLabel];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.text = title;
    
    
    return returnLabel;
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
