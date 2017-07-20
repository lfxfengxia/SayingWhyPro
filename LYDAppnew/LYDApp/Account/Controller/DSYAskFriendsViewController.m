//
//  DSYAskFriendsViewController.m
//  LYDApp
//
//  Created by yidai on 16/11/10.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAskFriendsViewController.h"
#import "ZWVerticalAlignLabel.h"
#import "DSYSocityCollectionViewCell.h"
#import "DSYAccountQRCodeController.h"
#import "DSYTipViewController.h"
#import "DSYInviteRuleViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "DSYInviteDetailViewController.h"
#import "DSYInviteInvestController.h"

#import <objc/runtime.h>

#define kStartTag 2000

@interface DSYAskFriendsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *topBgView;    /**< 顶部视图 */


@property (nonatomic, strong) UIImageView *showBgView;              /**< 邀请人数，投资总额， 邀请奖励 */
// 显示的label
@property (nonatomic, strong) ZWVerticalAlignLabel *inviteCountLabel;  /**< 邀请人数 */
@property (nonatomic, strong) ZWVerticalAlignLabel *investAmountLabel;   /**< 投资总额 */
@property (nonatomic, strong) ZWVerticalAlignLabel *inviteRewardLabel;  /**< 邀请奖励 */

@property (nonatomic, strong) UIView *inviteFirstView;
@property (nonatomic, strong) UILabel *hrefLabel;      /**< 链接地址 */
@property (nonatomic, strong) UIView *inviteSecondView;
@property (nonatomic, strong) UICollectionView *societyCollectionView; /**< 社交平台 */
@property (nonatomic, strong) UIView *inviteThirdView;
@property (nonatomic, strong) UILabel *carNumberLabel;   /**< 好友邀请码 */

@property (nonatomic, strong) NSMutableArray *socityDataList; /**< 社交平台的数据 */
@property (nonatomic, strong) NSMutableArray *tableDataList;  /**< 列表数据 */

@property (nonatomic,   copy) NSString *inviteRule;      /**< 奖励机制 */
@property (nonatomic,   copy) NSString *tip;             /**< 温馨提示 */

@property (nonatomic, assign) CGFloat codeMinWidth;      /**< 最小宽度 */

@property (nonatomic,   copy) NSString *QRCode;          /**< 二维码的 */
@property (nonatomic,   copy) NSString *inviteReportURL;



@property (nonatomic,   copy) NSString *strdescribe;//分享描述
@property (nonatomic,   copy) NSString *strtitle;//分享标题
@property (nonatomic,   copy) NSString *strpicUrl;//分享标题

@end

@implementation DSYAskFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigaTitle = @"邀请好友";
    
    [self creatUI];
}

- (void)creatUI {
    [self contentTableView];
    [self headerView];
    
    [self topBgView];
    [self showBgView];
    [self inviteCountLabel];
    [self investAmountLabel];
    //[self inviteRewardLabel];
    
    [self inviteFirstView];
    [self inviteThirdView];
    [self inviteSecondView];
    [self hrefLabel];
    [self societyCollectionView];
    [self carNumberLabel];
    
//    self.inviteFirstView.backgroundColor = [UIColor redColor];
//    self.inviteSecondView.backgroundColor  = [UIColor greenColor];
//    self.inviteThirdView.backgroundColor  = [UIColor blueColor];
    
    [self loadData];
}


- (void)loadData {
    NSString *url = [NSString stringWithFormat:@"%@/user/invite/report", APIPREFIX];
    NSDictionary *para = [self getMyPara];
    [LYDTool sendGetWithUrl:url parameters:para success:^(id data) {
        id backData = LYDJSONSerialization(data);
        [self.contentTableView.header endRefreshing];
        NSLog(@"%@", backData);
        [self successDealWithData:backData];
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        // 错误处理方法
        [self.contentTableView.header endRefreshing];
        [self errorDealWithOperation:operation];
    }];
}



- (NSDictionary *)getMyPara {
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, };
    // 生成签名认证
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"sign":sign};
    
    return para;
}

