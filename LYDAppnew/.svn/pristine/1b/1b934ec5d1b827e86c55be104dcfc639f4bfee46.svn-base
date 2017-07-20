//
//  DSYUser.m
//  LYDApp
//
//  Created by dai yi on 2016/12/18.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYUser.h"

#define kDSYUserId @"dsy_userId"
#define kDSYUserName @"dsy_userName"
#define kDSYAccountId @"dsy_accountId"

@implementation DSYUser

singleton_implementation(DSYUser);
@synthesize accountId = _accountId;
@synthesize userId    = _userId;
@synthesize userName  = _userName;

- (void)setUserId:(NSInteger)userId {
    _userId = userId;
    
    [self saveUserUserToSanbox];
}

- (void)setUserName:(NSString *)userName {
    _userName = [userName copy];
    
    [self saveUserUserToSanbox];
}

- (void)setAccountId:(NSInteger)accountId {
    _accountId = accountId;
    
    [self saveUserUserToSanbox];
}

- (NSInteger)userId {
    if (_userId <= 0) {  // 如果读取出来的出现不正确现象，重新读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _userId = [defaults integerForKey:kDSYUserId];
    }
    return _userId;
}

- (NSString *)userName {
    if (!_userName || _userName.length <= 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _userName = [defaults objectForKey:kDSYUserName];
    }
    return _userName;
}

- (NSInteger)accountId {
    if (_accountId <= 0) { // 如果读取出来的出现不正确现象，重新读取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _accountId = [defaults integerForKey:kDSYAccountId];
    }
    return _accountId;
}


- (void)saveUserUserToSanbox {
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setInteger:self.userId    forKey:kDSYUserId];
    [defults setObject:self.userName   forKey:kDSYUserName];
    [defults setInteger:self.accountId forKey:kDSYAccountId];
    
    [defults synchronize];
}

- (void)loadUserUserFromSanbox {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userId    = [defaults integerForKey:kDSYUserId];
    self.userName  = [defaults objectForKey:kDSYUserName];
    self.accountId = [defaults integerForKey:kDSYAccountId];
    //    [defaults synchronize];
}

- (void)removeUserFromSanBox {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDSYUserId];
    [defaults removeObjectForKey:kDSYUserName];
    [defaults removeObjectForKey:kDSYAccountId];
//    [defaults synchronize];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.userId = [value integerValue];
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
