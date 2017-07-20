//
//  XYSanBidDetailCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYSanBidDetailCell.h"

@interface XYSanBidDetailCell ()

@property (nonatomic, strong) UIImageView   *userIV;
@property (nonatomic, strong) UILabel       *userInfoLabel;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UILabel       *genderLabel;
@property (nonatomic, strong) UILabel       *ageLabel;
@property (nonatomic, strong) UILabel       *salaryLabel;
@property (nonatomic, strong) UILabel       *cardNumberLabel;
@property (nonatomic, strong) UILabel       *cardAddressLabel;
@property (nonatomic, strong) UILabel       *workPlaceLabel;
@property (nonatomic, strong) UILabel       *liveAddressLabel;
@property (nonatomic, strong) UIImageView   *moneyIV;
@property (nonatomic, strong) UILabel       *moneyTextLabel;
@property (nonatomic, strong) UILabel       *timeTextLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *orderTextLabel;
@property (nonatomic, strong) UILabel       *orderLabel;
@property (nonatomic, strong) UILabel       *rateTextLabel;
@property (nonatomic, strong) UILabel       *rateLabel;
@property (nonatomic, strong) UILabel       *payWayTextLabel;
@property (nonatomic, strong) UILabel       *payWayLabel;

@end

@implementation XYSanBidDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYSanBidDetailCell";
    XYSanBidDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYSanBidDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.userIV = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(20), KWidth(22), KWidth(22))];
    self.userIV.image = [UIImage imageNamed:@"sanBidUser"];
    [self.contentView addSubview:self.userIV];
    
    self.userInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userIV.maxX + KWidth(10), KHeight(24), kSCREENW - self.userIV.maxX - KWidth(10) - KWidth(20), KHeight(14))];
    self.userInfoLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.userInfoLabel.text = @"借款人信息";
    [self.contentView addSubview:self.userInfoLabel];
    
    CGFloat shortLabelW = (kSCREENW - KWidth(20) * 3) / 2;
    CGFloat labelW = kSCREENW - KWidth(20) * 2;
    CGFloat labelH = KHeight(13);
    CGFloat hMargin = KWidth(20);
    CGFloat vMargin = KHeight(13);
    UIFont  *textFont = [UIFont systemFontOfSize:KHeight(13)];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.userIV.maxY + KHeight(19), shortLabelW, labelH)];
    self.nameLabel.textColor = TEXTBLACK;
    self.nameLabel.font = textFont;
    [self.contentView addSubview:self.nameLabel];
    
    self.genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.maxX + hMargin, self.nameLabel.y, shortLabelW, labelH)];
    self.genderLabel.textColor = TEXTBLACK;
    self.genderLabel.font = textFont;
    [self.contentView addSubview:self.genderLabel];
    
    self.ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.nameLabel.maxY + vMargin, shortLabelW, labelH)];
    self.ageLabel.textColor = TEXTBLACK;
    self.ageLabel.font = textFont;
    [self.contentView addSubview:self.ageLabel];
    
    self.salaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ageLabel.maxX + hMargin, self.ageLabel.y, shortLabelW, labelH)];
    self.salaryLabel.textColor = TEXTBLACK;
    self.salaryLabel.font = textFont;
    [self.contentView addSubview:self.salaryLabel];
    
    self.cardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.ageLabel.maxY + vMargin, labelW, labelH)];
    self.cardNumberLabel.textColor = TEXTBLACK;
    self.cardNumberLabel.font = textFont;
    [self.contentView addSubview:self.cardNumberLabel];
    
    self.cardAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.cardNumberLabel.maxY + vMargin, labelW, labelH)];
    self.cardAddressLabel.textColor = TEXTBLACK;
    self.cardAddressLabel.font = textFont;
    [self.contentView addSubview:self.cardAddressLabel];
    
    self.workPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.cardAddressLabel.maxY + vMargin, labelW, labelH)];
    self.workPlaceLabel.textColor = TEXTBLACK;
    self.workPlaceLabel.font = textFont;
    [self.contentView addSubview:self.workPlaceLabel];
    
    self.liveAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.workPlaceLabel.maxY + vMargin, labelW, labelH)];
    self.liveAddressLabel.textColor = TEXTBLACK;
    self.liveAddressLabel.font = textFont;
    [self.contentView addSubview:self.liveAddressLabel];
    
    self.moneyIV = [[UIImageView alloc] initWithFrame:CGRectMake(hMargin, self.liveAddressLabel.maxY + KHeight(36), KWidth(22), KWidth(22))];
    self.moneyIV.image = [UIImage imageNamed:@"sanBidMoney"];
    [self.contentView addSubview:self.moneyIV];
    
    self.moneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyIV.maxX + KWidth(10), self.moneyIV.y + KHeight(4), kSCREENW - self.moneyIV.maxX - KWidth(10) - KWidth(20), KHeight(14))];
    self.moneyTextLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.moneyTextLabel.text = @"借款信息";
    [self.contentView addSubview:self.moneyTextLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.moneyIV.maxY + KHeight(20), KWidth(120), KHeight(36))];
    self.timeTextLabel.textColor = TEXTBLACK;
    self.timeTextLabel.font = textFont;
    self.timeTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.timeTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.timeTextLabel.layer.borderWidth = 0.5f;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"投资到期日";
    [self.contentView addSubview:self.timeTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.maxX, self.timeTextLabel.y, kSCREENW - self.timeTextLabel.maxX - KWidth(20), KHeight(36))];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = textFont;
    self.timeLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.timeLabel.layer.borderWidth = 0.5f;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    
    self.orderTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.timeTextLabel.maxY, KWidth(120), KHeight(36))];
    self.orderTextLabel.textColor = TEXTBLACK;
    self.orderTextLabel.font = textFont;
    self.orderTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.orderTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.orderTextLabel.layer.borderWidth = 0.5f;
    self.orderTextLabel.textAlignment = NSTextAlignmentCenter;
    self.orderTextLabel.text = @"借款用途";
    [self.contentView addSubview:self.orderTextLabel];
    
    self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.orderTextLabel.maxX, self.orderTextLabel.y, kSCREENW - self.orderTextLabel.maxX - KWidth(20), KHeight(36))];
    self.orderLabel.textColor = TEXTBLACK;
    self.orderLabel.font = textFont;
    self.orderLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.orderLabel.layer.borderWidth = 0.5f;
    self.orderLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.orderLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.orderTextLabel.maxY, KWidth(120), KHeight(36))];
    self.rateTextLabel.textColor = TEXTBLACK;
    self.rateTextLabel.font = textFont;
    self.rateTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.rateTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.rateTextLabel.layer.borderWidth = 0.5f;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"借款年化利率";
    [self.contentView addSubview:self.rateTextLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.maxX, self.rateTextLabel.y, kSCREENW - self.rateTextLabel.maxX - KWidth(20), KHeight(36))];
    self.rateLabel.textColor = TEXTBLACK;
    self.rateLabel.font = textFont;
    self.rateLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.rateLabel.layer.borderWidth = 0.5f;
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rateLabel];
    
    self.payWayTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.rateTextLabel.maxY, KWidth(120), KHeight(36))];
    self.payWayTextLabel.textColor = TEXTBLACK;
    self.payWayTextLabel.font = textFont;
    self.payWayTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.payWayTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.payWayTextLabel.layer.borderWidth = 0.5f;
    self.payWayTextLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayTextLabel.text = @"借款年化利率";
    [self.contentView addSubview:self.payWayTextLabel];
    
    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payWayTextLabel.maxX, self.payWayTextLabel.y, kSCREENW - self.payWayTextLabel.maxX - KWidth(20), KHeight(36))];
    self.payWayLabel.textColor = TEXTBLACK;
    self.payWayLabel.font = textFont;
    self.payWayLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.payWayLabel.layer.borderWidth = 0.5f;
    self.payWayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.payWayLabel];
}