#pragma mark 成功处理
- (void)successDealWithData:(id)data {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger statusCode = [data[@"code"] integerValue];;
    
    if (statusCode == 200) {
        // 数据加载成功后设置相应的信息
        self.inviteCountLabel.text = [NSString stringWithFormat:@"%ld人", [data[@"inviteCount"] integerValue]];
        self.investAmountLabel.text = [NSString stringWithFormat:@"%.2f元", [data[@"friendInvestAmount"] floatValue]];
        self.inviteRewardLabel.text = [NSString stringWithFormat:@"%.2f元", [data[@"commissionTotal"] floatValue]];
        self.hrefLabel.text = [NSString stringWithFormat:@"点击复制 %@", data[@"inviteLink"]];
        [self.hrefLabel fixSignleWidthForCenterMaxWidth:(self.contentTableView.width - W(40)) minWidth:self.codeMinWidth];
        
        self.carNumberLabel.text = [NSString stringWithFormat:@"点击复制 %@", data[@"inviteCode"]];
        [self.carNumberLabel fixSignleWidthForCenterMaxWidth:(self.contentTableView.width - W(40)) minWidth:self.codeMinWidth];
        
        self.QRCode = data[@"inviteLink"];//分享链接
        self.inviteRule = data[@"inviteRule"];
        self.tip = data[@"tip"];
        self.inviteReportURL=data[@"inviteReportURL"];
        
        
//        @property (nonatomic,   copy) NSString *strdescribe;//分享描述
//        @property (nonatomic,   copy) NSString *strtitle;//分享标题
//        @property (nonatomic,   copy) NSString *strpicUrl;//分享标题
        
        
        self.strdescribe = data[@"describe"];
        self.strtitle = data[@"title"];

        self.strpicUrl=data[@"picUrl"];
        
    } else if (statusCode == 600) {
        [DSYUtils showSuccessForStatus_600_ForViewController:self];
    } else {
        [MBProgressHUD showError:data[@"message"] toView:self.view];
    }
}

#pragma mark 错误处理
- (void)errorDealWithOperation:(AFHTTPRequestOperation *)operation {
    [MBProgressHUD hideHUDForView:self.view];
    NSInteger errorData = operation.response.statusCode;
    NSLog(@"%zi",operation.response.statusCode);
    if (errorData == 401) {
        // 401错误处理
        [DSYUtils showResponseError_401_ForViewController:self];
    } else if (errorData == 404) {
        [DSYUtils showResponseError_404_ForViewController:self message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
            [self pushToLoginController];
        } cancelHandler:^(UIAlertAction *action) {
        }];
    } else {
        XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
        [self.view.window addSubview:errorHud];
    }
}


- (NSMutableArray *)socityDataList {
    if (!_socityDataList) {
        _socityDataList = [NSMutableArray arrayWithCapacity:0];
        
        [_socityDataList addObject:@{@"icon":@"society_wechat_friend.png", @"name":@"微信好友"}];
        [_socityDataList addObject:@{@"icon":@"society_wechat_circle.png", @"name":@"微信朋友圈"}];
        [_socityDataList addObject:@{@"icon":@"society_QRCode.png", @"name":@"手机二维码"}];
        [_socityDataList addObject:@{@"icon":@"society_qq_friends.png", @"name":@"QQ好友"}];
//        [_socityDataList addObject:@{@"icon":@"society_qq_zone.png", @"name":@"QQ空间"}];
//        [_socityDataList addObject:@{@"icon":@"society_sina.png", @"name":@"新浪微博"}];
    }
    return _socityDataList;
}

- (NSMutableArray *)tableDataList {
    if (!_tableDataList) {
        _tableDataList = [NSMutableArray arrayWithCapacity:0];
        [_tableDataList addObject:@"奖励机制"];
        //[_tableDataList addObject:@"温馨提示"];
        [_tableDataList addObject:@"二维码邀请"];
        [_tableDataList addObject:@"邀请记录"];
        //[_tableDataList addObject:@"投资记录"];
    }
    return _tableDataList;
}

#pragma mark - property的getter方法(属性的懒加载)
#pragma mark contentTableView的创建-----------
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.view.height) style:(UITableViewStylePlain)];
        [self.view addSubview:_contentTableView];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        
        _contentTableView.separatorColor = rgba(161, 161, 161, 1);
        _contentTableView.separatorInset = UIEdgeInsetsZero;
        _contentTableView.rowHeight = H(44);
