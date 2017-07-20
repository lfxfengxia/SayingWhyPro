//
//  RBCapitalCell.m
//  LYDApp
//
//  Created by Riber on 16/11/9.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBCapitalCell.h"
#import "DSYUserTradeRecord.h"

@interface RBCapitalCell ()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *isConsumeOrIncomeLabel;
@property (nonatomic, strong) UILabel *blanceLabel;

@end

@implementation RBCapitalCell

+ (id)cellForTableView:(UITableView *)tableView
{
    static NSString *identify = @"RBCapitalCell";
    RBCapitalCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[RBCapitalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell createUI];
    }
    
    return cell;
}

- (void)setTradeRecord:(DSYUserTradeRecord *)tradeRecord {
    if (_tradeRecord != tradeRecord) {
        _tradeRecord = tradeRecord;
    }
    [self updateUI];
}

- (void)updateUI {
    if (self.tradeRecord.amount >= 0) {
        // 收益
        self.typeLabel.text = self.tradeRecord.summary;
        self.isConsumeOrIncomeLabel.text = [NSString stringWithFormat:@"+ ￥%.2f", self.tradeRecord.amount];
        self.isConsumeOrIncomeLabel.textColor = rgba(6, 184, 61, 1);
        self.blanceLabel.font = [UIFont systemFontOfSize:KWidth(11)];
        self.typeLabel.font = DSY_NORMALFONT_15;
    } else {
        // 消费
        self.typeLabel.text = self.tradeRecord.summary;
        self.isConsumeOrIncomeLabel.text = [NSString stringWithFormat:@"- ￥%.2f", -self.tradeRecord.amount];
        self.isConsumeOrIncomeLabel.textColor = RGB(225, 35, 35);
        self.blanceLabel.font = [UIFont systemFontOfSize:KWidth(11) weight:UIFontWeightThin];
        self.typeLabel.font = [UIFont systemFontOfSize:W(15.0f) weight:UIFontWeightThin];
    }
    
    self.dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:(self.tradeRecord.createTime / 1000)] getDateStringWithFormatterStr:@"yyyy-MM-dd hh:mm:ss"];
    self.blanceLabel.text = [NSString stringWithFormat:@"余额￥%.2f", self.tradeRecord.balance];
}

- (void)createUI {
    _typeLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(KWidth(20), 15, kSCREENW/2-20, 20) andTextColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(15)];
    _typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_typeLabel];
    
    _dateLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(_typeLabel.x, _typeLabel.maxY+10, _typeLabel.width, _typeLabel.height) andTextColor:rgba(160, 160, 160, 1) fontOfSystemSize:KWidth(11)];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_dateLabel];
    
    _isConsumeOrIncomeLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(kSCREENW/2.0, _typeLabel.y, _typeLabel.width, _typeLabel.height) andTextColor:rgba(6, 184, 61, 1) fontOfSystemSize:KWidth(15)];
    _isConsumeOrIncomeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_isConsumeOrIncomeLabel];

    _blanceLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(kSCREENW/2.0, _isConsumeOrIncomeLabel.maxY+10, _typeLabel.width, _typeLabel.height) andTextColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(11)];
    _blanceLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_blanceLabel];

}

@end
