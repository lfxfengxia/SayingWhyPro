//
//  WenTiCell.h
//  LYDApp
//
//  Created by fcl on 2017/6/22.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYCustomCommentModel.h"
#import "WenTiModel.h"

@interface WenTiCell : UITableViewCell

@property (nonatomic, strong) WenTiModel *model;
@property(nonatomic,strong)UIWebView *webView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
