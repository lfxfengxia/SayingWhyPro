//
//  NSDate+DSY.m
//  DDJApp
//
//  Created by dai yi on 2016/11/25.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "NSDate+DSY.h"

@implementation NSDate (DSY)

- (NSString *)getDateStringWithFormatterStr:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:self];
}


@end
