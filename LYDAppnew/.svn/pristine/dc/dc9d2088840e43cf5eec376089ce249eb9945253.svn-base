//
//  RBMessageCenterCell.m
//  LYDApp
//
//  Created by Riber on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBMessageCenterCell.h"

@interface RBMessageCenterCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation RBMessageCenterCell

+ (RBMessageCenterCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *identify = @"RBMessageCenterCell";
    RBMessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[RBMessageCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell createUI];
    }
    
    return cell;
}

- (void)createUI {
    _titleLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(KWidth(20), KHeight(10), kSCREENW - 2*KWidth(20) - 50, 20) andTextColor:[UIColor blackColor] fontOfSystemSize:KWidth(13)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];

    _dateLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(kSCREENW-50-20, _titleLabel.y, 50, 20) andTextColor:rgba(252, 120, 35, 1) fontOfSystemSize:KWidth(11)];
    _dateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_dateLabel];
    
    _descriptionLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(_titleLabel.x, _titleLabel.maxY + KHeight(5), _titleLabel.width, _titleLabel.height) andTextColor:rgba(76, 76, 78, 1) fontOfSystemSize:KWidth(13)];
    _descriptionLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_descriptionLabel];

    
}

- (void)setModel:(RBMessageModel *)model {
    _titleLabel.text = model.title;
    _descriptionLabel.text = model.body;
    
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSDate *date = [calendar dateFromComponents:components];
    
    if ([model.createTime integerValue] / 1000 > date.timeIntervalSince1970) {
        _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:[model.createTime doubleValue] / 1000] getDateStringWithFormatterStr:@"hh:mm"];
    } else {
        _dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:[model.createTime doubleValue] / 1000] getDateStringWithFormatterStr:@"MM-dd"];
    }
    
    if (model.read) {
        // 度去过
    } else {
        // 没有读取过
    }
}

@end
