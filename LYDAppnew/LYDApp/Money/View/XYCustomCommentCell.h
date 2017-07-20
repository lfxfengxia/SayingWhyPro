//
//  XYCustomCommentCell.h
//  LYDApp
//
//  Created by dookay_73 on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCustomCommentModel.h"

@interface XYCustomCommentCell : UITableViewCell

@property (nonatomic, strong) XYCustomCommentModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
