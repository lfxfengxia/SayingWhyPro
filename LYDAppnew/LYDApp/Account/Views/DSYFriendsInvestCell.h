//
//  DSYFriendsInvestCell.h
//  LYDApp
//
//  Created by dai yi on 2017/1/2.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSYFriendInvestModel;
@class DSYFriendInvestRecord;
@interface DSYFriendsInvestCell : UITableViewCell

@property (nonatomic, strong) DSYFriendInvestModel *friendInvest;
@property (nonatomic, strong) DSYFriendInvestRecord *recod;

+ (DSYFriendsInvestCell *)cellForTableView:(UITableView *)tableView;

@end
