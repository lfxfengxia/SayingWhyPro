//
//  DSYFinancingBaseController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/5.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYFinancingBaseController.h"
#import "RBDatePickerView.h"

#define kDSYTextColorGray_102            rgba(102, 102, 102, 1)

@interface DSYFinancingBaseController ()<UIGestureRecognizerDelegate>

@end

@implementation DSYFinancingBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self creatUI];
}

- (void)creatUI {
    
    [self contentTableView];
    
    [self headerView];
    [self startDateLabel];
    [self deadLineDateLabel];
    [self totalMoneyLabel];
    [self queryBtn];
    
    [self startDatePicker];
    [self endDatePicker];
}

- (NSString *)startDate {
    if (!_startDate || _startDate.length <= 0) {
        _startDate = [[NSDate dateWithTimeInterval:-(365 * 60 * 60 *24) sinceDate:[NSDate date]] getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _startDate;
}


- (NSString *)endDate {
    if (!_endDate || _endDate.length <= 0) {
        NSDate *currentDate = [NSDate dateWithTimeInterval:(60 * 60 *24) sinceDate:[NSDate date]];
        _endDate = [currentDate getDateStringWithFormatterStr:@"yyyyMMdd"];
    }
    return _endDate;
}


#pragma mark - ==============property的创建===========
#pragma mark headerView的创建
- (UIImageView *)headerView {
    if (!_headerView) {
        
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Y(12), self.view.width, H(88))];
//        [self.view addSubview:_headerView];
        self.contentTableView.tableHeaderView = _headerView;
        
        _headerView.userInteractionEnabled = YES;
        _headerView.image = DSYImage(@"account_financing_header_bg.png");
        
    }
    return _headerView;
}

#pragma mark startDateLabel的创建
- (UILabel *)startDateLabel {
    if (!_startDateLabel) {
        CGFloat height = self.headerView.height / 2;

        _startDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, self.headerView.width / 2 - X(12), height)];
        [self.headerView addSubview:_startDateLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showStartPicker:)];
        _startDateLabel.userInteractionEnabled = YES;
        [_startDateLabel addGestureRecognizer:tap];
        
        _startDateLabel.text = @"起始于: 请选择开始时间";
        _startDateLabel.font  = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        _startDateLabel.textColor = kDSYTextColorGray_102;
    }
    return _startDateLabel;
}

#pragma mark deadLineDateLabel的创建
- (UILabel *)deadLineDateLabel {
    if (!_deadLineDateLabel) {
        CGFloat height = self.headerView.height / 2;

        _deadLineDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headerView.width / 2, 0, self.headerView.width / 2 - X(12), height)];
        [self.headerView addSubview:_deadLineDateLabel];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEndPicker:)];
        _deadLineDateLabel.userInteractionEnabled = YES;
        [_deadLineDateLabel addGestureRecognizer:tap];
        _deadLineDateLabel.text = @"结束于: 请选择结束时间";
        _deadLineDateLabel.font  = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        _deadLineDateLabel.textColor = kDSYTextColorGray_102;
        _deadLineDateLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _deadLineDateLabel;
}

#pragma mark totalMoneyLabel的创建
- (UILabel *)totalMoneyLabel {
    if (!_totalMoneyLabel) {
        CGFloat height = self.headerView.height / 2;
        
        UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), height, W(30), height)];
        [self.headerView addSubview:showLabel];
        showLabel.text = @"合计:";
        showLabel.textColor = kDSYTextColorGray_102;
        showLabel.font = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        [showLabel fixSingleWidth];
        
        _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(showLabel.maxX, showLabel.y, self.headerView.width / 2 - showLabel.maxX, height)];
        [self.headerView addSubview:_totalMoneyLabel];
        _totalMoneyLabel.textColor = ORANGECOLOR;
        _totalMoneyLabel.font = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
        _totalMoneyLabel.text = @"￥00.00";
    }
    return _totalMoneyLabel;;
}

