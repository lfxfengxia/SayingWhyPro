//
//  xiaoxiCell.m
//  LYDApp
//
//  Created by fcl on 2017/7/1.
//  Copyright © 2017年 dookay_73. All rights reserved.
//

#import "xiaoxiCell.h"
@interface xiaoxiCell ()


@property (nonatomic, strong) UILabel   *pushStr;
@property (nonatomic, strong) UILabel   *pushTime;
@property (nonatomic, strong) UILabel   *title;
@property(nonatomic,strong) UIView *viewline;
@property(nonatomic,strong)UIView *uvbig;

@end


@implementation xiaoxiCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"xiaoxiCell";
    xiaoxiCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[xiaoxiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       cell.backgroundColor =[UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
       // cell.backgroundColor =[UIColor whiteColor];

        [cell createUI];
    }
    return cell;
}

- (void)createUI
{
    _uvbig=[[UIView alloc] init];
    _uvbig.frame=CGRectMake((kSCREENW-KWidth(350))/2, 0, KWidth(350), KHeight(10));
    _uvbig.backgroundColor=[UIColor whiteColor];
    [self addSubview:_uvbig];
    
    
    UIView *uv=[[UIView alloc] init];
    uv.frame=CGRectMake(0, 0, kSCREENW, KHeight(10));
    uv.backgroundColor=[UIColor colorWithRed:0.96 green:0.96 blue:0.95 alpha:1.00];
    [self addSubview:uv];
    
    
    self.title = [[UILabel alloc] init];
    self.title.frame = CGRectMake((KWidth(350)-KWidth(330))/2, uv.maxY, KWidth(330), KHeight(30));
    self.title.text = @"消息标题";
    self.title.font = [UIFont systemFontOfSize:14];
    self.title.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
    self.title.backgroundColor=[UIColor whiteColor];
    self.title.layer.borderColor=[UIColor clearColor].CGColor;
    self.title.layer.borderWidth=10;
    [_uvbig addSubview:self.title];
    
    
    
    
    self.pushTime = [[UILabel alloc] init];
    self.pushTime.frame = CGRectMake((KWidth(350)-KWidth(330))/2, self.title.maxY, KWidth(330), KHeight(30));
    self.pushTime.text = @"日期和时间";
    self.pushTime.font = [UIFont systemFontOfSize:10];
    self.pushTime.textColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:134/255.0 alpha:1/1.0];
    self.pushTime.backgroundColor=[UIColor whiteColor];
    [_uvbig addSubview:self.pushTime];
    
    
    self.viewline = [[UIView alloc] init];
    self.viewline.frame = CGRectMake((KWidth(350)-KWidth(330))/2, self.pushTime.maxY, KWidth(330), 0.1);
    self.viewline.backgroundColor=RGB(242, 242, 242);
    [_uvbig addSubview:self.viewline];
    
    
    
    _pushStr = [[UILabel alloc] init];
    _pushStr.frame = CGRectMake((KWidth(350)-KWidth(330))/2, self.viewline.maxY, KWidth(330), 72);
    _pushStr.numberOfLines = 0;
    _pushStr.text = @"消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息消息";
    _pushStr.font = [UIFont systemFontOfSize:12];
    _pushStr.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1/1.0];
    _pushStr.backgroundColor=[UIColor whiteColor];
    [_uvbig addSubview:_pushStr];
    
}




//-(UIColor *) colorWithHexString: (NSString *)color
//{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return [UIColor clearColor];
//    }
//    
//    // strip 0X if it appears
//    if ([cString hasPrefix:@"0X"])
//        cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//        return [UIColor clearColor];
//    
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    
//    //r
//    NSString *rString = [cString substringWithRange:range];
//    
//    //g
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    
//    //b
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    
//    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
//}





- (void)setModel:(xiaoxiModel *)model
{
    _model = model;
    
    
    

    
        NSTimeInterval _interval=[_model.pushTime doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"%@", [objDateformat stringFromDate: date]);
    
    
    self.pushTime.text=[objDateformat stringFromDate: date];
    
    self.title.text = _model.title;
    
        CGFloat commentH1 = [Helper heightOfString:_model.pushStr font:[UIFont systemFontOfSize:12] width:KWidth(351)];
        _pushStr.frame = CGRectMake((KWidth(350)-KWidth(330))/2, self.viewline.maxY, KWidth(330), commentH1+KHeight(40));
        _pushStr.text = _model.pushStr;
    _uvbig.frame=CGRectMake((kSCREENW-KWidth(350))/2, 0, KWidth(350), _pushStr.maxY);
    self.model.cellHeight = _pushStr.maxY;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
