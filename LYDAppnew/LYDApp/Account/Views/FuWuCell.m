//
//  FuWuCell.m
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/30.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "FuWuCell.h"
#import "FuWuCollectionViewCell.h"
#import "toolsimple.h"
#import "WebViewVC.h"
static NSString *const ID=@"FuWuCell";
static NSString *const cellID=@"FuWuCollectionViewCell";
@implementation FuWuCell

-(NSMutableArray *)listArray
{
    if(!_listArray)
    {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}

+(instancetype)FuWuCellWithTableView:(UITableView *)tableView{
    FuWuCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[FuWuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor=[UIColor whiteColor];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.showsVerticalScrollIndicator=NO;
        self.collectionView.showsHorizontalScrollIndicator=NO;
        self.collectionView.scrollEnabled=NO;
        [self.collectionView registerClass:[FuWuCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
        
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=RGB(245, 245, 245);
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(10);
        }];
        
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FuWuCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell FuWuCollectionViewCellWithDic:self.listArray[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[self.listArray[indexPath.row] objectForKey:@"serviceHref"] isKindOfClass:[NSNull class]])
    {
        WebViewVC *vc=[[WebViewVC alloc]init];
        vc.url=[self.listArray[indexPath.row] objectForKey:@"serviceHref"];
        vc.hidesBottomBarWhenPushed=YES;
        [self.parentController.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(KWidth(118), KWidth(111));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, KWidth(10), 0, KWidth(10));
}

-(void)ListArray:(NSMutableArray *)listArray
{
    self.listArray=listArray;
    [self.collectionView reloadData];
}


@end
