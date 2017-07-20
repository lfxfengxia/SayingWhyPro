//
//  XYHomePlanCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYHomePlanCell.h"

@interface XYHomePlanCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *rateLabel;
@property (nonatomic, strong) UILabel   *rateTextLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *timeTextLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *moneyTextLabel;
@property (nonatomic, strong) UILabel   *payWayLabel;
@property (nonatomic, strong) UILabel   *payWayTextLabel;
@property (nonatomic, strong) UIImageView   *titleLabelBg;
@property (nonatomic, strong) UIView   *jiangeView;
@property (nonatomic, strong) UIImageView   *imgLine;

@end

@implementation XYHomePlanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYHomePlanCell";
    XYHomePlanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYHomePlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    
    CGFloat hMargin = (kSCREENW - (KWidth(138/2) * 4) - (KWidth(20) * 2)) / 3;
    CGFloat vMargin = KHeight(12);
    CGFloat labelW  = KWidth(138/2);
    CGFloat labelH  = KHeight(14);
    CGFloat textlabelH  = KHeight(11);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kSCREENW - (KWidth(12) * 2), KHeight(12))];
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    
    
    self.titleLabelBg = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth(12), KHeight(10), kSCREENW - (KWidth(12) * 2)+10, KHeight(12)+10)];
    
    
    self.titleLabelBg.image=[UIImage imageNamed:@"title_button_ba"];
    [self.titleLabelBg addSubview:self.titleLabel];
    [self.contentView addSubview:self.titleLabelBg];
    
    _imgLine=[[UIImageView alloc]initWithFrame:CGRectMake(KWidth(12), self.titleLabelBg.maxY+9, kSCREENW - (KWidth(12) * 2)+10, 2)];
    
    _imgLine.image=[UIImage imageNamed:@"licai_line"];
    _imgLine.hidden=YES;
    [self.contentView addSubview:_imgLine];
    
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), self.titleLabelBg.maxY + vMargin+20, labelW, labelH)];
    self.rateLabel.font = [UIFont systemFontOfSize:KHeight(18.0f)];
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    self.rateLabel.textColor = ORANGECOLOR;
    [self.contentView addSubview:self.rateLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.x, self.rateLabel.maxY + vMargin, labelW, textlabelH)];
    self.rateTextLabel.textColor = TEXTGARY;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.rateTextLabel.adjustsFontSizeToFitWidth = YES;
    self.rateTextLabel.text = @"年化利率";
    [self.contentView addSubview:self.rateTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateLabel.maxX + hMargin, self.rateLabel.y, labelW, labelH)];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(16)];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.timeLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.x, self.timeLabel.maxY + vMargin, labelW, textlabelH)];
    self.timeTextLabel.textColor = TEXTGARY;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.timeTextLabel.adjustsFontSizeToFitWidth = YES;
    self.timeTextLabel.text = @"借款期限";
    [self.contentView addSubview:self.timeTextLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.maxX + hMargin, self.timeLabel.y, labelW, labelH)];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.textColor = TEXTBLACK;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.moneyLabel];
    
    self.moneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel.x, self.moneyLabel.maxY + vMargin, labelW, textlabelH)];
    self.moneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.moneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTextLabel.textColor = TEXTGARY;
    self.moneyTextLabel.adjustsFontSizeToFitWidth = YES;
    self.moneyTextLabel.text = @"单份金额";
    [self.contentView addSubview:self.moneyTextLabel];
    
    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.moneyLabel.maxX + hMargin, self.moneyLabel.y - KHeight(7), labelW, KHeight(28))];
    self.payWayLabel.numberOfLines = 2;
    self.payWayLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.payWayLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayLabel.textColor = TEXTBLACK;
    self.payWayLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.payWayLabel];
    
    self.payWayTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payWayLabel.x, self.moneyTextLabel.y, labelW, textlabelH)];
    self.payWayTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.payWayTextLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayTextLabel.textColor = TEXTGARY;
    self.payWayTextLabel.adjustsFontSizeToFitWidth = YES;
    self.payWayTextLabel.text = @"还款方式";
    [self.contentView addSubview:self.payWayTextLabel];
}

- (void)setModel:(XYPlanModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    CGFloat W=[Helper widthOfString:model.title font:[UIFont systemFontOfSize:KHeight(12)] height:KHeight(12)];
    self.titleLabel.frame=CGRectMake(5, 5,W, KHeight(12));
    
    self.titleLabelBg.frame=CGRectMake(KWidth(12), KHeight(10),W+10, KHeight(12)+10);
    
    
    
    
    
    self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%",[model.apr floatValue]];
    
    NSMutableString *period = [NSMutableString string];
    if ([model.periodUnit integerValue] == 0) {
        period = [NSMutableString stringWithFormat:@"%@个月",model.periods];
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
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元/份",model.perAmount]];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [moneyAttr length])];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KHeight(16)] range:NSMakeRange(0, [moneyAttr length])];
    self.moneyLabel.attributedText = moneyAttr;
    
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
    
}

+ (CGFloat)cellHeight
{
    return KHeight(170 / 2)+KHeight(10)+20+20;
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
