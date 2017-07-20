//
//  FenShuInvestmentView.h
//  LYDApp
//
//  Created by lyd_Mac on 2017/6/26.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPlanModel.h"


@protocol ChongzhiDelegate <NSObject>

@optional
-(void)didClickButtonChongzhi:(UIButton *)button;

@end

@interface FenShuInvestmentView : UIView<UITextFieldDelegate>
{
    XYPlanModel *_model;
}
@property(nonatomic,strong)UITextField *Field;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *reduceBtn;
@property(nonatomic,strong)UILabel *earnings;
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UILabel *balance;
@property(nonatomic,strong)UIButton *rechargeBtn;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)UILabel *fenshuLabel;
@property(nonatomic,weak) id<ChongzhiDelegate> delegate;
-(void)setFenShuInvestmentViewInformation:(NSString *)availableBalance XYPlanModel:(XYPlanModel *)model;
-(void)fieldTextChang;
@end