//        _contentTableView.backgroundColor = rgba(249, 249, 249, 1);
        _contentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    return _contentTableView;
}


#pragma mark headerView的创建-------------
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.contentTableView.height - 2 * H(44) - 64)];
        self.contentTableView.tableHeaderView = _headerView;
        _headerView.backgroundColor = rgba(249, 249, 249, 1);
    }
    return _headerView;
}

#pragma mark topBgView的创建------------
- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, H(65))];
        [self.headerView addSubview:_topBgView];

        _topBgView.backgroundColor = rgba(250, 202, 64, 1);
    }
    return _topBgView;
}

#pragma mark showBgView的创建-----------
- (UIImageView *)showBgView {
    if (!_showBgView) {
        _showBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.topBgView.width, H(36))];
        [self.topBgView addSubview:_showBgView];
        _showBgView.centerY = self.topBgView.height / 2;
        _showBgView.userInteractionEnabled = YES;
        //_showBgView.image = DSYImage(@"solid_line.png");
    }
    return _showBgView;
}

#pragma mark inviteCountLabel创建---------
- (ZWVerticalAlignLabel *)inviteCountLabel {
    if (!_inviteCountLabel) {
        _inviteCountLabel = [self creatLabelWithTitle:@"邀请人数" frame:CGRectMake(0, 0, self.showBgView.width / 2, self.showBgView.height) clickSelector:nil];
        _inviteCountLabel.text = [NSString stringWithFormat:@"0人"];
    }
    return _inviteCountLabel;
}

#pragma mark investAmountLabel的创建------------
- (ZWVerticalAlignLabel *)investAmountLabel {
    if (!_investAmountLabel) {
        _investAmountLabel = [self creatLabelWithTitle:@"投资总额" frame:CGRectMake(self.showBgView.width / 2, 0, self.showBgView.width / 2, self.showBgView.height) clickSelector:@selector(inviteClicked:)];
        _investAmountLabel.text = @"0.00元";
    }
    return _investAmountLabel;
}

//#pragma mark inviteRewardLabel的创建------------
//- (ZWVerticalAlignLabel *)inviteRewardLabel {
//    if (!_inviteRewardLabel) {
//        _inviteRewardLabel = [self creatLabelWithTitle:@"邀请奖励" frame:CGRectMake(self.showBgView.width * 2 / 3, 0, self.showBgView.width / 3, self.showBgView.height) clickSelector:@selector(inviteClicked:)];
//        _inviteRewardLabel.text = @"0.00元";
//    }
//    return _inviteRewardLabel;
//}

#pragma mark inviteFirstView的创建------------
- (UIView *)inviteFirstView {
    if (!_inviteFirstView) {
        _inviteFirstView = [self creatBgViewWithTitle:@"方法一: 专属推荐链接" frame:CGRectMake(0, self.topBgView.maxY + Y(20), self.headerView.width, H(112))];
//        [self.headerView addSubview:_inviteFirstView];
    }
    return _inviteFirstView;
}

#pragma mark inviteThirdView的创建---------
- (UIView *)inviteThirdView {
    if (!_inviteThirdView) {
        _inviteThirdView = [self creatBgViewWithTitle:@"方法三: 好友邀请码" frame:CGRectMake(0, self.headerView.height - H(112), self.headerView.width, H(112))];
//        [self.headerView addSubview:_inviteThirdView];
    }
    return _inviteThirdView;
}
#pragma mark inviteSecondView的创建------------
- (UIView *)inviteSecondView {
    if (!_inviteSecondView) {
        _inviteSecondView = [self creatBgViewWithTitle:@"方法二: 社交应用推荐" frame:CGRectMake(0, self.inviteFirstView.maxY, self.headerView.width, self.inviteThirdView.y - self.inviteFirstView.maxY)];
//        [self.headerView addSubview:_inviteSecondView];
    }
    return _inviteSecondView;
}


