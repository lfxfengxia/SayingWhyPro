//
//  SheZhiAnQuanViewController.m
//  LYDApp
//
//  Created by fcl on 2017/7/1.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "SheZhiAnQuanViewController.h"
#import "RBAboutUsViewController.h"
#import "RBMessageCenterViewController.h"
#import "RBServiceCenterViewController.h"
#import "RBFeedBackViewController.h"

#import "DSYAbountUsController.h"
#import "DSYHelpWebViewController.h"

#import "DSYAbountUsWebViewController.h"         // 关于我们
#import "DSYInvestIntroWebViewController.h"      // 投资说明
#import "DSYHelpWebViewController.h"             // 帮助中心
#import "DSYCustomerWebViewController.h"         // 消息中心、
#import "WYJKViewController.h"//我要借款
#import "toolsimple.h"
#import "XYBannerModel.h"
#import "DSYAccountRealNameController.h"
#import "RBModifyPasswordViewController.h"
#import "DSYAccountBankController.h"
#import "DSYAccountNickNameController.h"

@interface SheZhiAnQuanViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SheZhiAnQuanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleNavigationBarLabel.text = @"设置与安全";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.00];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)createUI {

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREENW, kSCREENH-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor=[UIColor clearColor];
    
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 3;
    }else if(section==1)
    {
        
        return 2;
    }
    else
    {
        return 1;
    
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
                static NSString *identify = @"section00";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];;
                    cell.detailTextLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                    cell.imageView.image = [UIImage imageNamed:@"实名认证"];
                    cell.textLabel.text=@"实名认证";
                }
            
            
            
            DSYAccount *account = [DSYAccount sharedDSYAccount];
            
//            if ([Helper justIdentityCard:account.idNumber]) {
//                // 已经认证过了
//                DSYAccountRealNameController *realNameVC = [[DSYAccountRealNameController alloc] init];
//                realNameVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:realNameVC animated:YES];
//            } else{
//                //            // 当前用户为认证过
//                //            DSYAccountCertificationController *certificationVC = [[DSYAccountCertificationController alloc] init];
//                //
//                //            certificationVC.sucessBlock = ^() {
//                //                [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
//                //                    [self updateData];
//                //                    [self.contentTableView reloadData];
//                //                }];
//                //            };
//                //
//                //            [self.navigationController pushViewController:certificationVC animated:YES];
//                DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
//                [self.navigationController pushViewController:openAccountVC animated:YES];
//                
//                
//                
//            }
            
            
            if (account.idNumber.length > 0) {
                cell.detailTextLabel.text = @"已认证";
            } else {
                cell.detailTextLabel.text = @"未认证";
            }
            
                return cell;

        }
        else  if (indexPath.row==1) {
            static NSString *identify = @"section01";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14];;
                cell.detailTextLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
