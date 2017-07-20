//
//  LYDTool.m
//  LYDApp
//
//  Created by dookay_73 on 16/10/31.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "LYDTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LYDTool

+ (void)sendGetWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manage.requestSerializer.timeoutInterval = 60;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    url = [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manage GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error,operation);
    }];
}


+ (void)sendPostWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error,operation);
    }];
    
}

+ (void)uploadFileWithUrl:(NSString *)url parameters:(NSDictionary *)dict image:(NSData *)image accountId:(NSString *)accountId success:(SuccessBlock)successblock fail:(FailBlock)failblock {
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    [manage.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    url = [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manage POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg", str];
        
        
        //        [formData appendPartWithFormData:imgData name:fileName];
        [formData appendPartWithFileData:image name:@"avatar" fileName:fileName mimeType:@"image/jpeg"];
        NSLog(@"%@", formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error, operation);
    }];

}

+ (void)sendPutWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage PUT:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error,operation);
    }];
    
}



+ (void)sendPutWithUrl1:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    [manage.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Authorization"];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage PUT:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error,operation);
    }];
    
}




+ (void)sendDeleteWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successblock fail:(FailBlock)failblock
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manage DELETE:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successblock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failblock(error,operation);
    }];
}

+ (UIColor *)transformColorToUIColor:(NSString *)colorStr
{
    NSMutableString *color = [NSMutableString stringWithString:colorStr];
    // 转换成标准16进制数
    [color replaceCharactersInRange:[color rangeOfString:@"#" ] withString:@"0x"];
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = (colorLong & 0xFF0000 )>>16;
    int G = (colorLong & 0x00FF00 )>>8;
    int B =  colorLong & 0x0000FF;
    
    //string转color
    UIColor *wordColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
    return wordColor;
}

+ (NSString*)convertNull:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        object = @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        object = @"";
    }
    else if (object==nil){
        object = @"";
    }
    return object;
    
}

+ (NSString *)convertReturn:(id)object{
    
    
    NSString *headerData=object;
    headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return headerData;
    
}

+ (NSArray *)getSkuStandardsTitleArr:(NSArray *)standards
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in standards) {
        NSString *str = [dict valueForKey:@"title"];
        [tempArr addObject:str];
    }
    NSArray *standardsArr = [NSArray arrayWithArray:tempArr];
    return standardsArr;
}

+ (NSArray *)getSkuStandardsArr:(NSArray *)standards skuArr:(NSArray *)skus
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dict in standards) {
        NSString *key = [dict valueForKey:@"title"];
        NSMutableArray *skusTemp = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dict in skus) {
            NSString *title = [[dict valueForKey:@"sku"] valueForKey:key];
            if (skusTemp.count == 0) {
                [skusTemp addObject:title];
            } else {
                NSMutableArray *tempSku = [NSMutableArray arrayWithArray:skusTemp];
                for (int i = 0; i < tempSku.count; i ++) {
                    NSString *str = tempSku[i];
                    if ([title isEqualToString:str]) {
                        break;
                    } else {
                        if (i == tempSku.count - 1) {
                            [skusTemp addObject:title];
                        }
                    }
                }
            }
        }
        [tempArr addObject:skusTemp];
    }
    
    NSArray *standardsArr = [NSArray arrayWithArray:tempArr];
    return standardsArr;
}

+ (NSArray *)getSkusSearchArr:(NSArray *)skus standards:(NSArray *)standards
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *dict in skus) {
        NSMutableDictionary *skuDict = [[NSMutableDictionary alloc] init];
        NSMutableString *name = [[NSMutableString alloc] init];
        
        for (int i = 0; i < [[[dict valueForKey:@"sku"] allKeys] count]; i ++) {
            NSString *key = [standards[i] valueForKey:@"title"];
            [name appendFormat:@"%@:%@,",key,[[dict valueForKey:@"sku"] valueForKey:key]];
        }
        
        //        for (NSString *key in [[dict valueForKey:@"sku"] allKeys]) {
        //            [name appendFormat:@"%@:%@,",key,[[dict valueForKey:@"sku"] valueForKey:key]];
        //            //[name insertString:[NSString stringWithFormat:@"%@:%@,",key,[[dict valueForKey:@"sku"] valueForKey:key]] atIndex:0];
        //        }
        name = (NSMutableString *)[name substringToIndex:name.length - 1];
        [skuDict setObject:name forKey:@"name"];
        [skuDict setObject:[dict valueForKey:@"id"] forKey:@"skuId"];
        [skuDict setObject:[dict valueForKey:@"price"] forKey:@"price"];
        [skuDict setObject:[dict valueForKey:@"inventory"] forKey:@"number"];
        [skuDict setObject:[dict valueForKey:@"sales"] forKey:@"sales"];
        
        [tempArr addObject:skuDict];
    }
    NSArray *skusSearchArr = [NSArray arrayWithArray:tempArr];
    return skusSearchArr;
}

