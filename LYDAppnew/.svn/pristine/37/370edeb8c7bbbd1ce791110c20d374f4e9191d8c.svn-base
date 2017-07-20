//
//  DSYCouponThirdCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCouponThirdCell.h"
#import "DSYCouponModel.h"

#define kTextColorGray rgba(194, 183, 176, 1)

@interface DSYCouponThirdCell ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIView *labelBgView;
@property (nonatomic, strong) UILabel *titleLabel;     /**< 优惠券的title */

@property (nonatomic, strong) UILabel *codeLabel;      /**< 优惠券编码 */
@property (nonatomic, strong) UILabel *useLimitLabel;  /**< 适用限制 */
@property (nonatomic, strong) UILabel *usescopeLabel;  /**< 适用标的 */
@property (nonatomic, strong) UILabel *dateLabel;      /**< 使用期限 */
@property (nonatomic, strong) UIButton *investBtn;     /**< 立即投资按钮 */

@end

@implementation DSYCouponThirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYCouponThirdCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"couponFourthCell";
    DSYCouponThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYCouponThirdCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (void)setCoupon:(DSYCouponModel *)coupon {
    if (_coupon != coupon) {
        _coupon = coupon;
    }
    [self updateUI];
}

- (void)updateUI {
    
    self.bgView.image = DSYImage(@"account_coupon_overduebg.png");
    
    self.codeLabel.text = [NSString stringWithFormat:@"优惠券码: %@", self.coupon.code];
    
    self.useLimitLabel.text = [NSString stringWithFormat:@"使用限制: 投资金额满%.0f元", self.coupon.minInvestAmount];
    self.usescopeLabel.text = [NSString stringWithFormat:@"适用标的: %@", self.coupon.products];
    NSString *startDate =  [[NSDate dateWithTimeIntervalSince1970:self.coupon.createTime / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"];
    NSString *endDate = [[NSDate dateWithTimeIntervalSince1970:self.coupon.expireTime / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"];
    self.dateLabel.text = [NSString stringWithFormat:@"有效日期: %@ 至 %@", startDate, endDate];
    self.titleLabel.attributedText = [self titleGetAttributeString];
}


- (void)creatSubviews {
    self.bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgView];
    
    self.labelBgView = [[UIView alloc] init];
    [self.bgView addSubview:_labelBgView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_titleLabel];
    
    self.codeLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_codeLabel];
    self.codeLabel.font = DSY_NORMALFONT_11;
    self.codeLabel.textColor = kTextColorGray;
    
    self.useLimitLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_useLimitLabel];
    self.useLimitLabel.font = DSY_NORMALFONT_11;
    self.useLimitLabel.textColor = kTextColorGray;
    
    self.usescopeLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_usescopeLabel];
    self.usescopeLabel.font = DSY_NORMALFONT_11;
    self.usescopeLabel.textColor = kTextColorGray;
    
    self.dateLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_dateLabel];
    self.dateLabel.font = DSY_NORMALFONT_11;
    self.dateLabel.textColor = kTextColorGray;
    
    self.investBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bgView addSubview:_investBtn];
    [_investBtn setTitle:@"已使用" forState:(UIControlStateNormal)];
    [_investBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _investBtn.titleLabel.font = [UIFont systemFontOfSize:W(17.0f) weight:UIFontWeightSemibold];
    _investBtn.alpha = 0.5;
}

- (void)layoutSubviews {
    self.bgView.frame = CGRectMake(0, 0, W(350), H(120));
    self.bgView.center = self.contentView.center;
    
    self.labelBgView.frame = CGRectMake(0, 0, W(265), self.bgView.height);
    
    self.investBtn.frame = CGRectMake(self.labelBgView.maxX, 0, self.bgView.width - self.labelBgView.maxX, self.bgView.height);
    
    CGFloat startX = X(12);
    CGFloat width = self.labelBgView.width - 2 * startX;
    CGFloat heigth = H(18);
    
    self.titleLabel.frame = CGRectMake(startX, Y(8), width, H(32));
    
    self.codeLabel.frame = CGRectMake(startX, self.titleLabel.maxY, width, heigth);
    
    self.useLimitLabel.frame = CGRectMake(startX, self.codeLabel.maxY, width, heigth);
    
    self.usescopeLabel.frame = CGRectMake(startX, self.useLimitLabel.maxY, width, heigth);
    
    self.dateLabel.frame = CGRectMake(startX, self.usescopeLabel.maxY, width, heigth);
    
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
    if (self.coupon.type == 2 || self.coupon.type == 1) {
        firstStr = @"￥";
        secondStr = [NSString stringWithFormat:@"%0.0f元", self.coupon.amount];
        thirdStr = @" 现金抵用券";
        if (self.coupon.type == 1) {
            thirdStr = @" 体验金";
        }
        
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:kTextColorGray, NSFontAttributeName:DSY_NORMALFONT_14}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:kTextColorGray, NSFontAttributeName:DSY_NORMALFONT_14}];
        
        
    } else if(self.coupon.type == 3) {
        firstStr = [NSString stringWithFormat:@"+%.2f", self.coupon.amount];
        secondStr = @"%";
        thirdStr = @" 加息券";
        
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:kTextColorGray, NSFontAttributeName:semiBoldFont}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:kTextColorGray, NSFontAttributeName:DSY_NORMALFONT_14}];
    }
    thirdAttri = [[NSAttributedString alloc] initWithString:thirdStr attributes:@{NSForegroundColorAttributeName:kTextColorGray, NSFontAttributeName:DSY_NORMALFONT_11}];
    
    
    [attributeString appendAttributedString:firstAttri];
    [attributeString appendAttributedString:secondAttri];
    [attributeString appendAttributedString:thirdAttri];
    
    
    return attributeString;
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
