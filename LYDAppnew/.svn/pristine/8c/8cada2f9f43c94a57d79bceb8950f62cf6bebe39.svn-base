//
//  DSYDebtsReceiveCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/29.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYDebtsReceiveCell.h"
#import "DSYDebtsReceiveModel.h"

@interface DSYDebtsReceiveCell ()

@property (nonatomic, strong) UILabel *financingNameLabel;        /**< 理财名称 */
@property (nonatomic, strong) UILabel *origalRateLabel;           /**< 原始利率 */

@property (nonatomic, strong) UILabel *remaindAmountLabel;        /**< 剩余本金 */

@property (nonatomic, strong) UILabel *assignAmountLabel;         /**< 转让价 */
@property (nonatomic, strong) UILabel *remaindCountLabel;         /**< 剩余期限 */

@end

@implementation DSYDebtsReceiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYDebtsReceiveCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"DSYDebtsReceiveCell";
    DSYDebtsReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYDebtsReceiveCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView insertLayoutLineWithWidth:H(0.5) align:(UIViewLineAlignmentBottom)];
    }
    return cell;
}

- (void)setReceive:(DSYDebtsReceiveModel *)receive {
    if (_receive != receive) {
        _receive = receive;
    }
    [self updateUI];
}

- (void)updateUI {
    self.financingNameLabel.text = self.receive.bidTitle;
    if (self.receive.bidTitle.length > 4) {
        self.financingNameLabel.text = [NSString stringWithFormat:@"%@\n%@", [self.receive.bidTitle substringToIndex:4], [self.receive.bidTitle substringFromIndex:4]];
    }
    
    self.origalRateLabel.text = [NSString stringWithFormat:@"%.1f%%", self.receive.oldApr];
    self.remaindAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.receive.bondLeftAmount];
    self.assignAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.receive.transferPrice];
    

    
    self.remaindCountLabel.text = [NSString stringWithFormat:@"%ld", self.receive.leftPeriods];
}

- (NSString *)getShowStrWithTime:(NSInteger)time {
    NSString *str = nil;
    
    if (time / (60 * 60 * 24 * 7) > 0) {
        str = [NSString stringWithFormat:@"%ld周", time / (60 * 60 * 24 * 7)];
    } else if (time / (60 * 60 * 24) > 0) {
        str = [NSString stringWithFormat:@"%ld天", time / (60 * 60 * 24)];
    } else if (time / (60 * 60) > 0) {
        str = [NSString stringWithFormat:@"%ld小时", time / (60 * 60)];
    } else {
        str = @"1小时内";
    }
    
    return str;
}

- (void)creatSubviews {
    self.financingNameLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.financingNameLabel];
    self.financingNameLabel.numberOfLines = 0;
    
    self.origalRateLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.origalRateLabel];
    self.origalRateLabel.numberOfLines = 0;
    
    self.remaindAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.remaindAmountLabel];
    self.remaindAmountLabel.numberOfLines = 0;
    
    self.assignAmountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.assignAmountLabel];
    self.assignAmountLabel.numberOfLines = 0;
    
    self.remaindCountLabel = [RYFactoryMethod initWithLabelFrame:CGRectZero andTextColor:RGB(102, 102, 102) fontOfSystemSize:W(12.0f)];
    [self.contentView addSubview:self.remaindCountLabel];
    self.remaindCountLabel.numberOfLines = 0;
    
    CGFloat lMargin = 2.5;
    CGFloat rMargin = -2.5;
    
    [self.financingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.right.equalTo(self.origalRateLabel.mas_left).with.offset(rMargin);
        make.width.equalTo(self.origalRateLabel);
    }];
    
    [self.origalRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.remaindAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.financingNameLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    [self.remaindAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.assignAmountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.origalRateLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    [self.assignAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.remaindCountLabel.mas_left).with.offset(rMargin);
        make.left.equalTo(self.remaindAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    [self.remaindCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.assignAmountLabel.mas_right).with.offset(lMargin);
        make.width.equalTo(self.financingNameLabel);
    }];
    
    UIImageView *indicatorView = [[UIImageView alloc] initWithImage:DSYImage(@"indicator_icon.png")];
    [self.contentView addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(indicatorView.size);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
    }];
    
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
