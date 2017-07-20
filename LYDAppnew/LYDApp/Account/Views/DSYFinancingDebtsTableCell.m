//
//  DSYFinancingDebtsTableCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//  汇款情况的cell

#import "DSYFinancingDebtsTableCell.h"


#define kDSYTextGrayColor_102 rgba(102, 102, 102, 1)
#define kTextThinFont [UIFont systemFontOfSize:W(13.0f) weight:UIFontWeightThin]

@interface DSYFinancingDebtsTableCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *debtsNameLabel;     /**< 借款人 */
@property (nonatomic, strong) UILabel *debtsPhoneLabel;    /**< 借款人手机号码 */
@property (nonatomic, strong) UILabel *debtsAmountLabel;   /**< 借款金额 */
@property (nonatomic, strong) UILabel *codeLabel;          /**< 合同编号 */

@end

@implementation DSYFinancingDebtsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubviews];
    }
    return self;
}

+ (DSYFinancingDebtsTableCell *)cellForTableView:(UITableView *)tableView {
    static NSString *ID = @"financingBillDebtsTableCell";
    DSYFinancingDebtsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[DSYFinancingDebtsTableCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    return cell;
}

- (void)setModel:(DSYFinancingModel *)model {
    self.debtsNameLabel.text = [NSString stringWithFormat:@"借款人: %@", @"朱幽闭"];
    self.debtsPhoneLabel.text = @"借款手机号: 15858867755";
    self.debtsAmountLabel.text = [NSString stringWithFormat:@"借款金额: %.2f元", 1000.00];
    self.codeLabel.text = @"合同编号: 12235";
}


- (void)creatSubviews {
    self.contentView.backgroundColor = rgba(249, 249, 249, 1);
    
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:_bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.debtsNameLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_debtsNameLabel];
    self.debtsNameLabel.textColor = kDSYTextGrayColor_102;
    self.debtsNameLabel.font = DSY_NORMALFONT_16;
    
    
    self.debtsPhoneLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_debtsPhoneLabel];
    self.debtsPhoneLabel.font = kTextThinFont;
    self.debtsPhoneLabel.textColor = kDSYTextGrayColor_102;
    
    self.debtsAmountLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_debtsAmountLabel];
    self.debtsAmountLabel.font = kTextThinFont;
    self.debtsAmountLabel.textColor = kDSYTextGrayColor_102;
    
    self.codeLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_codeLabel];
    self.codeLabel.font = kTextThinFont;
    self.codeLabel.textColor = kDSYTextGrayColor_102;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
     self.bgView.frame = CGRectMake(X(12), Y(12), self.contentView.width - 2 * X(12), self.contentView.height - Y(24));
    
    self.debtsNameLabel.frame = CGRectMake(X(15), Y(10), self.bgView.width - X(30), H(26));
    CGFloat width = self.debtsNameLabel.width;
    CGFloat height = H(25);
    self.debtsPhoneLabel.frame = CGRectMake(self.debtsNameLabel.x, self.debtsNameLabel.maxY + Y(5), width, height);
    self.debtsAmountLabel.frame = CGRectMake(self.debtsPhoneLabel.x, self.debtsPhoneLabel.maxY, width, height);
    self.codeLabel.frame = CGRectMake(self.debtsAmountLabel.x, self.debtsAmountLabel.maxY, width, height);
    
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
