//
//  RBNewHandAreaCell.h
//  LYDApp
//
//  Created by Riber on 16/11/8.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYNewInvesting;
typedef void(^RBNewHandAreaCellBlock)(NSIndexPath *index);
@interface RBNewHandAreaCell : UITableViewCell

@property (nonatomic, strong) DSYNewInvesting *invest;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic,   copy) RBNewHandAreaCellBlock block;
+ (id)cellForTableView:(UITableView *)tableView;

@end
