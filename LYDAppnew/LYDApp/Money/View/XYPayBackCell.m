//
//  XYPayBackCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYPayBackCell.h"

@interface XYPayBackCell ()

@property (nonatomic, strong) UILabel   *phoneLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *sourceLabel;


@end

@implementation XYPayBackCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYPayBackCell";
    XYPayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYPayBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.phoneLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.phoneLabel.textColor = TEXTBLACK;
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.phoneLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW / 4, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.moneyLabel.textColor = TEXTBLACK;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.moneyLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 4) * 2, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.timeLabel];
    
    self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 4) * 3, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.sourceLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.sourceLabel.textColor = TEXTBLACK;
    self.sourceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.sourceLabel];
}

- (void)setModel:(XYPayBackModel *)model
{
    _model = model;
    
    self.phoneLabel.text = model.leg;
    self.moneyLabel.text = model.time;
    self.timeLabel.text = [NSString stringWithFormat:@"%@元",model.shouldPay];
    self.sourceLabel.text = [NSString stringWithFormat:@"%@元",model.lastPay];
    
}

+ (CGFloat)cellHeight
{
    return KHeight(34);
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