- (void)setModel:(XYSanBidDetailModel *)model
{
    _model = model;
    
    if (model.userName.length > 2) {
        NSString *userName = [model.userName stringByReplacingCharactersInRange:NSMakeRange(model.userName.length - 2, 2) withString:@"**"];
        self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",userName];
    } else {
        NSString *userName = [model.userName stringByReplacingCharactersInRange:NSMakeRange(model.userName.length - 1, 1) withString:@"*"];
        self.nameLabel.text = [NSString stringWithFormat:@"姓名：%@",userName];
    }
    
    self.genderLabel.text = [NSString stringWithFormat:@"性别：%@",model.gender];
    self.ageLabel.text = [NSString stringWithFormat:@"年龄：%@岁",model.age];
    self.salaryLabel.text = [NSString stringWithFormat:@"年收入：%@",model.salary];
    
    NSString *cardNo = [model.codeNumber stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
    self.cardNumberLabel.text = [NSString stringWithFormat:@"身份证号码：%@",cardNo];
    
    NSString *cardAddress = [model.cardAddress stringByReplacingCharactersInRange:NSMakeRange(model.cardAddress.length - 5, 5) withString:@"*****"];
    self.cardAddressLabel.text = [NSString stringWithFormat:@"身份证住址：%@",cardAddress];

    self.workPlaceLabel.text = [NSString stringWithFormat:@"工作单位：%@",model.wordPlace];
    
    NSString *liveAddress = [model.liveAddress stringByReplacingCharactersInRange:NSMakeRange(model.liveAddress.length - 5, 5) withString:@"*****"];
    self.liveAddressLabel.text = [NSString stringWithFormat:@"现居住地址：%@",liveAddress];
    
    self.timeLabel.text = model.time;
    self.orderLabel.text = model.order;
    self.rateLabel.text = model.rate;
    self.payWayLabel.text = model.payWay;
    
    
}

+ (CGFloat)cellHeight
{
    return KHeight(440);
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
