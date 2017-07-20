//
//  DSYUser.h
//  LYDApp
//
//  Created by dai yi on 2016/12/18.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYBaseModel.h"

@interface DSYUser : DSYBaseModel

singleton_interface(DSYUser);

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic,   copy) NSString *userName;
@property (nonatomic, assign) NSInteger accountId;

- (void)saveUserUserToSanbox;
- (void)loadUserUserFromSanbox;
- (void)removeUserFromSanBox;

@end
