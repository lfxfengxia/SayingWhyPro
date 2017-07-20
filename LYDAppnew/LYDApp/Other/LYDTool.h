//
//  LYDTool.h
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error,AFHTTPRequestOperation *operation);

@interface LYDTool : NSObject
+ (void)sendPutWithUrl1:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;
+ (void)sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;

+ (void)sendPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;

+ (void)sendPutWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;

+ (void)sendDeleteWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock;

+ (void)uploadFileWithUrl:(NSString *)url parameters:(NSDictionary *)dict image:(NSData *)image accountId:(NSString *)accountId success:(SuccessBlock)successblock fail:(FailBlock)failblock;

+ (NSString *)convertNull:(id)object;

+ (NSString *)convertReturn:(id)object;

+ (UIColor *)transformColorToUIColor:(NSString *)colorStr;

+ (NSArray *)getSkuStandardsTitleArr:(NSArray *)standards;

+ (NSArray *)getSkuStandardsArr:(NSArray *)standards skuArr:(NSArray *)skus;

+ (NSArray *)getSkusSearchArr:(NSArray *)skus standards:(NSArray *)standards;

+ (NSString *)getSkuStr:(NSDictionary *)skuDict;

+ (NSArray *)convertDictToArr:(NSDictionary *)dict;

+ (NSArray *)convertJsonStringToDict:(NSString *)str;

+ (NSDictionary *)convertJsonString:(NSString *)str;

// 校验手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber;

// 校验密码
+ (BOOL)checkPassword:(NSString*)password;

+ (NSString *)timeFormatted:(NSString *)totalSeconds;

+ (NSString *)timeFormattedToMinute:(NSString *)totalSeconds;

+ (NSString *)timeFormattedGetHour:(NSString *)totalSeconds;

+ (NSString *)timeFormattedGetYear:(NSString *)totalSeconds;

+ (NSString *)timeFormattedWithoutYear:(NSString *)totalSeconds;

+ (NSString *)createTimeStamp;

+ (NSString *)createMD5SignWithDictionary:(NSDictionary *)dict;

@end
