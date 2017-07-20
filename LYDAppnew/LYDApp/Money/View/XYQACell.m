//
//  XYQACell.m
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "XYQACell.h"

@interface XYQACell ()

@property (nonatomic, strong) UILabel   *questionTextLabel;
@property (nonatomic, strong) UILabel   *questionLabel;
@property (nonatomic, strong) UILabel   *anwserTextLabel;
@property (nonatomic, strong) UILabel   *anwserLabel;

@end

@implementation XYQACell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XYQACell";
    XYQACell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XYQACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    self.questionTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth(20), KHeight(17), KWidth(25), KHeight(12))];
    self.questionTextLabel.textColor = ORANGECOLOR;
    self.questionTextLabel.text = @"Q: ";
    self.questionTextLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    [self.contentView addSubview:self.questionTextLabel];
    
    self.questionLabel = [[UILabel alloc] init];
    self.questionLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.questionLabel.numberOfLines = 0;
    [self.contentView addSubview:self.questionLabel];
    
    self.anwserTextLabel = [[UILabel alloc] init];
    self.anwserTextLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.anwserTextLabel.textColor = ORANGECOLOR;
    self.anwserTextLabel.text = @"A: ";
    [self.contentView addSubview:self.anwserTextLabel];
    
    self.anwserLabel = [[UILabel alloc] init];
    self.anwserLabel.font = [UIFont systemFontOfSize:KHeight(13)];
    self.anwserLabel.numberOfLines = 0;
    self.anwserLabel.textColor = TEXTBLACK;
    [self.contentView addSubview:self.anwserLabel];
}

- (void)setModel:(XYQAModel *)model
{
    _model = model;
    
    CGFloat lableW = kSCREENW - KWidth(20) * 2 - KWidth(25);
    
    CGFloat questionLabelH = [Helper heightOfString:model.title font:[UIFont systemFontOfSize:KHeight(13)] width:lableW];
    self.questionLabel.frame = CGRectMake(self.questionTextLabel.maxX, self.questionTextLabel.y, lableW, questionLabelH);
    self.questionLabel.text = model.title;
    
    self.anwserTextLabel.frame = CGRectMake(self.questionTextLabel.x, self.questionLabel.maxY + KHeight(17), self.questionTextLabel.width, self.questionTextLabel.height);
    
    CGFloat anwserLabelH = [Helper heightOfString:model.content font:[UIFont systemFontOfSize:KHeight(13)] width:lableW];
    self.anwserLabel.frame = CGRectMake(self.questionLabel.x, self.anwserTextLabel.y, lableW, anwserLabelH);
    self.anwserLabel.text = model.content;
    
    self.model.cellHeight = self.anwserLabel.maxY + KHeight(17);
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
