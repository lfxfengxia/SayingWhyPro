//
//  DSYServiceProtocolViewController.m
//  LYDApp
//
//  Created by dai yi on 2016/11/7.
//  Copyright © 2016年 dookay_73. All rights reserved.
//

#import "DSYServiceProtocolViewController.h"


@interface DSYServiceProtocolViewController ()<UIGestureRecognizerDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;    /**< 主要视图的承载器 */

@property (nonatomic, strong) UILabel *showDescriptionLabel;   /**< 显示协议规则的文字 */
@property (nonatomic, strong) UIWebView *contentWibView;     /**< 主视图 */

@end

@implementation DSYServiceProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleNavigationBarLabel.text = @"服务协议";
    
    //[self mainScrollView];
    //[self showDescriptionLabel];
    [self contentWibView];
    [self loadData];

}


- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREENW, self.view.height - 64 - H(45) )];
        [self.view addSubview:_mainScrollView];
        
    }
    return _mainScrollView;
}


- (void)loadData {
    
//    [LYDTool sendGetWithUrl:[NSString stringWithFormat:@"%@/help/about", APIPREFIX] parameters:nil success:^(id data) {
//        id backData = LYDJSONSerialization(data);
//        
//        
//        [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:backData[@"url"]]]];
//    } fail:^(NSError *error, AFHTTPRequestOperation *operation) {
//        [MBProgressHUD showError:@"网络繁忙" toView:self.view];
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
    
    //NSString *strurl=[NSString stringWithFormat:@"http://116.236.150.198:8190/content/about/public?type=investServerAgreement&parameter=%ld",(long)self.model.investId];
    NSString *strurl=[NSString stringWithFormat:@"%@/content/about/public?type=investServerAgreement&parameter=%ld",ServiceAgreement,(long)self.model.investId];
     [self.contentWibView loadRequest:[NSMutableURLRequest requestWithURL:[NSURL URLWithString:strurl]]];
    
    
}


- (UIWebView *)contentWibView {
    if (!_contentWibView) {
        _contentWibView = [[UIWebView alloc] init];
        [self.view addSubview:_contentWibView];
        [_contentWibView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
        }];
        
        _contentWibView.delegate = self;
        _contentWibView.backgroundColor = RGB(249, 249, 249);
        
        
        
        
        NSString *oldAgent = [_contentWibView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        
        NSLog(@"old agent :%@", oldAgent);
        
        NSString *newAgent = @"";
        if ([oldAgent hasSuffix:@"lyd-app"]) {
            newAgent = oldAgent;
        } else {
            newAgent = [oldAgent stringByAppendingString:@"lyd-app"];
        }
        
        NSLog(@"new agent :%@", newAgent);
        
        //regist the new agent
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }
    return _contentWibView;
}


