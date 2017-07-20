//
//  DSYCouponSelectViewCell.m
//  LYDApp
//
//  Created by dai yi on 2016/12/22.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCouponSelectViewCell.h"
#import "DSYCouponModel.h"

@interface DSYCouponSelectViewCell ()


@property (nonatomic, strong) UILabel *limitLabel;
@property (nonatomic, strong) UIView  *iconView;
@property (nonatomic, strong) UILabel *productsLabel;
@property (nonatomic, strong) UILabel *expireDateLabel;

@end

@implementation DSYCouponSelectViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYCouponSelectViewCell *)cellForTableView:(UITableView *)tableView {
    static NSString *identifier = @"DSYCouponSelectViewCell";
    DSYCouponSelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DSYCouponSelectViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setModel:(DSYCouponModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self updateUI];
}

- (void)updateUI {
    self.amoutNameLabel.attributedText = [self titleGetAttributeString];
    self.limitLabel.text = [NSString stringWithFormat:@"使用限制: 投资金额满%.0f元", self.model.minInvestAmount];
    self.productsLabel.text = [NSString stringWithFormat:@"适用标的: %@", self.model.products];
    self.expireDateLabel.text = [NSString stringWithFormat:@"到期日期: %@", [[NSDate dateWithTimeIntervalSince1970:self.model.expireTime / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"]];
}

- (NSMutableAttributedString *)titleGetAttributeString {
    NSString *firstStr = nil;
    NSString *secondStr = nil;
    NSString *thirdStr = nil;
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    NSAttributedString *firstAttri = nil;
    NSAttributedString *secondAttri = nil;
    NSAttributedString *thirdAttri = nil;
    
    UIFont *semiBoldFont = [UIFont systemFontOfSize:W(24.0f) weight:UIFontWeightSemibold];
    if (self.model.type == 2) {
        firstStr = @"￥";
        secondStr = [NSString stringWithFormat:@"%0.0f元", self.model.amount];
        thirdStr = @" 现金抵用券";
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:rgba(252, 120, 35, 1), NSFontAttributeName:DSY_NORMALFONT_12}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:rgba(252, 120, 35, 1), NSFontAttributeName:DSY_NORMALFONT_12}];
        
        
    } else {
        firstStr = [NSString stringWithFormat:@"+%.2f", self.model.amount];
        secondStr = @"%";
        thirdStr = @" 加息券";
        
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:rgba(243, 104, 103, 1), NSFontAttributeName:semiBoldFont}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:rgba(243, 104, 103, 1), NSFontAttributeName:DSY_NORMALFONT_12}];
    }
    thirdAttri = [[NSAttributedString alloc] initWithString:thirdStr attributes:@{NSForegroundColorAttributeName:rgba(102, 102, 102, 1), NSFontAttributeName:DSY_NORMALFONT_11}];
    
    
    [attributeString appendAttributedString:firstAttri];
    [attributeString appendAttributedString:secondAttri];
    [attributeString appendAttributedString:thirdAttri];
    
    
    return attributeString;
}



- (void)creatSubviews {
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREENW * 3 / 4);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(Y(4));
        make.bottom.equalTo(self.contentView).with.offset(Y(-4));
        
    }];
    self.bgView = bgView;
    
    self.amoutNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(8.0f)];
    [bgView addSubview:self.amoutNameLabel];
    self.amoutNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.limitLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(10.0f)];
    [bgView addSubview:self.limitLabel];
    self.limitLabel.textAlignment = NSTextAlignmentLeft;
    
    self.productsLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(10.0f)];
    [bgView addSubview:self.productsLabel];
    self.productsLabel.textAlignment = NSTextAlignmentLeft;
    
    self.expireDateLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(10.0f)];
    [bgView addSubview:self.expireDateLabel];
    self.expireDateLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    [self.amoutNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(X(12));
        make.top.equalTo(bgView).with.offset(Y(12));
        make.height.mas_equalTo(H(15));
        make.right.equalTo(bgView).with.offset(X(-12));
    }];
    
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(X(12));
        make.top.equalTo(self.amoutNameLabel.mas_bottom).with.offset(Y(8));
        make.height.mas_equalTo(H(15));
        make.right.equalTo(bgView).with.offset(X(-12));
    }];
    
    [self.productsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(X(12));
        make.top.equalTo(self.limitLabel.mas_bottom).with.offset(Y(0));
        make.height.mas_equalTo(H(15));
        make.right.equalTo(bgView).with.offset(X(-12));
    }];
    
    [self.expireDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).with.offset(X(12));
        make.top.equalTo(self.productsLabel.mas_bottom).with.offset(Y(0));
        make.height.mas_equalTo(H(15));
        make.right.equalTo(bgView).with.offset(X(-12));
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
