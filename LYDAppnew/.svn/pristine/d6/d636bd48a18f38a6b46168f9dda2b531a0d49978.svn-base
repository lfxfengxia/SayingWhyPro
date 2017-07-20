//
//  DSYCouponFirstCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYCouponFirstCell.h"
#import "DSYCouponModel.h"
#import "MBProgressHUD.h"

#define kTextColorGray_102 rgba(102, 102, 102, 1)

@interface DSYCouponFirstCell ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIView *labelBgView;
@property (nonatomic, strong) UILabel *titleLabel;     /**< 优惠券的title */

@property (nonatomic, strong) UILabel *codeLabel;      /**< 优惠券编码 */
@property (nonatomic, strong) UILabel *useLimitLabel;  /**< 适用限制 */
@property (nonatomic, strong) UILabel *usescopeLabel;  /**< 适用标的 */
@property (nonatomic, strong) UILabel *dateLabel;      /**< 使用期限 */
@property (nonatomic, strong) UIButton *investBtn;     /**< 立即投资按钮 */
@property(nonatomic,strong) UIButton *btnfuzhi;



@end

@implementation DSYCouponFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}


+ (DSYCouponFirstCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"couponSecondCell";
    DSYCouponFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYCouponFirstCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
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
    
    
    
    
    
    if (self.coupon.type == 2 || self.coupon.type == 1) {   // 现金抵用券
        self.bgView.image = DSYImage(@"account_coupon_unuse_cash.png");
    } else if (self.coupon.type == 3) {  // 加息券
        self.bgView.image = DSYImage(@"account_coupon_unuse_rate.png");
    }
    
    
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
    self.bgView.userInteractionEnabled = YES;
    
    self.labelBgView = [[UIView alloc] init];
    [self.bgView addSubview:_labelBgView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_titleLabel];
    
    self.codeLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_codeLabel];
    self.codeLabel.font = DSY_NORMALFONT_11;
    self.codeLabel.textColor = kTextColorGray_102;
    
    
    
    self.btnfuzhi=[[UIButton alloc] init];
    [self.btnfuzhi setTitle:@"复制" forState:UIControlStateNormal];
    [self.btnfuzhi addTarget:self action:@selector(copyHrefClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.btnfuzhi.font=DSY_NORMALFONT_11;
    self.btnfuzhi.backgroundColor=[UIColor orangeColor];
    [self.labelBgView addSubview:_btnfuzhi];
    
    
    
    
    
    
    self.useLimitLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_useLimitLabel];
    self.useLimitLabel.font = DSY_NORMALFONT_11;
    self.useLimitLabel.textColor = kTextColorGray_102;
    
    self.usescopeLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_usescopeLabel];
    self.usescopeLabel.font = DSY_NORMALFONT_11;
    self.usescopeLabel.textColor = kTextColorGray_102;
    
    self.dateLabel = [[UILabel alloc] init];
    [self.labelBgView addSubview:_dateLabel];
    self.dateLabel.font = DSY_NORMALFONT_11;
    self.dateLabel.textColor = kTextColorGray_102;
    
    self.investBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.bgView addSubview:_investBtn];
    
    [_investBtn setTitle:@"立即\n绑定" forState:(UIControlStateNormal)];
    [_investBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _investBtn.titleLabel.font = [UIFont systemFontOfSize:W(17.0f) weight:UIFontWeightSemibold];
    _investBtn.titleLabel.numberOfLines = 0;
    [_investBtn addTarget:self action:@selector(investBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
}




- (void)copyHrefClicked:(UITapGestureRecognizer *)tap {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //    //
    //    if (self.hrefLabel.text.length > 5) {
    //        NSString *copyString = [self.hrefLabel.text substringFromIndex:5];
    //        pasteboard.string = copyString;
    //
    ////        [RYFactoryMethod alertViewOrControllerShow:@"成功复制!" viewController:self];
    //        [MBProgressHUD showSuccess:@"你已复制了邀请链接" toView:self.view];
    //    }
    pasteboard.string = self.coupon.code;
    
    [MBProgressHUD showSuccess:@"你已复制了优惠券码" toView:self];
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
    
    self.codeLabel.frame = CGRectMake(startX, self.titleLabel.maxY, W(150), heigth);
    
    self.btnfuzhi.frame=CGRectMake(self.codeLabel.maxX+10, self.titleLabel.maxY, 40, 20);
    
    
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
        
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:rgba(252, 120, 35, 1), NSFontAttributeName:DSY_NORMALFONT_14}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:rgba(252, 120, 35, 1), NSFontAttributeName:DSY_NORMALFONT_14}];
        
        
    } else {
        firstStr = [NSString stringWithFormat:@"+%.2f", self.coupon.amount];
        secondStr = @"%";
        thirdStr = @" 加息券";
        
        firstAttri = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSForegroundColorAttributeName:rgba(243, 104, 103, 1), NSFontAttributeName:semiBoldFont}];
        secondAttri = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSForegroundColorAttributeName:rgba(243, 104, 103, 1), NSFontAttributeName:DSY_NORMALFONT_14}];
    }
    thirdAttri = [[NSAttributedString alloc] initWithString:thirdStr attributes:@{NSForegroundColorAttributeName:rgba(102, 102, 102, 1), NSFontAttributeName:DSY_NORMALFONT_11}];
    
    
    [attributeString appendAttributedString:firstAttri];
    [attributeString appendAttributedString:secondAttri];
    [attributeString appendAttributedString:thirdAttri];
    
    
    return attributeString;
}

#pragma mark - 立即投资按钮的点击方法
- (void)investBtnClicked:(UIButton *)sender {
    if (self.block) {
        self.block(self.coupon);
    }
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
