//
//  XYTransportCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYTransportCell.h"

@interface XYTransportCell ()

@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *originRateLabel;
@property (nonatomic, strong) UILabel   *originRateTextLabel;
@property (nonatomic, strong) UILabel   *lastDateLabel;
@property (nonatomic, strong) UILabel   *lastDateTextLabel;
@property (nonatomic, strong) UILabel   *transportMoneyLabel;
@property (nonatomic, strong) UILabel   *transportMoneyTextLabel;
@property (nonatomic, strong) UILabel   *realRateLabel;
@property (nonatomic, strong) UILabel   *realRateTextLabel;
@property (nonatomic, strong) UILabel   *statusLabel;

@end

@implementation XYTransportCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYTransportCell";
    XYTransportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYTransportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(10), kSCREENW - (KWidth(110)), KHeight(12))];
    self.titleLabel.textColor = TEXTBLACK;
    self.titleLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    [self.contentView addSubview:self.titleLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.maxX + KWidth(20), KHeight(8), KWidth(50), KHeight(17))];
    self.statusLabel.textColor = ORANGECOLOR;
    self.statusLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.statusLabel.layer.borderColor = ORANGECOLOR.CGColor;
    self.statusLabel.layer.borderWidth = 0.5f;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.statusLabel];
//    self.statusLabel.hidden = YES;
    
    self.originRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(self.titleLabel.maxY + 12), KWidth(144/2), KHeight(12))];
    self.originRateLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.originRateLabel.textAlignment = NSTextAlignmentCenter;
    self.originRateLabel.textColor = TEXTBLACK;
    self.originRateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.originRateLabel];
    
    self.originRateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.originRateLabel.x, self.originRateLabel.maxY + KHeight(13), KWidth(144/2), KHeight(11))];
    self.originRateTextLabel.textColor = TEXTGARY;
    self.originRateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.originRateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.originRateTextLabel.text = @"原债券收益率";
    [self.contentView addSubview:self.originRateTextLabel];
    
    self.lastDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.originRateLabel.maxX + KWidth(35), self.originRateLabel.y, KWidth(96/2), self.originRateLabel.height)];
    self.lastDateLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.lastDateLabel.textAlignment = NSTextAlignmentCenter;
    self.lastDateLabel.textColor = TEXTBLACK;
    self.lastDateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.lastDateLabel];
    
    self.lastDateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lastDateLabel.x, self.lastDateLabel.maxY + KHeight(13), KWidth(96/2), KHeight(11))];
    self.lastDateTextLabel.textColor = TEXTGARY;
    self.lastDateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.lastDateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.lastDateTextLabel.text = @"剩余天数";
    [self.contentView addSubview:self.lastDateTextLabel];
    
    self.transportMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lastDateLabel.maxX + KWidth(36), self.lastDateLabel.y, KWidth(110/2), self.lastDateLabel.height)];
    self.transportMoneyLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.transportMoneyLabel.textColor = TEXTBLACK;
    self.transportMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.transportMoneyLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.transportMoneyLabel];
    
    self.transportMoneyTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transportMoneyLabel.x, self.transportMoneyLabel.maxY + KHeight(13), KWidth(110/2), KHeight(11))];
    self.transportMoneyTextLabel.textColor = TEXTGARY;
    self.transportMoneyTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.transportMoneyTextLabel.textAlignment = NSTextAlignmentCenter;
    self.transportMoneyTextLabel.text = @"转让金额";
    [self.contentView addSubview:self.transportMoneyTextLabel];
    
    self.realRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.transportMoneyLabel.maxX + KHeight(30), self.transportMoneyLabel.y, KWidth(118/2), self.transportMoneyLabel.height)];
    self.realRateLabel.font = [UIFont systemFontOfSize:KHeight(14)];
    self.realRateLabel.textColor = TEXTBLACK;
    self.realRateLabel.textAlignment = NSTextAlignmentCenter;
    self.realRateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.realRateLabel];
    
    self.realRateTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.realRateLabel.x, self.realRateLabel.maxY + KHeight(13), KWidth(118/2), KHeight(11))];
    self.realRateTextLabel.font = [UIFont systemFontOfSize:KHeight(11)];
    self.realRateTextLabel.textColor = TEXTGARY;
    self.realRateTextLabel.textAlignment = NSTextAlignmentCenter;
    self.realRateTextLabel.text = @"实际收益率";
    [self.contentView addSubview:self.realRateTextLabel];
}

- (void)setModel:(XYTransportModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.originRateLabel.text = [NSString stringWithFormat:@"%.1f%%",[model.oldApr floatValue] ];
    self.lastDateLabel.text = [NSString stringWithFormat:@"%ld天", [model.leftPeriods integerValue]];
    self.transportMoneyLabel.text = [NSString stringWithFormat:@"%@元",model.transferPrice];
    self.realRateLabel.text = [NSString stringWithFormat:@"%.1f%%",[model.realApr floatValue]];
//    self.statusLabel.text = [NSString stringWithFormat:@"%@",model.status];
    if ([model.status integerValue] == 2) {
        self.statusLabel.text = @"";
        self.statusLabel.hidden = YES;
    } else {
        self.statusLabel.text = @"已转让";
        self.statusLabel.hidden = NO;
    }
}

+ (CGFloat)cellHeight
{
    return KHeight(170/2);
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