+ (NSString *)getSkuStr:(NSDictionary *)skuDict
{
    
    if ([[skuDict allKeys] count] > 0) {
        NSMutableString *mutStr = [[NSMutableString alloc] init];
        for (NSString *str in [skuDict allKeys]) {
            NSString *value = [skuDict valueForKey:str];
            [mutStr appendFormat:@"%@:%@,",str,value];
        }
        NSString *skuStr = [mutStr substringToIndex:mutStr.length - 1];
        return skuStr;
    }
    return @"默认规格";
    
}

+ (NSArray *)convertDictToArr:(NSDictionary *)dict
{
    NSMutableArray *keysArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *valuesArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *kvsArr = [NSMutableArray arrayWithCapacity:0];
    
    [keysArr addObject:@"all"];
    [valuesArr addObject:@"全部"];
    
    for (NSString *str in [dict allKeys]) {
        
        [keysArr addObject:str];
        
    }
    
    for (int i = 0; i < keysArr.count; i ++) {
        if (i == 0) {
            continue;
        }
        NSString *str = [dict valueForKey:keysArr[i]];
        [valuesArr addObject:str];
    }
    
    for (int i = 0; i < keysArr.count; i ++) {
        
        NSDictionary *dict = @{keysArr[i]:valuesArr[i]};
        [kvsArr addObject:dict];
    }
    
    NSArray *kvA = [NSArray arrayWithArray:kvsArr];
    return kvA;
}

+ (NSArray *)convertJsonStringToDict:(NSString *)str {
    
    if (![str isKindOfClass:[NSNull class]] && str != nil) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *array = LYDJSONSerialization(data);
        return array;
    }
    return [NSArray array];
    
    
    
}

+ (NSDictionary *)convertJsonString:(NSString *)str {
    if (![str isKindOfClass:[NSNull class]] && str != nil) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *array = LYDJSONSerialization(data);
        return array;
    }
    return [NSDictionary dictionary];
    
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


+ (BOOL)checkTelNumber:(NSString*)mobileNum

{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)checkPassword:(NSString*)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
}

+ (NSString *)timeFormatted:(NSString *)totalSeconds
{
    NSInteger second = [totalSeconds integerValue] / 1000;
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *dateStr = [[NSString stringWithFormat:@"%@",localeDate] substringToIndex:10];
    NSLog(@"%@",dateStr);
    return dateStr;
}

+ (NSString *)timeFormattedToMinute:(NSString *)totalSeconds
{
    NSInteger second = [totalSeconds integerValue];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *dateStr = [[NSString stringWithFormat:@"%@",localeDate] substringToIndex:16];
    NSLog(@"%@",dateStr);
    return dateStr;
}


+ (NSString *)timeFormattedGetYear:(NSString *)totalSeconds
{
    NSInteger second = [totalSeconds integerValue];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *dateStr = [[NSString stringWithFormat:@"%@",localeDate] substringToIndex:10];
    NSLog(@"%@",dateStr);
    return dateStr;
}

+ (NSString *)timeFormattedGetHour:(NSString *)totalSeconds
{
    NSInteger second = [totalSeconds integerValue];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *dateStr = [[NSString stringWithFormat:@"%@",localeDate] substringFromIndex:11];
    NSString *hourStr = [dateStr substringToIndex:5];
    NSLog(@"%@",hourStr);
    return hourStr;
}

+ (NSString *)timeFormattedWithoutYear:(NSString *)totalSeconds
{
    NSInteger second = [totalSeconds integerValue];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSString *dateStr = [[NSString stringWithFormat:@"%@",localeDate] substringToIndex:10];
    NSString *noyearStr = [[NSString stringWithFormat:@"%@",dateStr] substringFromIndex:5];
    NSLog(@"%@",dateStr);
    return noyearStr;
    
}

+ (NSString *)createTimeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    NSLog(@"timeString:%@",timeString);
    return timeString;
}

+ (NSString *)createMD5SignWithDictionary:(NSDictionary *)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    
    NSArray *keys = [dict allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (   ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@""]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"sign"]
            && ![[NSString stringWithFormat:@"%@",[dict objectForKey:categoryId]] isEqualToString:@"appSecret"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段
    [contentString appendFormat:@"appSecret=%@",@"123456"];
    
    NSLog(@"contentString = %@",contentString);
    
    //MD5 获取Sign签名
    NSString *md5Sign =[self md5:contentString];
    
    NSLog(@"%@",md5Sign);
    //
    return md5Sign;
}




// MD5加密算法
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



@end