#pragma mark queryBtn的创建
- (UIButton *)queryBtn {
    if (!_queryBtn) {
        _queryBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.headerView addSubview:_queryBtn];
        _queryBtn.backgroundColor = ORANGECOLOR;
        _queryBtn.layer.cornerRadius = X(3);
        _queryBtn.titleLabel.font = DSY_NORMALFONT_14;
        _queryBtn.frame = CGRectMake(self.headerView.width - X(12 + 75), 0, W(75), H(28));
        _queryBtn.centerY = self.totalMoneyLabel.centerY;
        [_queryBtn setTitle:@"查询" forState:(UIControlStateNormal)];
        [_queryBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    }
    return _queryBtn;
}

#pragma mark contentTableView的创建
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.width, self.view.height - 64 - H(45)) style:(UITableViewStylePlain)];
        NSLog(@"%f", kSCREENH);
        [self.view addSubview:_contentTableView];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.bounces = YES;
    }
    return _contentTableView;
}

#pragma mark startDatePicker的创建
- (RBDatePickerView *)startDatePicker {
    if (!_startDatePicker) {
        _startDatePicker = [[RBDatePickerView alloc] initWithFrame:CGRectMake(0, self.contentTableView.maxY, kSCREENW, 244)];
        [self.view addSubview:_startDatePicker];
        _startDatePicker.promptString = @"请选择开始时间";
        
        __weak typeof(RBDatePickerView *) weakStartDatePicker = _startDatePicker;
        weakStartDatePicker.cancelButtonClickBlock = ^(UIDatePicker *datePicker) {
            [UIView animateWithDuration:0.2 animations:^{
                _startDatePicker.transform = CGAffineTransformIdentity;
            }];
        };
        weakStartDatePicker.doneButtonClickBlock = ^(UIDatePicker *datePicker) {
            [UIView animateWithDuration:0.2 animations:^{
                _startDatePicker.transform = CGAffineTransformIdentity;
            }];
            
            if ([self startDatePicker]) {

                NSDate *startDate = [datePicker date];
                NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
                fomatter.dateFormat = @"yyyy-MM-dd";
                NSString *startDateString = [NSString stringWithFormat:@"起始于: %@" ,[fomatter stringFromDate:startDate]];
                self.startDateLabel.text = startDateString;
                self.startDate = [startDate getDateStringWithFormatterStr:@"yyyyMMdd"];
            }
        };
    }
    return _startDatePicker;;
}

#pragma mark endDatePicker的创建
- (RBDatePickerView *)endDatePicker {
    if (!_endDatePicker) {
        _endDatePicker = [[RBDatePickerView alloc] initWithFrame:CGRectMake(0, self.contentTableView.maxY, kSCREENW, 244)];
        [self.view addSubview:_endDatePicker];
        _endDatePicker.promptString = @"请选择结束时间";
        
        __weak typeof(RBDatePickerView *) weakEndDatePicker = _endDatePicker;
        weakEndDatePicker.cancelButtonClickBlock = ^(UIDatePicker *datePicker) {
            [UIView animateWithDuration:0.2 animations:^{
                _endDatePicker.transform = CGAffineTransformIdentity;
            }];
        };
        weakEndDatePicker.doneButtonClickBlock = ^(UIDatePicker *datePicker) {
            [UIView animateWithDuration:0.2 animations:^{
                _endDatePicker.transform = CGAffineTransformIdentity;
            }];
            
            if ([self startBellowEndDate]) {
                NSDate *startDate = [datePicker date];
                NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
                fomatter.dateFormat = @"yyyy-MM-dd";
                NSString *startDateString = [NSString stringWithFormat:@"结束于: %@", [fomatter stringFromDate:startDate]];
                self.deadLineDateLabel.text = startDateString;
                self.endDate = [startDate getDateStringWithFormatterStr:@"yyyyMMdd"];
            }
        };
    }
    return _endDatePicker;
}

- (BOOL)startBellowEndDate {
    NSUInteger startS = [self.startDatePicker.datePicker date].timeIntervalSince1970;
    NSUInteger endS = [self.endDatePicker.datePicker date].timeIntervalSince1970;
    
    if (startS== 0 || endS == 0) {
        return YES;
    }
    
    if (startS == endS) {
        return YES;
    }
    
    if (startS < endS) {
        return YES;
    } else {
        [MBProgressHUD showError:@"请选择合理的日期" toView:self.view];
        return NO;
    }
}

