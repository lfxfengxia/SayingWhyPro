//
//  XYRiskCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYRiskCell.h"

@interface XYRiskCell ()

@property (nonatomic, strong) UILabel   *phoneLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *timeLabel;

@end

@implementation XYRiskCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYRiskCell";
    XYRiskCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYRiskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight(12), kSCREENW / 3, KHeight(10))];
    self.phoneLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.phoneLabel.textColor = TEXTBLACK;
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.phoneLabel];
    
    self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSCREENW / 3, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.moneyLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.moneyLabel.textColor = TEXTBLACK;
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.moneyLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 3) * 2, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.timeLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.timeLabel.textColor = TEXTBLACK;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.timeLabel];
    
}

- (void)setModel:(XYRiskModel *)model
{
    _model = model;
    
    self.phoneLabel.text = model.title;
    self.moneyLabel.text = model.status;
    self.timeLabel.text = model.time;
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
