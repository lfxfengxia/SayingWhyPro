//
//  DSYInvestGroupCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYInvestGroupCell.h"
#import "DSYInvestGroupModel.h"

@interface DSYInvestGroupCell ()

@property (nonatomic, strong) UILabel *brorrowerNameLabel;        /**< 借款人 */
@property (nonatomic, strong) UILabel *borrowAmountLabel;         /**< 借款金额 */

@property (nonatomic, strong) UILabel *codeLabel;                 /**< 合同编号 */

@property (nonatomic, strong) UILabel *investAmountLabel;         /**< 投资金额 */

@end

@implementation DSYInvestGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYInvestGroupCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"DSYInvestGroupCell";
    DSYInvestGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYInvestGroupCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    }
    return cell;
}


- (void)setInvestGroup:(DSYInvestGroupModel *)investGroup {
    if (_investGroup != investGroup) {
        _investGroup = investGroup;
    }
    [self updateUI];
}


- (void)updateUI {
    //    CGFloat nameWith = [Helper widthOfString:self.financing.title font:self.financingNameLabel.font height:self.financingNameLabel.font.lineHeight];
    NSString *tt=[NSString stringWithFormat:@"%@", [self.investGroup.borrowerName substringWithRange:NSMakeRange(0,1)]];
   //
    
    
    
    for (int i=0;i<(self.investGroup.borrowerName.length-2); i++) {
      tt=[tt stringByAppendingString:@"*"];
    }
    
//    self.brorrowerNameLabel.text = [NSString stringWithFormat:@"*%@", [self.investGroup.borrowerName substringFromIndex:1]];
    
    self.brorrowerNameLabel.text =tt;

    self.borrowAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.investGroup.borrowAmount];
    self.codeLabel.text = self.investGroup.contractNo;
    self.investAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.investGroup.investAmount];
    
}

- (NSString *)getPhoneStr {
    NSString *str = nil;
    if (self.investGroup.borrowerMobile.length > 3) {
        str = [NSString stringWithFormat:@"%@****", [self.investGroup.borrowerMobile substringToIndex:3]];
    }
    
    if (self.investGroup.borrowerMobile.length >7) {
        str = [NSString stringWithFormat:@"%@%@", str, [self.investGroup.borrowerMobile substringFromIndex:7]];
    }
    
    if (str.length > 11) {
        str = [str substringToIndex:11];
    }

    return str;
}

- (void)creatSubviews {
    self.brorrowerNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.brorrowerNameLabel];
    self.brorrowerNameLabel.numberOfLines = 0;
    
    self.borrowAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.borrowAmountLabel];
    self.borrowAmountLabel.numberOfLines = 0;
    
    self.codeLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.codeLabel];
    self.codeLabel.numberOfLines = 0;
    
    self.investAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.investAmountLabel];
    self.investAmountLabel.numberOfLines = 0;
    
    CGFloat lMargin = 2.5;
    CGFloat rMargin = -2.5;
    
    [self.brorrowerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(X(10));
        make.right.equalTo(self.borrowAmountLabel.mas_left).with.offset(rMargin);
        make.width.equalTo(self.borrowAmountLabel).with.offset(X(-10));
    }];
    self.brorrowerNameLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.borrowAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.codeLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.brorrowerNameLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.brorrowerNameLabel).with.offset(X(10));
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.investAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.borrowAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.borrowAmountLabel);
    }];
    
    [self.investAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.codeLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.borrowAmountLabel);
    }];
    
    
    
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
