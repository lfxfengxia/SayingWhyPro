//
//  DSYAccount.m
//  LYDApp
//
//  Created by dai yi on 2016/12/1.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYAccount.h"

@implementation DSYAccount

singleton_implementation(DSYAccount);

- (void)updateMyAccountForViewController:(UIViewController *)viewcontroller complete:(DSYAccountCompleteBlock)completeBlock {
    
    [self clean];
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"accountId":@([DSYUser sharedDSYUser].accountId), @"sign":sign};
    
    NSLog(@"%@----%@-----%@-----%@",APPKEY, timestamp, DEVICEID, TOKEN);
    [MBProgressHUD hideHUDForView:viewcontroller.view];
    [MBProgressHUD hideHUD];
    
    [MBProgressHUD showMessage:@"正在更新用户信息..." toView:viewcontroller.view];
    
//    [MBProgressHUD hideHUDForView:viewcontroller.view];
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/info", APIPREFIX] parameters:para success:^(id data) {
        [MBProgressHUD hideHUDForView:viewcontroller.view];
        [MBProgressHUD hideHUD];
        [self clean];
        self.refresh = YES;
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        
        [self setValuesForKeysWithDictionary:backData[@"account"]];
        // 数据加载成功后设置相应的信息
//        [self setUpInformation];
        NSInteger statusCode = [backData[@"code"] integerValue];
        if (statusCode == 200) {
            [self setValuesForKeysWithDictionary:backData[@"account"]];
            // 数据加载成功后设置相应的信息
            if (completeBlock) {
                [MBProgressHUD hideHUD];
                completeBlock();
            }
        } else if (statusCode == 600) {
            [DSYUtils showSuccessForStatus_600_ForViewController:viewcontroller];
        } else {
            [MBProgressHUD showError:backData[@"message"] toView:viewcontroller.view];
            if (completeBlock) {
                [MBProgressHUD hideHUD];
                completeBlock();
            }
        }
        
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        [MBProgressHUD hideHUDForView:viewcontroller.view];
        id errorData = LYDJSONSerialization(operation.responseObject);
        NSInteger statusCode = operation.response.statusCode;
        if (errorData) {
            statusCode = [errorData[@"code"] integerValue];
        }
        
        
        if (statusCode == 401) {
            // 401错误处理
            [DSYUtils showResponseError_401_ForViewController:viewcontroller];
        } else if (statusCode == 404) {
            [DSYUtils showResponseError_404_ForViewController:viewcontroller message:@"未找到该用户，是否登陆" okHandler:^(UIAlertAction *action) {
                [viewcontroller pushToLoginController];
            } cancelHandler:^(UIAlertAction *action) {
                if (completeBlock) {
                    [MBProgressHUD hideHUD];
                    completeBlock();
                }
            }];
        } else {
            [MBProgressHUD hideHUDForView:viewcontroller.view];
            XYErrorHud *errorHud = [[XYErrorHud alloc] initWithTitle:@"网络繁忙" andDoneBtnTitle:nil andDoneBtnHidden:YES];
            [viewcontroller.view.window addSubview:errorHud];
            if (completeBlock) {
                [MBProgressHUD hideHUD];
                completeBlock();
            }
        }
    }];
}

- (void)updateMyAccountWithComplete:(DSYAccountCompleteBlock)completeBlock {
    
    
    NSString *timestamp = [LYDTool createTimeStamp];
    NSDictionary *secretDict = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN};
    
    NSString *sign = [LYDTool createMD5SignWithDictionary:secretDict];
    NSDictionary *para = @{@"appKey":APPKEY, @"timestamp":timestamp, @"deviceId":DEVICEID, @"token":TOKEN, @"accountId":@([DSYUser sharedDSYUser].accountId), @"sign":sign};
    
    
    //    [MBProgressHUD hideHUDForView:viewcontroller.view];
    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/account/info", APIPREFIX] parameters:para success:^(id data) {
        [self clean];
        id backData = LYDJSONSerialization(data);
        NSLog(@"%@",backData);
        self.refresh = YES;
        [self setValuesForKeysWithDictionary:backData[@"account"]];
        // 数据加载成功后设置相应的信息
        //        [self setUpInformation];
        NSInteger statusCode = [backData[@"code"] integerValue];
        [self setValuesForKeysWithDictionary:backData[@"account"]];
        // 数据加载成功后设置相应的信息
        if (completeBlock) {
            completeBlock();
        }
    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
        if (completeBlock) {
            completeBlock();
        }
    }];
}


- (void)clean {
    self.mobile = @"";
    self.nickName = @"";
    self.realName = @"";
    self.idNumber = @"";
    self.email = @"";
    self.avatar = @"";
    self.ipsAccount = @"";
    
    self.balance = 0.0;
    self.availableBalance = 0.0;
    self.totalCorpus = 0.0;
    self.totalInterest = 0.0;
    self.totalAsset = 0.0;
    self.freeze = 0.0;
    self.canInvestNew = 0;
    self.canInvestPlanNew = 0;
    self.canComment = NO;
    self.refresh = YES;
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if (value == nil) {
        value = @"";
    } else {
        [super setValue:value forKey:key];
    }
}

@end
