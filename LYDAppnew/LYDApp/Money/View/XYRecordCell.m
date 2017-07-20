//
//  XYRecordCell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYRecordCell.h"

@interface XYRecordCell ()

@property (nonatomic, strong) UILabel   *phoneLabel;
@property (nonatomic, strong) UILabel   *moneyLabel;
@property (nonatomic, strong) UILabel   *timeLabel;
@property (nonatomic, strong) UILabel   *sourceLabel;

@end

@implementation XYRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYRecordCell";
    XYRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    [self.contentView addSubview:self.timeLabel];
    
    self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake((kSCREENW / 4) * 3, KHeight(12), kSCREENW / 4, KHeight(10))];
    self.sourceLabel.font = [UIFont systemFontOfSize:KHeight(12)];
    self.sourceLabel.textColor = TEXTBLACK;
    self.sourceLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.self.sourceLabel];
}

- (void)setModel:(XYJoinRecordModel *)model
{
    _model = model;
    
    NSString *phone = [model.investorPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.phoneLabel.text = phone;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",model.amount];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [[NSDate dateWithTimeIntervalSince1970:[self.model.createTime doubleValue] / 1000] getDateStringWithFormatterStr:@"yyyy-MM-dd"]];
    
    NSMutableString *source = [NSMutableString string];
    switch ([model.client integerValue]) {
        case 1:
            source = [NSMutableString stringWithFormat:@"PC网站"];
            break;
        case 2:
            source = [NSMutableString stringWithFormat:@"移动APP"];
            break;
        case 3:
            source = [NSMutableString stringWithFormat:@"微信"];
            break;
        case 4:
            source = [NSMutableString stringWithFormat:@"其他"];
            break;
            
        default:
            break;
    }
    self.sourceLabel.text = [NSString stringWithFormat:@"%@",source];
    
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