#pragma mark  hrefLabel的创建------------
- (UILabel *)hrefLabel {
    if (!_hrefLabel) {
        _hrefLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, self.inviteFirstView.width - 2 * X(12), H(44))];
        [self.inviteFirstView  addSubview:_hrefLabel];
        _hrefLabel.textColor = rgba(194, 183, 176, 1);
        _hrefLabel.backgroundColor = rgba(240, 235, 231, 1);
        _hrefLabel.font = DSY_NORMALFONT_14;
        _hrefLabel.textAlignment = NSTextAlignmentCenter;
        _hrefLabel.text = @"点击复制 ";
        [_hrefLabel fixSingleWidth];
        
        _hrefLabel.width = _hrefLabel.width + W(40);
        if (_hrefLabel.width > self.inviteFirstView.width - 2 * X(12)) {
            _hrefLabel.width = self.inviteFirstView.width - 2 * X(12);
        }
        
        _hrefLabel.center = CGPointMake(self.inviteFirstView.width / 2, (self.inviteFirstView.height - H(30)) / 2 + H(30));
        _hrefLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyHrefClicked:)];
        [_hrefLabel addGestureRecognizer:tap];
        
    }
    return _hrefLabel;
}

#pragma mark  carNumberLabel的创建------------
- (UILabel *)carNumberLabel {
    if (!_carNumberLabel) {
        _carNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(12), 0, self.inviteThirdView.width - 2 * X(12), H(44))];
        [self.inviteThirdView  addSubview:_carNumberLabel];
        _carNumberLabel.textColor = rgba(194, 183, 176, 1);
        _carNumberLabel.backgroundColor = rgba(240, 235, 231, 1);
        _carNumberLabel.font = DSY_NORMALFONT_14;
        _carNumberLabel.textAlignment = NSTextAlignmentCenter;
        _carNumberLabel.text = @"点击复制 ";
        [_carNumberLabel fixSingleWidth];
        
        _carNumberLabel.width = _carNumberLabel.width + W(40);
        self.codeMinWidth = _carNumberLabel.width;
        if (_carNumberLabel.width > self.inviteThirdView.width - 2 * X(12)) {
            _carNumberLabel.width = self.inviteThirdView.width - 2 * X(12);
        }
        
        _carNumberLabel.center = CGPointMake(self.inviteThirdView.width / 2, (self.inviteThirdView.height - H(30)) / 2 + H(30));
        _carNumberLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyCarNumberClicked:)];
        
        [_carNumberLabel addGestureRecognizer:tap];
        
    }
    return _carNumberLabel;
}

#pragma mark societyCollectionView的创建------------
- (UICollectionView *)societyCollectionView {
    if (!_societyCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (self.inviteSecondView.width - 2 * X(12)) / 4;
        layout.itemSize = CGSizeMake(itemWidth, H(77));  // Y(6) + H(43) + H(28)
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(Y(6), X(12), Y(6), X(12));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // H(176) = H(77) * 2 + 2 * Y(6);
        _societyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.inviteSecondView.width, H(176)) collectionViewLayout:layout];
        [self.inviteSecondView addSubview:_societyCollectionView];
        _societyCollectionView.centerY = (self.inviteSecondView.height - H(30)) / 2 + H(30);
        
        _societyCollectionView.delegate = self;
        _societyCollectionView.dataSource = self;
        _societyCollectionView.backgroundColor = rgba(249, 249, 249, 1);
        
        [_societyCollectionView registerClass:[DSYSocityCollectionViewCell class] forCellWithReuseIdentifier:@"defaultCollectionViewCell"];
        
    }
    return _societyCollectionView;
}


