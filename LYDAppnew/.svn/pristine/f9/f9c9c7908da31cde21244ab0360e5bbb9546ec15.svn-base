//  欢迎页
#define NUM  4
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "WelcomeViewController.h"
//#import "FirstViewController.h"
#import "AppDelegate.h"
#import "XYMainTabBarController.h"
#import "toolsimple.h"

@interface WelcomeViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *myScrollView;
@property(strong,nonatomic)UIPageControl *myPageView;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myScrollView = [self createScrollView];
    _myPageView = [self createPageView];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_myScrollView];
    [self.view addSubview:_myPageView];
}


-(UIPageControl *)createPageView
{
    UIPageControl *pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.35, SCREEN_HEIGHT*0.86, SCREEN_WIDTH*0.3, 30)];
    pageView.numberOfPages = NUM;
    pageView.currentPage = 0;
    pageView.pageIndicatorTintColor=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    pageView.userInteractionEnabled=NO;
    //pageView.currentPageIndicatorTintColor=[UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:230.0/255.0 alpha:1];
    pageView.currentPageIndicatorTintColor=[UIColor orangeColor];
    return pageView;
}



-(void)addEnterBtn:(UIImageView *)image
{
    UIImage *startNormalImag = [UIImage imageNamed:@"立即体验"];
    CGSize imageSize = CGSizeMake(280.0/72*40, 40);
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-imageSize.width)/2, SCREEN_HEIGHT*0.78, imageSize.width, imageSize.height)];
    btn.layer.borderColor=[self colorWithHexString:@"#00baf7"].CGColor;
    btn.layer.borderWidth=1;
    btn.layer.cornerRadius=23;
    [btn setTitleColor:[self colorWithHexString:@"#00baf7"] forState:UIControlStateNormal];
    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startJpjr:) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:btn];
}


- (UIColor *)colorWithHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    // Bypass '#' character
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


-(UIScrollView *)createScrollView
{
    UIScrollView *scorll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scorll.contentSize = CGSizeMake(SCREEN_WIDTH*NUM, 0);
    scorll.pagingEnabled = YES;
    scorll.showsHorizontalScrollIndicator = NO;
    scorll.delegate = self;
    int i = 0;
    for (i=0; i<NUM; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSString *name = [NSString stringWithFormat:@"welcome-%i.png",i+1];
        imageView.image = [UIImage imageNamed:name];
        [scorll addSubview:imageView];
        if (i==NUM-1) {
            imageView.userInteractionEnabled = YES;
            [self addEnterBtn:imageView];
        }
        
    }
    return scorll;
}

-(void)startJpjr:(UIButton *)button
{
    [toolsimple sharedPersonalData].isAnZhuang=1;
    //self.view.window.rootViewController=[[FirstViewController alloc]init];
    UIApplication *app = [UIApplication sharedApplication];
    
    AppDelegate *dele = app.delegate;
    XYMainTabBarController *mainView = [[XYMainTabBarController alloc]initWithNibName:nil bundle:nil];
    dele.window.rootViewController = mainView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _myPageView.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}


@end
