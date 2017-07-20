//
//  XYSanBidCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYSanBidCell.h"

@interface XYSanBidCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *timeTextLabel;
@property (nonatomic, strong) UILabel   *payWayLabel;
@property (nonatomic, strong) UILabel   *payWayTextLabel;
@property (nonatomic, strong) UIProgressView    *progressV;
@property (nonatomic, strong) UILabel   *lastAccountLabel;

@end

@implementation XYSanBidCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYSanBidCell";
    XYSanBidCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYSanBidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    
    CGFloat hMargin = (kSCREENW - (KWidth(95/2) * 3) - (KWidth(45) * 2)) / 2;
    CGFloat vMargin = KHeight(12);
    CGFloat labelW  = KWidth(95/2);
    CGFloat labelH  = KHeight(14);
    CGFloat textlabelH  = KHeight(11);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(13), KHeight(11), kSCREENW - KWidth(13) * 2, KHeight(14))];
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    [self.contentView addSubview:self.titleLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(45), self.titleLabel.maxY + KHeight(18), labelW, labelH)];
    self.rateLabel.textColor = ORANGECOLOR;
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.rateLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + vMargin, labelW, textlabelH)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.text = @"年化利率";
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rateTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX + hMargin, self.rateLabel.y, labelW, labelH)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(18)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.timeLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.x, self.timeLabel.maxY + vMargin, labelW, textlabelH)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"借款期限";
    [self.contentView addSubview:self.timeTextLabel];
    
    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.maxX + hMargin, self.timeLabel.y - KHeight(7), labelW, KHeight(28))];
    self.payWayLabel.numberOfLines = 2;
    self.payWayLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.payWayLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayLabel.textColor = TEXTBLACK;
    self.payWayLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.payWayLabel];
    
    self.payWayTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payWayLabel.x, self.timeTextLabel.y, labelW, textlabelH)];
    self.payWayTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.payWayTextLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayTextLabel.textColor = TEXTGARY;
    self.payWayTextLabel.adjustsFontSizeToFitWidth = YES;
    self.payWayTextLabel.text = @"还款方式";
    [self.contentView addSubview:self.payWayTextLabel];
    
    self.progressV = [[UIProgressView alloc] initWithFrame:CGRectMake(KWidth(20), self.rateTextLabel.maxY + KHeight(15), KWidth(472/2), KHeight(4))];
    self.progressV.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00];
    self.progressV.progressTintColor = ORANGECOLOR;
    [self.contentView addSubview:self.progressV];

    
    self.lastAccountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.progressV.maxX + KWidth(10), self.payWayTextLabel.maxY + KHeight(5), KWidth(90), KHeight(20))];
    self.lastAccountLabel.textColor = TEXTGARY;
    self.lastAccountLabel.font = [UIFont systemFontOfSize:KHeight(10)];
    self.lastAccountLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.lastAccountLabel];
    
}

- (void)setModel:(XYSanBidModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.rateLabel.text = [NSString stringWithFormat:@"%.1f%%",[model.apr floatValue] * 100];
    
    NSMutableString *period = [NSMutableString string];
    if ([model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@月",model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 2, 2)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 2, 2)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == 1) {
        period = [NSMutableString stringWithFormat:@"%@日",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == -1) {
        period = [NSMutableString stringWithFormat:@"%@年",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    } else if ([self.model.periodUnit integerValue] == 2) {
        period = [NSMutableString stringWithFormat:@"%@周",self.model.periods];
        NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
        [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
        [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
        self.timeLabel.attributedText = timeAttr;

    }
    
//    NSMutableAttributedString *timeAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",period]];
//    [timeAttr addAttribute:NSForegroundColorAttributeName value:TEXTBLACK range:NSMakeRange([timeAttr length] - 1, 1)];
//    [timeAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(13)] range:NSMakeRange([timeAttr length] - 1, 1)];
//    self.timeLabel.attributedText = timeAttr;
    NSMutableString *payWay = [NSMutableString string];
//    if ([model.repaymentType integerValue] == 2) {
//        payWay = [NSMutableString stringWithFormat:@"按月付息\n到期还本"];
//    } else {
//        payWay = [NSMutableString stringWithFormat:@"按本付息\n到期还息"];
//    }
    
    
    
    //    PAID_MONTH_EQUAL_PRINCIPAL_INTEREST(1," 按月还款、等额本息"),
    //    PAID_WEEK_EQUAL_PRINCIPAL_INTEREST(2,"按周还款、等额本息"),
    //    PAID_MONTH_ONCE_REPAYMENT(3,"按月付息、到期还本"),
    //    PAID_WEEK_ONCE_REPAYMENT(4," 按周付息、到期还本"),
    //    ONCE_REPAYMENT(5,"一次还本付息");
    
    
    
    if ([model.repaymentType integerValue] == 1) {
        payWay = [NSMutableString stringWithFormat:@"按月还款、等额本息"];
    }
    else if ([model.repaymentType integerValue] == 2){
        payWay = [NSMutableString stringWithFormat:@"按周还款、等额本息"];
    }
    else if ([model.repaymentType integerValue] == 3){
        payWay = [NSMutableString stringWithFormat:@"按月付息、到期还本"];
    }
    else if ([model.repaymentType integerValue] == 4){
        payWay = [NSMutableString stringWithFormat:@"按周付息、到期还本"];
    }
    else if ([model.repaymentType integerValue] == 5){
        payWay = [NSMutableString stringWithFormat:@"一次还本付息"];
    }
    else if ([model.repaymentType integerValue] == 6){
        payWay = [NSMutableString stringWithFormat:@"到期付息、体验金收回"];
    }
    
    
    
    
    
    NSMutableAttributedString *paywayAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",payWay]];
    [paywayAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [paywayAttr length])];
    [paywayAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(0, [paywayAttr length])];
    self.payWayLabel.attributedText = paywayAttr;
    
    
    CGFloat progress = ([model.leftAmount floatValue] / [model.amount floatValue]);
    self.progressV.progress = 1 - progress;
    self.lastAccountLabel.text = [NSString stringWithFormat:@"剩余金额:%@元",model.leftAmount];
    
}

+ (CGFloat)cellHeight
{
    return KHeight(110);
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
