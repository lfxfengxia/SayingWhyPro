//
//  FuWuCell.h
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuWuCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *listArray;
-(void)ListArray:(NSMutableArray *)listArray;
+(instancetype)FuWuCellWithTableView:(UITableView *)tableView;
@end
