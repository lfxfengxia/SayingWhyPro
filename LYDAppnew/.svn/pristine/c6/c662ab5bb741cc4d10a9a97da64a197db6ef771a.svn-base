//
//  NSString+DSY.m
//  LYDApp
//
//  Created by dai yi on 2016/12/2.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "NSString+DSY.h"

@implementation NSString (DSY)

- (NSString *)stringDeleteBlank {
    NSString *str = [self copy];
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去除掉其它位置的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return str;
}

@end
