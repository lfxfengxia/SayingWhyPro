//
//  RBNewHandAreaCell.m
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "RBNewHandAreaCell.h"
#import "DSYNewInvesting.h"

@interface RBNewHandAreaCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *capitalLabel;
@property (nonatomic, strong) UILabel *profitLabel;
@property (nonatomic, strong) UILabel *statuLabel;
@property (nonatomic, strong) UIImageView *indicatorView;

@end

@implementation RBNewHandAreaCell

+ (id)cellForTableView:(UITableView *)tableView
{
    static NSString *identify = @"RBNewHandAreaCell";
    RBNewHandAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[RBNewHandAreaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell createUI];
    }
    
    return cell;
}

- (void)setInvest:(DSYNewInvesting *)invest {
    if (_invest != invest) {
        _invest = invest;
    }
    [self updateUI];
}

- (void)updateUI {
    self.nameLabel.text = @"新手体验区";
    if ([self.invest.bidTitle isEqualToString:@"新手体验标"]) {
        self.nameLabel.text = @"新手体验标";
        self.indicatorView.hidden = YES;
    } else {
        self.nameLabel.text = @"新手专享标";
        self.indicatorView.hidden = NO;
    }
    
    self.capitalLabel.text = [NSString stringWithFormat:@"%.2f", self.invest.amount];
    self.profitLabel.text = [NSString stringWithFormat:@"%.2f", self.invest.totalIncome];
    self.statuLabel.text = self.invest.statusDesc;
}

- (void)createUI {
    _nameLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(0, 0, kSCREENW/4.0, 40) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:13];
    [self.contentView addSubview:_nameLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [_nameLabel addGestureRecognizer:tap];
    
    _capitalLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(kSCREENW/4.0, 0, kSCREENW/4.0, 40) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:13];
    [self.contentView addSubview:_capitalLabel];
    
    _profitLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(2*kSCREENW/4.0, 0, kSCREENW/4.0, 40) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:13];
    [self.contentView addSubview:_profitLabel];
    
    _statuLabel = [RYFactoryMethod initWithLabelFrame:CGRectMake(3*kSCREENW/4.0, 0, kSCREENW/4.0, 40) andTextColor:rgba(102, 102, 102, 1) fontOfSystemSize:13];
    [self.contentView addSubview:_statuLabel];
    
    self.indicatorView = [[UIImageView alloc] initWithImage:DSYImage(@"indicator_icon.png")];
    [self.contentView addSubview:self.indicatorView];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.indicatorView.size);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
    }];
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    if (![self.invest.bidTitle isEqualToString:@"新手专享标"]) {
        return;
    }
    
    if (self.block) {
        self.block(self.indexPath);
    }
}

@end
