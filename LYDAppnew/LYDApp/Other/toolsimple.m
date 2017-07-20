
//
//  toolsimple.m
//  LYDApp
//
//  Created by fcl on 17/3/22.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "toolsimple.h"

@implementation toolsimple
+(toolsimple*) sharedPersonalData
{
    static toolsimple* _singleton ;
    if (_singleton == nil)
    {
        _singleton = [[toolsimple alloc] init] ;

        _singleton.isalert=0;
        _singleton.isAnZhuang=0;
        
        
    }
    return _singleton ;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id) init
{
    self = [super init] ;
    if (self)
    {
        
    }
    return self ;
}
@end
@implementation UIView (toolsimple)
-(UIViewController *)parentController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end