;
                cell.imageView.image = [UIImage imageNamed:@"手机号"];
                cell.textLabel.text=@"手机号";
                
                
                UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, 1)];
                imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
                [cell.contentView addSubview:imglineheng];
            }
            
            
            
            if ([DSYAccount sharedDSYAccount].mobile.length != 11) {
                cell.detailTextLabel.text = @"手机号码有误";
            } else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ **** %@", [[DSYAccount sharedDSYAccount].mobile substringToIndex:3], [[DSYAccount sharedDSYAccount].mobile substringFromIndex:7]];
            }
            
            
            return cell;
        }
        else
        {
            static NSString *identify = @"section02";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.font = DSY_NORMALFONT_13;
                cell.imageView.image = [UIImage imageNamed:@"我的昵称"];
                cell.textLabel.text=@"我的昵称";
                UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, 1)];
                imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
                [cell.contentView addSubview:imglineheng];
            }
            return cell;
        
        }
    }
    else if(indexPath.section==1)
    {
        
        if (indexPath.row==0) {
            static NSString *identify = @"section10";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.font = DSY_NORMALFONT_13;
                cell.imageView.image = [UIImage imageNamed:@"修改登录密码"];
                cell.textLabel.text=@"修改登录密码";
            }
            return cell;
            
        }
        else{
            static NSString *identify = @"section11";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.detailTextLabel.font = DSY_NORMALFONT_13;
                cell.imageView.image = [UIImage imageNamed:@"我的银行卡"];
                cell.textLabel.text=@"我的银行卡";
                UIImageView  *imglineheng=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, cell.frame.size.width, 1)];
                imglineheng.image=[UIImage imageNamed:@"licai_line_hui"];
                [cell.contentView addSubview:imglineheng];
            }
            return cell;
        }

    
    }
    else  if(indexPath.section==2)
    {
        
        static NSString *identify = @"section2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.font = DSY_NORMALFONT_13;
            cell.imageView.image = [UIImage imageNamed:@"设置开户"];
            cell.textLabel.text=@"设置开户";
        }
        return cell;
    
    
    }
    else
    {
        
        static NSString *identify = @"section3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor= [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.font = DSY_NORMALFONT_13;
            cell.textLabel.text=@"退出登录";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            
        }
        return cell;
        
        
    }

    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            DSYAccount *account = [DSYAccount sharedDSYAccount];
            
            if ([Helper justIdentityCard:account.idNumber]) {
                // 已经认证过了
                DSYAccountRealNameController *realNameVC = [[DSYAccountRealNameController alloc] init];
                realNameVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:realNameVC animated:YES];
            } else{
                //            // 当前用户为认证过
                //            DSYAccountCertificationController *certificationVC = [[DSYAccountCertificationController alloc] init];
                //
                //            certificationVC.sucessBlock = ^() {
                //                [[DSYAccount sharedDSYAccount] updateMyAccountForViewController:self complete:^{
                //                    [self updateData];
                //                    [self.contentTableView reloadData];
                //                }];
                //            };
                //
                //            [self.navigationController pushViewController:certificationVC animated:YES];
                DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
                [self.navigationController pushViewController:openAccountVC animated:YES];
                
                
                
            }

            
        }
        else  if (indexPath.row==1) {
 
        }
        else
        {
            DSYAccountNickNameController *nickNameVC = [[DSYAccountNickNameController alloc] init];
            nickNameVC.sucessBlock = ^() {
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:nickNameVC animated:YES];
        }
    }
    else if(indexPath.section==1)
    {
        
        if (indexPath.row==0) {

            RBModifyPasswordViewController *modifyPasswordVC = [[RBModifyPasswordViewController alloc] init];
            [self.navigationController pushViewController:modifyPasswordVC animated:YES];
        }
        else{
            // 如若没有开户，进行开户
            if ([DSYAccount sharedDSYAccount].ipsAccount.length <= 0) {
                [DSYUtils showResponseError_404_ForViewController:self message:@"用户未开户，请进行开户" okHandler:^(UIAlertAction *action) {
                    DSYOpenAccountController *openAccountVC = [[DSYOpenAccountController alloc] init];
                    [self.navigationController pushViewController:openAccountVC animated:YES];
                } cancelHandler:^(UIAlertAction *action) {
                }];
                return;
            }
            
            // 银行卡
            DSYAccountBankController *bankVC = [[DSYAccountBankController alloc] init];
            bankVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bankVC animated:YES];

        }
        
        
    }
    else  if(indexPath.section==2)
    {
        if ([DSYAccount sharedDSYAccount].ipsAccount.length == 16) {
            [MBProgressHUD showError:@"您已有账户，无需再开户" toView:self.view];
        } else {
            DSYOpenAccountController *openVC = [[DSYOpenAccountController alloc] init];
            [self.navigationController pushViewController:openVC animated:YES];
        }
    }
    else
    {
        NSString *timestamp = [LYDTool createTimeStamp];
        NSDictionary *secretDict = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN};
        NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
        NSDictionary *para = @{@"appKey":APPKEY,@"timestamp":timestamp,@"deviceId":DEVICEID,@"token":TOKEN,@"sign":sign};
        [MBProgressHUD showMessage:@"正在退出登录" toView:self.view];
        
        [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/passport/logout",APIPREFIX] parameters:para success:^(id data) {
            
            [MBProgressHUD hideHUDForView:self.view];
            
            id backData = LYDJSONSerialization(data);
            NSLog(@"%@",backData);
            
            [MBProgressHUD showSuccess:@"退出成功"];
            UserDefaultsWriteObj(@"", @"access-token");
            [self.tabBarController setSelectedIndex:3];
            [self.navigationController popViewControllerAnimated:NO];
            
            
        } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
            
            [MBProgressHUD hideHUDForView:self.view];
            
            id response = LYDJSONSerialization(operation.responseObject);
            NSLog(@"%@",response);
            if ([[response valueForKey:@"code"] integerValue] == 401) {
                [DSYUtils showResponseError_401_ForViewController:self];
            } else {
                XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络错误" andDoneBtnTitle:nil andDoneBtnHidden:YES];
                [self.view.window addSubview:errorHud];
            }
            
        }];
        
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
//    if (section==1) {
//        return 10;
//    }
//    else
//    {
//        return 0.01f;
//    }
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}



@end