#pragma mark 创建一个Label的创建
- (UILabel *)creatTitleLabelWithTitle:(NSString *)title frame:(CGRect)frame forLeft:(BOOL)isLeft; {
    CGFloat maxWidth = frame.size.width;
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    [self.headerView addSubview:bgView];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, W(50), bgView.height)];
    [bgView addSubview:showLabel];
    
    showLabel.text = title;
    showLabel.font  = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
    showLabel.textColor = kDSYTextColorGray_102;
    [showLabel fixSingleWidth];
    // 将原来增加的一部分减去一部分
    showLabel.width = showLabel.width - 2;
    showLabel.textAlignment = NSTextAlignmentLeft;
    
    UILabel *returnLabel = [[UILabel alloc] initWithFrame:CGRectMake(showLabel.maxX, 0, bgView.width - showLabel.maxX, bgView.height)];
    [bgView addSubview:returnLabel];
    returnLabel.text = @"请选择开始时间";
    returnLabel.font = [UIFont systemFontOfSize:W(14.0f) weight:UIFontWeightThin];
    returnLabel.textColor = kDSYTextColorGray_102;
    // 此处需要固定左部，修复宽度
    [returnLabel fixSingleWidth];
    returnLabel.textAlignment = NSTextAlignmentRight;
    // 获取连个连在一起的宽度
    CGFloat viewWidth = showLabel.width + returnLabel.width;
    
    if (viewWidth > maxWidth) {
        bgView.width = maxWidth;
    } else {
        bgView.width = viewWidth;
    }
    
    if (isLeft) {  // 左边
        bgView.frame = CGRectMake(frame.origin.x, frame.origin.y, bgView.width, bgView.height);
    } else {   // 右边
        CGFloat maxX = frame.origin.x + frame.size.width;
        bgView.frame = CGRectMake(maxX - bgView.width, frame.origin.y, bgView.width, bgView.height);
    }
    
//    bgView.backgroundColor = [UIColor blueColor];
    
    return  returnLabel;
}


#pragma mark - 自定义方法
- (NSString *)showDateStringFromDate:(NSDate *)date formatterString:(NSString *)formatterString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterString];
    return [formatter stringFromDate:date];
}

- (void)showStartPicker:(UITapGestureRecognizer *)tap {
    
    NSLog(@"%f, %f, %f", self.startDatePicker.y, self.endDatePicker.y, self.contentTableView.maxY);

    
    if ((NSInteger)self.endDatePicker.y <= (NSInteger)self.contentTableView.maxY) {
        [UIView animateWithDuration:0.2 animations:^{
            self.endDatePicker.transform = CGAffineTransformIdentity;
        }];
    }
    
    if ((NSInteger)self.startDatePicker.y >= (NSInteger)self.contentTableView.maxY) {
        [UIView animateWithDuration:0.2 animations:^{
            self.startDatePicker.transform = CGAffineTransformMakeTranslation(0, -216);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.startDatePicker.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)showEndPicker:(UITapGestureRecognizer *)tap {
    if ((NSInteger)self.startDatePicker.y <= (NSInteger)self.contentTableView.maxY) {
        [UIView animateWithDuration:0.2 animations:^{
            self.startDatePicker.transform = CGAffineTransformIdentity;
            
        }];
    }
    
    if ((NSInteger)self.startDatePicker.y >= (NSInteger)self.contentTableView.maxY) {
        [UIView animateWithDuration:0.2 animations:^{
            self.endDatePicker.transform = CGAffineTransformMakeTranslation(0, -216);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.endDatePicker.transform = CGAffineTransformIdentity;
        }];
    }

}

- (NSMutableAttributedString *)getAttributeWithTitle:(NSString *)title {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    NSArray *arr = [title componentsSeparatedByString:@"("];
    NSString *firstStr = arr[0];
    NSString *secondStr = [NSString stringWithFormat:@"(%@", arr[1]];
    
    NSAttributedString *firstAttr = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSFontAttributeName:DSY_NORMALFONT_13, NSForegroundColorAttributeName:RGB(102, 102, 102)}];
    [attr appendAttributedString:firstAttr];
    
    NSAttributedString *secondAttr = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSFontAttributeName:DSY_NORMALFONT_10, NSForegroundColorAttributeName:RGB(102, 102, 102)}];
    [attr appendAttributedString:secondAttr];
    
    
    return attr;
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)pan {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