#pragma mark - 自定义方法
#pragma mark  创建ZWVerticalAlignLabel相关的控件
// 创建一个视图区域
- (ZWVerticalAlignLabel *) creatLabelWithTitle:(NSString *)title frame:(CGRect)frame clickSelector:(SEL)action {
    //    CGPoint origalPoint = frame.origin;
    CGSize  origalSize  = frame.size;
    
    UIButton *bgView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.showBgView addSubview:bgView];
    bgView.frame = frame;
    [bgView addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    
    ZWVerticalAlignLabel *valueLabel = [[ZWVerticalAlignLabel alloc] initWithFrame:CGRectMake(0, 0, origalSize.width, origalSize.height / 2)];
    valueLabel.font = DSY_NORMALFONT_18;
//    valueLabel.text = @"0人";
    valueLabel.textColor = rgba(102, 30, 0, 1);
//    valueLabel.userInteractionEnabled = YES;
    [valueLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_top).addAlignType(textAlignType_center);
    }];
    [bgView addSubview:valueLabel];
    objc_setAssociatedObject(bgView, @"ZWVerticalAlignLabel", valueLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 提示显示
    ZWVerticalAlignLabel *showLabel = [[ZWVerticalAlignLabel alloc] initWithFrame:CGRectMake(0, origalSize.height / 2, origalSize.width, origalSize.height / 2)];
    showLabel.text = title;
    showLabel.font = DSY_NORMALFONT_11;
    showLabel.textColor = rgba(153, 40, 3, 1);
//    showLabel.userInteractionEnabled = YES;
    [showLabel textAlign:^(ZWMaker *make) {
        make.addAlignType(textAlignType_bottom).addAlignType(textAlignType_center);
    }];
    [bgView addSubview:showLabel];
    
    
    return valueLabel;
}

- (UIView *)creatBgViewWithTitle:(NSString *)title frame:(CGRect)frame {
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    [self.headerView addSubview:bgView];
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(X(13), 0, bgView.width - 2 * X(13), H(30))];
    [bgView addSubview:showLabel];
    showLabel.text = title;
    showLabel.textColor = rgba(49, 49, 49, 1);
    showLabel.font = DSY_NORMALFONT_13;
    
    [self creatSolidLineWithFrame:CGRectMake(showLabel.x, showLabel.maxY, showLabel.width, H(0.5)) toView:bgView];
    
    return bgView;
}




#pragma mark solidLine的创建
- (void)creatSolidLineWithFrame:(CGRect)frame toView:(UIView *)superView {
    UIView *solidLine = [[UIView alloc] initWithFrame:frame];
    solidLine.backgroundColor = rgba(235, 235, 235, 1);
    
    [superView addSubview:solidLine];
}

- (void)inviteClicked:(UIButton *)sender {
    ZWVerticalAlignLabel *valueLabel = objc_getAssociatedObject(sender, @"ZWVerticalAlignLabel");
    if (valueLabel == self.inviteCountLabel) {
        NSLog(@"查看人数");
        DSYInviteDetailViewController *detailVC = [[DSYInviteDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
        
    } else if (valueLabel == self.investAmountLabel) {
        NSLog(@"查看投资金额");
    } else if (valueLabel == self.inviteRewardLabel) {
        NSLog(@"查看奖励");
    } else {
        
    }
}

- (void)copyHrefClicked:(UITapGestureRecognizer *)tap {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //
    if (self.hrefLabel.text.length > 5) {
        NSString *copyString = [self.hrefLabel.text substringFromIndex:5];
        pasteboard.string = copyString;
        
//        [RYFactoryMethod alertViewOrControllerShow:@"成功复制!" viewController:self];
        [MBProgressHUD showSuccess:@"你已复制了邀请链接" toView:self.view];
    }
}

- (void)copyCarNumberClicked:(UITapGestureRecognizer *)tap {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    if (self.carNumberLabel.text.length > 5) {
        NSString *copyString = [self.carNumberLabel.text substringFromIndex:5];
        pasteboard.string = copyString;
//        [RYFactoryMethod alertViewOrControllerShow:@"成功复制!" viewController:self];
        [MBProgressHUD showSuccess:@"你已复制了邀请码" toView:self.view];
    }
}



#pragma mark - contentTableView的DataSource和Delegate
#pragma mark contentTableView的DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"defaultTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
        cell.textLabel.font = DSY_NORMALFONT_13;
        cell.textLabel.textColor = rgba(102, 102, 102, 1);
    }
    
    cell.textLabel.text = self.tableDataList[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataList.count;
}

#pragma mark contentTableView的Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        DSYAccountQRCodeController *qrCodeVC = [[DSYAccountQRCodeController alloc] init];
        qrCodeVC.QRCode = self.QRCode;
        [self.navigationController pushViewController:qrCodeVC animated:YES];
    } else if (indexPath.row == 0) {
        DSYInviteRuleViewController *ruleVC = [[DSYInviteRuleViewController alloc] init];
        ruleVC.strurl = self.inviteReportURL;
        [self.navigationController pushViewController:ruleVC animated:YES];
        
    }
