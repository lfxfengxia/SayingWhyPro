//
//  XYTransportDetailCell.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYTransportDetailCell.h"

@interface XYTransportDetailCell ()

@property (nonatomic, strong) UILabel       *titleTextLabel;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UILabel       *numberTextLabel;
@property (nonatomic, strong) UILabel       *numberLabel;
@property (nonatomic, strong) UILabel       *dateTextLabel;
@property (nonatomic, strong) UILabel       *dateLabel;
@property (nonatomic, strong) UILabel       *protocalTextLabel;
@property (nonatomic, strong) UILabel       *protocalLabel;
@property (nonatomic, strong) UILabel       *paytimeTextLabel;
@property (nonatomic, strong) UILabel       *paytimeLabel;
@property (nonatomic, strong) UILabel       *timeTextLabel;
@property (nonatomic, strong) UILabel       *timeLabel;
@property (nonatomic, strong) UILabel       *rateTextLabel;
@property (nonatomic, strong) UILabel       *rateLabel;
@property (nonatomic, strong) UILabel       *payWayTextLabel;
@property (nonatomic, strong) UILabel       *payWayLabel;


@end

@implementation XYTransportDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYTransportDetailCell";
    XYTransportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYTransportDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    CGFloat hMargin = KWidth(20);
    UIFont  *textFont = [UIFont systemFontOfSize:KHeight(13)];
    
    self.titleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, KHeight(17), KWidth(120), KHeight(36))];
    self.titleTextLabel.textColor = TEXTBLACK;
    self.titleTextLabel.font = textFont;
    self.titleTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.titleTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.titleTextLabel.layer.borderWidth = 0.5f;
    self.titleTextLabel.textAlignment = NSTextAlignmentCenter;
    self.titleTextLabel.text = @"借款标的名称";
    [self.contentView addSubview:self.titleTextLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleTextLabel.maxX, self.titleTextLabel.y, kSCREENW - self.titleTextLabel.maxX - KWidth(20), KHeight(36))];
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.font = textFont;
    self.titleLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.titleLabel.layer.borderWidth = 0.5f;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.numberTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.titleTextLabel.maxY, KWidth(120), KHeight(36))];
    self.numberTextLabel.textColor = TEXTBLACK;
    self.numberTextLabel.font = textFont;
    self.numberTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.numberTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.numberTextLabel.layer.borderWidth = 0.5f;
    self.numberTextLabel.textAlignment = NSTextAlignmentCenter;
    self.numberTextLabel.text = @"借款编号";
    [self.contentView addSubview:self.numberTextLabel];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.numberTextLabel.maxX, self.numberTextLabel.y, kSCREENW - self.numberTextLabel.maxX - KWidth(20), KHeight(36))];
    self.numberLabel.textColor = TEXTBLACK;
    self.numberLabel.font = textFont;
    self.numberLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.numberLabel.layer.borderWidth = 0.5f;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.numberLabel];
    
    self.dateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.numberTextLabel.maxY, KWidth(120), KHeight(36))];
    self.dateTextLabel.textColor = TEXTBLACK;
    self.dateTextLabel.font = textFont;
    self.dateTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.dateTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.dateTextLabel.layer.borderWidth = 0.5f;
    self.dateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.dateTextLabel.text = @"发布日期";
    [self.contentView addSubview:self.dateTextLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.dateTextLabel.maxX, self.dateTextLabel.y, kSCREENW - self.dateTextLabel.maxX - KWidth(20), KHeight(36))];
    self.dateLabel.textColor = TEXTBLACK;
    self.dateLabel.font = textFont;
    self.dateLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.dateLabel.layer.borderWidth = 0.5f;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.dateLabel];
    
    self.rateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.dateTextLabel.maxY, KWidth(120), KHeight(36))];
    self.rateTextLabel.textColor = TEXTBLACK;
    self.rateTextLabel.font = textFont;
    self.rateTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.rateTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.rateTextLabel.layer.borderWidth = 0.5f;
    self.rateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.rateTextLabel.text = @"年利率";
    [self.contentView addSubview:self.rateTextLabel];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.rateTextLabel.maxX, self.rateTextLabel.y, kSCREENW - self.rateTextLabel.maxX - KWidth(20), KHeight(36))];
    self.rateLabel.textColor = TEXTBLACK;
    self.rateLabel.font = textFont;
    self.rateLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.rateLabel.layer.borderWidth = 0.5f;
    self.rateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rateLabel];
    
    self.timeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.rateTextLabel.maxY, KWidth(120), KHeight(36))];
    self.timeTextLabel.textColor = TEXTBLACK;
    self.timeTextLabel.font = textFont;
    self.timeTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.timeTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.timeTextLabel.layer.borderWidth = 0.5f;
    self.timeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.timeTextLabel.text = @"期限";
    [self.contentView addSubview:self.timeTextLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeTextLabel.maxX, self.timeTextLabel.y, kSCREENW - self.timeTextLabel.maxX - KWidth(20), KHeight(36))];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.font = textFont;
    self.timeLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.timeLabel.layer.borderWidth = 0.5f;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.timeLabel];
    
    self.protocalTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.timeTextLabel.maxY, KWidth(120), KHeight(36))];
    self.protocalTextLabel.textColor = TEXTBLACK;
    self.protocalTextLabel.font = textFont;
    self.protocalTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.protocalTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.protocalTextLabel.layer.borderWidth = 0.5f;
    self.protocalTextLabel.textAlignment = NSTextAlignmentCenter;
    self.protocalTextLabel.text = @"转让方式";
    [self.contentView addSubview:self.protocalTextLabel];
    
    self.protocalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.protocalTextLabel.maxX, self.protocalTextLabel.y, kSCREENW - self.protocalTextLabel.maxX - KWidth(20), KHeight(36))];
    self.protocalLabel.textColor = TEXTBLACK;
    self.protocalLabel.font = textFont;
    self.protocalLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.protocalLabel.layer.borderWidth = 0.5f;
    self.protocalLabel.textAlignment = NSTextAlignmentCenter;
    self.protocalLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.protocalLabel];
    
    self.payWayTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.protocalTextLabel.maxY, KWidth(120), KHeight(36))];
    self.payWayTextLabel.textColor = TEXTBLACK;
    self.payWayTextLabel.font = textFont;
    self.payWayTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.payWayTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.payWayTextLabel.layer.borderWidth = 0.5f;
    self.payWayTextLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayTextLabel.text = @"转让原因";
    [self.contentView addSubview:self.payWayTextLabel];
    
    self.payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.payWayTextLabel.maxX, self.payWayTextLabel.y, kSCREENW - self.payWayTextLabel.maxX - KWidth(20), KHeight(36))];
    self.payWayLabel.textColor = TEXTBLACK;
    self.payWayLabel.font = textFont;
    self.payWayLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.payWayLabel.layer.borderWidth = 0.5f;
    self.payWayLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.payWayLabel];
    
    
    self.paytimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, self.payWayTextLabel.maxY, KWidth(120), KHeight(36))];
    self.paytimeTextLabel.textColor = TEXTBLACK;
    self.paytimeTextLabel.font = textFont;
    self.paytimeTextLabel.backgroundColor = [UIColor colorWithRed:0.96 green:0.98 blue:0.99 alpha:1.00];
    self.paytimeTextLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.paytimeTextLabel.layer.borderWidth = 0.5f;
    self.paytimeTextLabel.textAlignment = NSTextAlignmentCenter;
    self.paytimeTextLabel.text = @"剩余天数";
    [self.contentView addSubview:self.paytimeTextLabel];
    
    self.paytimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.paytimeTextLabel.maxX, self.paytimeTextLabel.y, kSCREENW - self.paytimeTextLabel.maxX - KWidth(20), KHeight(36))];
    self.paytimeLabel.textColor = TEXTBLACK;
    self.paytimeLabel.font = textFont;
    self.paytimeLabel.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00].CGColor;
    self.paytimeLabel.layer.borderWidth = 0.5f;
    self.paytimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.paytimeLabel];

}

- (void)setModel:(XYTransportModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.dateLabel.text = [NSString stringWithFormat:@"%@",[LYDTool timeFormatted:model.createTime]];
    self.numberLabel.text = [NSString stringWithFormat:@"%@",model.transportId];
    self.rateLabel.text = [NSString stringWithFormat:@"%.1f%%",[model.oldApr floatValue]];
    self.timeLabel.text = [NSString stringWithFormat:@"%@天",model.period];;
    self.protocalLabel.text = [NSString stringWithFormat:@"即买即成交"];
    self.payWayLabel.text = [NSString stringWithFormat:@"%@",model.transferReason];
    self.paytimeLabel.text = [NSString stringWithFormat:@"%ld天", [model.leftPeriods integerValue]];
}

+ (CGFloat)cellHeight
{
    return KHeight(637/2);
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
