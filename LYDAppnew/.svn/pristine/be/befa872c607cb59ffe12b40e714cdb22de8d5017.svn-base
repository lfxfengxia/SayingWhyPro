//
//  XYPlanDetailCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYPlanDetailCell.h"

@interface XYPlanDetailCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *userNameLabel;
@property (nonatomic, strong) UILabel   *cardNumberLabel;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *lastTimeLabel;
@property (nonatomic, strong) UILabel   *lastTimeTextLabel;
@property (nonatomic, strong) UILabel   *totalMoneyLabel;
@property (nonatomic, strong) UILabel   *totalMoneyTextLabel;
@end


@implementation XYPlanDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYPlanDetailCell";
    XYPlanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYPlanDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(15), KHeight(15), kSCREENW - (KWidth(15) * 2), KHeight(12))];
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.titleLabel.textColor = TEXTBLACK;
    [self.contentView addSubview:self.titleLabel];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.maxY + KHeight(9), KWidth(80), KHeight(12))];
    self.userNameLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.userNameLabel.textColor = TEXTBLACK;
    [self.contentView addSubview:self.userNameLabel];
    
    self.cardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userNameLabel.maxX + KWidth(22), self.userNameLabel.y, kSCREENW - KWidth(15) - self.userNameLabel.maxX - KWidth(22), KHeight(12))];
    self.cardNumberLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.cardNumberLabel.textColor = TEXTBLACK;
    self.cardNumberLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.cardNumberLabel];
    
    CGFloat labelW = KWidth(150/2);
    CGFloat hMargin = (kSCREENW - (KWidth(150/2) * 3) - (KWidth(77/2) * 2)) / 2;
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(77/2), self.userNameLabel.maxY + KHeight(21), labelW, KHeight(14))];
    self.rateLabel.textColor = ORANGECOLOR;
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.rateLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + KHeight(10), self.rateLabel.width, KHeight(11))];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"借款利率";
    [self.contentView addSubview:self.rateTextLabel];
    
    self.lastTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX + hMargin, self.rateLabel.y, labelW, self.rateLabel.height)];
    self.lastTimeLabel.textColor = [UIColor blackColor];
    self.lastTimeLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.lastTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.lastTimeLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.lastTimeLabel];
    
    self.lastTimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lastTimeLabel.x, self.rateTextLabel.y, self.lastTimeLabel.width, self.rateTextLabel.height)];
    self.lastTimeTextLabel.textColor = TEXTGARY;
    self.lastTimeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.lastTimeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.lastTimeTextLabel.text = @"剩余期限";
    [self.contentView addSubview:self.lastTimeTextLabel];
    
    self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lastTimeLabel.maxX + hMargin, self.lastTimeLabel.y, labelW, self.lastTimeLabel.height)];
    self.totalMoneyLabel.textColor = [UIColor blackColor];
    self.totalMoneyLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.totalMoneyLabel];
    
    self.totalMoneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.totalMoneyLabel.x, self.lastTimeTextLabel.y, self.totalMoneyLabel.width, self.lastTimeTextLabel.height)];
    self.totalMoneyTextLabel.textColor = TEXTGARY;
    self.totalMoneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.totalMoneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyTextLabel.text = @"合同金额";
    [self.contentView addSubview:self.totalMoneyTextLabel];

}

- (void)setModel:(XYPlanDetailModel *)model
{
    _model = model;
    
    self.titleLabel.text = [NSString stringWithFormat:@"借款项目：%@",model.title];
    
    if (model.borrowerName.length > 2) {
        NSString *userName = [model.borrowerName stringByReplacingCharactersInRange:NSMakeRange(model.borrowerName.length - 2, 2) withString:@"**"];
        self.userNameLabel.text = [NSString stringWithFormat:@"借款人：%@",userName];
    } else {
        NSString *userName = [model.borrowerName stringByReplacingCharactersInRange:NSMakeRange(model.borrowerName.length - 1, 1) withString:@"*"];
        self.userNameLabel.text = [NSString stringWithFormat:@"借款人：%@",userName];
    }
    
    NSString *cardNo = [model.borrowerCard stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
    self.cardNumberLabel.text = [NSString stringWithFormat:@"身份证：%@",cardNo];

    NSMutableAttributedString *rateAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f%%",[model.apr floatValue] * 100]];
    [rateAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(15)] range:NSMakeRange(rateAttr.length - 1, 1)];
    self.rateLabel.attributedText = rateAttr;
    
    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@周",model.periodsLeft]];
    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(15)] range:NSMakeRange(timeAttr.length - 1, 1)];
    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(timeAttr.length - 1, 1)];
    self.lastTimeLabel.attributedText = timeAttr;
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.loanAmount]];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(15)] range:NSMakeRange(moneyAttr.length - 1, 1)];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange(moneyAttr.length - 1, 1)];
    self.totalMoneyLabel.attributedText = moneyAttr;
    
}

+ (CGFloat)cellHeight
{
    return KHeight(236/2);
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