//    else if (indexPath.row == 1) {
//        DSYTipViewController *tapVC = [[DSYTipViewController alloc] init];
//        tapVC.strurl = self.inviteReportURL;
//        [self.navigationController pushViewController:tapVC animated:YES];
//    }
    else if (indexPath.row == 2) {
        DSYInviteDetailViewController *detailVC = [[DSYInviteDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    } else if (indexPath.row == 3) {
        DSYInviteInvestController *detailVC = [[DSYInviteInvestController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - societyCollectionView的DataSource和Delegate
#pragma mark societyCollectionView的DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DSYSocityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"defaultCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.socityDataList[indexPath.row];
    cell.iconView.image = DSYImage(dic[@"icon"]);
    cell.socityNameLabel.text = dic[@"name"];

    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.socityDataList.count;
}

#pragma mark societyCollectionView的Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.socityDataList[indexPath.row];
    if ([dic[@"name"] isEqualToString:@"手机二维码"]) {
        DSYAccountQRCodeController *qrCodeVC = [[DSYAccountQRCodeController alloc] init];
        qrCodeVC.QRCode = self.QRCode;
        [self.navigationController pushViewController:qrCodeVC animated:YES];
    } else if (indexPath.row == 0) {
        // 微信好友分享
        [self shareToPlatFormWithType:UMSocialPlatformType_WechatSession];
    } else if (indexPath.row == 1) {
        // 微信朋友圈
        [self shareToPlatFormWithType:UMSocialPlatformType_WechatTimeLine];
    }
        else if (indexPath.row == 3) {
        // QQ好友
        [self shareToPlatFormWithType:UMSocialPlatformType_QQ];
    }
//    else if (indexPath.row == 4) {
//        // QQ空间
//        [self shareToPlatFormWithType:UMSocialPlatformType_Qzone];
//    }
}


#pragma mark - 解决ios9不显示分割线的方法
-(void)viewDidLayoutSubviews {
    
    if ([self.contentTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.contentTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.contentTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.contentTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


#pragma mark - 分享的各个平台及其内容
- (void)shareToWebchatFriends {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    // 分享粘贴的东西
    NSLog(@"%@", pasteboard.string);
    NSString *text = pasteboard.string;
    if (![text isEqualToString:self.QRCode] && [self.QRCode hasPrefix:@"http"]) {
        [MBProgressHUD showError:@"请复制链接地址!" toView:self.view];
        return;
    }
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = @"";
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"分享成功"];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邀请好友"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];

}


#pragma mark - 分享各个平台
- (void)shareToPlatFormWithType:(UMSocialPlatformType)type {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_strpicUrl]];
    UIImage *img=[UIImage imageWithData:data];
    
    
    
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    // NSString* thumbURL = _imgStr;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:_strtitle descr:_strdescribe thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = _QRCode;//分享链接
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = @"";
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
           
        } else {
            message = [NSString stringWithFormat:@"分享成功"];
            
        }
    }];
    
}






//#pragma mark - 分享各个平台
//- (void)shareToPlatFormWithType:(UMSocialPlatformType)type {
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    // 分享粘贴的东西
//    NSLog(@"%@", pasteboard.string);
//    NSString *text = pasteboard.string;
//    
//    if (text.length == 0) {
//        [MBProgressHUD showError:@"请复制链接地址!" toView:self.view];
//        return;
//    }
//    
//    if (![text isEqualToString:self.QRCode] && [self.QRCode hasPrefix:@"http"]) {
//        [MBProgressHUD showError:@"请复制链接地址!" toView:self.view];
//        return;
//    }
//    
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    
//    messageObject.text = text;
//    
//    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        NSString *message = @"";
//        if (!error) {
//            message = [NSString stringWithFormat:@"分享成功"];
//        } else {
//            message = [NSString stringWithFormat:@"分享成功"];
//            
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邀请好友"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                              otherButtonTitles:nil];
//        [alert show];
//    }];
//}
//

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
