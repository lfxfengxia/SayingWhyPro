//
//  DSYPlainTableViewCell.m
//  LYDApp
//
//  Created by dai yi on 2016/11/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYPlainTableViewCell.h"

@interface DSYPlainTableViewCell ()

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation DSYPlainTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.bgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.titleShowLabel = [[UILabel alloc] init];
    [self.bgView addSubview:_titleShowLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, Y(1), self.contentView.width, self.contentView.height - Y(2));
    self.titleShowLabel.frame = CGRectMake(X(23), 0, self.bgView.width - X(46), self.bgView.height);
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
