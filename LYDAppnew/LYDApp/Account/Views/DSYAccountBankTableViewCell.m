//
//  DSYAccountBankTableViewCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccountBankTableViewCell.h"


@interface DSYAccountBankTableViewCell ()


@property (nonatomic, strong) UIView *labelView;    /**< 卡号视图区域 */
@property (nonatomic, strong) UIView *showLabelView;
@property (nonatomic, strong) ZWVerticalAlignLabel *showLabel;

@end

@implementation DSYAccountBankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubviews];
    }
    return self;
}


+ (DSYAccountBankTableViewCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"accountBankTableViewCell";
    DSYAccountBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYAccountBankTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (void)creatSubviews {
    self.iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    
    self.defaultLabel = [[UILabel alloc] init];
    [self.iconView addSubview:_defaultLabel];
    _defaultLabel.layer.cornerRadius = X(3);
    _defaultLabel.text = @"默认";
    _defaultLabel.textColor = [UIColor whiteColor];
    _defaultLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    _defaultLabel.layer.borderWidth = X(0.5);
    _defaultLabel.textAlignment = NSTextAlignmentCenter;
    
    self.labelView = [[UIView alloc] init];
    [self.iconView addSubview:_labelView];
    
    self.cardNumberLabel = [[ZWVerticalAlignLabel alloc] init];
    [self.labelView addSubview:_cardNumberLabel];
    _cardNumberLabel.font = [UIFont systemFontOfSize:W(29.0f)];
    _cardNumberLabel.textColor = [UIColor whiteColor];
    
    self.showLabelView = [[UIView alloc] init];
    [self.labelView addSubview:_showLabelView];
    
    self.showLabel = [[ZWVerticalAlignLabel alloc] init];
    [self.showLabelView addSubview:_showLabel];
    _showLabel.font = [UIFont systemFontOfSize:W(29.0f)];
    _showLabel.textColor = [UIColor whiteColor];
    
    self.bankNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:[UIColor whiteColor] fontOfSystemSize:W(18) isBold:YES];
    [self.iconView addSubview:self.bankNameLabel];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView).with.offset(X(10));
        make.top.equalTo(self.iconView).with.offset(Y(7));
        make.height.mas_equalTo(H(26));
        make.right.equalTo(self.iconView.mas_centerX).with.offset(0);
    }];
    self.bankNameLabel.textAlignment = NSTextAlignmentLeft;
    UILabel *showLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:[UIColor whiteColor] fontOfSystemSize:W(12.0f)];
    [self.iconView addSubview:showLabel];
    [showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView).with.offset(X(10));
        make.top.equalTo(self.bankNameLabel.mas_bottom).with.offset(Y(7));
        make.height.mas_equalTo(H(20));
        make.right.equalTo(self.iconView.mas_centerX).with.offset(0);
    }];
    showLabel.textAlignment = NSTextAlignmentLeft;
    showLabel.text = @"存储卡";
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = rgba(249, 249, 249, 1);
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    self.iconView.frame = CGRectMake(X(12), Y(7.5), self.contentView.width - 2 * X(12), self.contentView.height - 2 * Y(7.5));
    self.defaultLabel.frame = CGRectMake(self.iconView.width - X(60 + 10), Y(10), W(60), H(30));
    
    self.labelView.frame = CGRectMake(self.iconView.width - W(280), self.iconView.height - H(50), W(270), H(30));
    self.cardNumberLabel.frame = CGRectMake(self.labelView.width - W(65), 0, W(65), self.labelView.height);
    [self.cardNumberLabel fixSingleWidthForRight];
    [self.cardNumberLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_bottom);
    }];
    
    self.showLabelView.frame = CGRectMake(0, 0, self.cardNumberLabel.x, self.labelView.height);
    
    self.showLabel.text = @"**** **** ****";
    self.showLabel.frame = self.showLabelView.bounds;
    [self.showLabel fixSingleWidth];
    
    [self.showLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_bottom).addAlignType(textAlignType_right);
    }];
    self.showLabelView.transform = CGAffineTransformMakeRotation(M_PI);

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
