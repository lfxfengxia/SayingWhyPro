//
//  XYExperienceDetailCell.m
//  LYDApp
//
//  Created by dookay_73 on 2016/11/15.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYExperienceDetailCell.h"

@interface XYExperienceDetailCell ()

@property (nonatomic, strong) UILabel   *Label;

@end

@implementation XYExperienceDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYExperienceDetailCell";
    XYExperienceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYExperienceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    CGFloat labelH = [Helper heightOfString:@"零用贷-体验标是由零用贷设立的一个专门提供给平台新用户使用体验金进行投资体验的虚拟标的。体验金是一种投资体验标的虚拟资金，不能提现，投资到期后体验金由平台收回，投资产生的收益归用户所有，可用于投资除体验标之外的任何标的，也可提现" font:[UIFont systemFontOfSize:KHeight(14)] width:kSCREENW - KHeight(10) * 2];
    self.Label = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(10), KHeight(20), kSCREENW - KHeight(10) * 2, labelH)];
    self.Label.text = @"零用贷-体验标是由零用贷设立的一个专门提供给平台新用户使用体验金进行投资体验的虚拟标的。体验金是一种投资体验标的虚拟资金，不能提现，投资到期后体验金由平台收回，投资产生的收益归用户所有，可用于投资除体验标之外的任何标的，也可提现";
    self.Label.textColor = TEXTBLACK;
    self.Label.font = [UIFont systemFontOfSize:KHeight(14)];
    self.Label.numberOfLines = 0;
    [self.contentView addSubview:self.Label];
}


+ (CGFloat)cellHeight
{
    return 150.0f;
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
