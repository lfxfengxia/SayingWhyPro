//
//  RBMessageCenterCell.h
//  LYDApp
//
//  Created by Riber on 16/11/4.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBMessageModel.h"

@interface RBMessageCenterCell : UITableViewCell

+ (RBMessageCenterCell *)cellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) RBMessageModel *model;


@end