//- (UILabel *)showDescriptionLabel {
//    if (!_showDescriptionLabel) {
//        _showDescriptionLabel = [[UILabel alloc] initWithFrame:self.mainScrollView.bounds];
//        [self.mainScrollView addSubview:_showDescriptionLabel];
//        _showDescriptionLabel.numberOfLines = 0;
//        _showDescriptionLabel.textColor = rgba(102, 102, 102, 1);
//        _showDescriptionLabel.font = DSY_NORMALFONT_14;
//        NSString *text  = @"    本协议由您（以下称“甲方”）和零用贷网站（运营方：上海零用贷金融信息服务有限公司，以下称“乙方”）共同签订。\n \
//        甲乙双方经友好协商，本着平等自愿、诚实信用的原则，就甲方使用乙方提供的“理财计划”投标及资金管理服务的有关事项达成如下协议：\n \
//        一、“理财计划概述 \n \
//        “理财计划”是乙方推出的由乙方作为甲方代理人代甲方完成投标及资金管理的服务，甲方使用该服务可以按照乙方推荐甲方确认的设定条件投资乙方平台上的借款标的。为降低甲方因投资标的过于集中而带来的违约风险，甲方了解并同意投资理财计划的资金， 将根据乙方推荐甲方确定的事先设定的目标收益率，在乙方平台各类投资专区在收益风险数据综合测算的基础上进行分散量化投资和管理。通过分散量化投资所产生的每月回款（含本金和利息）也将在产品周期内继续投资，直至服务期结束。\n \
//        二、服务内容\n  \
//        甲方使用“理财计划”投标服务投资的标的为：新手安全标专区、第三方保障区、中风险收益区和高风险收益区的借款标的，理财计划的服务期参见理财计划页面；甲方委托乙方的服务期一旦生效，除本协议约定的终止情形外，甲乙双方均无权提前终止。\
//        \n \
//        三、投资说明\n  \
//        \
//        1、甲方保证其为履行本协议而向乙方提供的全部资料均真实、有效。\n \
//        \n \
//        2、甲方保证用于投资的资金来源合法，甲方是该资金的合法所有人，如有第三方对资金归属、合法性问题提出异议，由甲方自行解决。如未能解决，则甲方承诺放弃享有其所出借资金带来的利息等收益。同时，甲方保证其为履行本协议而向乙方提供的全部资料均真实、有效。\n \
//        \n \
//        3、甲方同意根据甲方在本协议中确认的投资方向和规则由乙方代为进行优先投标和资金管理，根据乙方网站的相关协议及规则对投资理财计划的资金进行出借和债权转让。\n \
//        \n \
//        4、选择使用理财计划投资的资金，其收益时间以成功投资本协议第二条中的借款标的时间为准，服务期内，甲方自主选择将投资借款列表收到的还款本金和利息（包括但不限于等额本息还款所还本息、提前还款所还本息等）分散量化投资到新的借款标中直到服务期结束，服务期结束后停止继续投资。使用期内，甲方投资理财计划的金额不能转让或提现。\n \
//        \n \
//        5、服务期内的投资所产生的投资收益和损失均由甲方自行承担。服务期结束后尚未收回的本金和利息，甲方自主决定将该等债权进行转让，债权转让所得资金及投资回款所得将会在服务期结束后2个工作日内返还到甲方在乙方平台开立的账户。如使用期结束后2个工作日内甲方通过理财计划投资的借款列表相对应的债权未能全部转让，则甲方了解并同意继续持有该等债权，持有期间甲方每月仍将获得相应的本金及/或利息回款，并承担该等债权对应的借款人逾期还款 \n \
//        \n \
//        6、出于对甲方利益的保护，当理财计划投资的借款标的出现逾期时，且甲方决定采取法律方式追索债权时，甲方有权向零用贷索取其他借出人的联系方式，以便共同进行债权追索。\n  \
//        \n \
//        7、甲方有权向零用贷了解与理财计划有关的其他情况，如零用贷认为其要求合理的，零用贷会在合理范围内，并在自身数据能力允许的范围内予以提供。 \n \
//        \n \
//        8、如因司法机关或行政机关对甲方采取强制措施导致其本次投资金额被全部或部分扣划，视为服务期提前结束，本协议自动终止。本协议因上述原因自动终止的，甲方将不再享有相应收益。\n  \
//        \n \
//        四、费用说明 \n \
//        \n \
//        当期理财计划售罄后，乙方从募集资金中计提一定比例作为乙方的服务费，具体提取比例参见《 理财计划产品说明书》。乙方保留调整本协议项下服务费的权利，但调整后的服务费收取标准需由甲乙双方协商确认。\n \
//        \n \
//        五、风险自助准备金 \n n\
//        /n\
//        1、理财计划设立风险自助准备金，用于理财计划存续期间所有借出人的本金或收益出现风险时的自助保障。 \n \
//        \n \
//        2、当期理财计划售罄后，乙方从募集资金中计提一定比例作为当期理财计划的风险自助准备金，具体提取比例参见《 理财计划产品说明书》。乙方保留调整本协议项下风险自助准备金的权利，但调整后的风险自助准备金收取标准需由甲乙双方协商确认。 \n \
//        \n \
//        3、风险自助准备金的设立目的是覆盖甲方的潜在损失，在理财计划的存续期间，乙方不得将风险自助准备金挪作他用。但在全部理财计划终止后，如果甲方的预期收益均已实现，风险自助准备金的剩余资金归属于乙方所有。 \n \
//        \n \
//        六、风险提示 \n \
//        \n \
//        甲方知悉、了解并同意，本协议项下涉及的任何收益均为预期收益，甲方能否按时收回全部本金和利息最终取决于借款人能否按时还款，因此甲方出借本息存在不能够按期收回的风险。 \n \
//        \n \
//        七、争议解决 \n \
//        \n \
//        因本协议项下服务产生的纠纷，双方先行协商解决，协商不成的，任何一方可向乙方所在地法院提起诉讼。 \n \
//        \n \
//        八、其他 \n \
//        \n \
//        1、由于地震、火灾、战争、电力中断、黑客攻击、计算机病毒、系统或网络故障等不可抗力导致的交易中断、延误的，甲乙双方互不追究责任。但应在条件允许的情况下，应采取一切必要的补救措施以减小不可抗力造成的损失。 \n \
//        \n \
//        2、双方均确认，本协议的签订、生效和履行以不违反法律法规的规定为前提。如果本协议中的任何一条或多条被司法部门认定为违反所须适用的法律法规，则该条将被视为无效，但该无效条款并不影响本协议其他条款的效力。 \n \
//        3、《 理财计划产品说明书》为本协议组成部分，与本协议具有同等法律效力。";
//        _showDescriptionLabel.text = text;
//        [_showDescriptionLabel sizeThatFits:CGSizeMake(200, MAXFLOAT)];
//        CGFloat heigth = [Helper heightOfString:text font:DSY_NORMALFONT_14 width:self.mainScrollView.width - X(24)];
//        
//        _showDescriptionLabel.frame = CGRectMake(X(12), Y(12), self.mainScrollView.width - X(24), heigth);
//        
//        
//        
//        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.width, _showDescriptionLabel.height + Y(24));
//        
//    }
//    return _showDescriptionLabel;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
