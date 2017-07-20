//
//  AnnouncementViewController.m
//  ManageFinancial
//
//  Created by guochangxin on 16/4/8.
//  Copyright © 2016年 lingyongdai. All rights reserved.
//

#import "AnnouncementViewController.h"
#import "Const.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

@interface AnnouncementViewController ()<UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate>
{
    UITableView* _tableView ;
    UITextView *_textView;
    NSInteger _index;
    UIWebView *_webView;
    NSInteger _totalPage;
    NSMutableArray *     _arrtitleSecon ;
    NSMutableArray *     _arrHtmlRow ;
    NSInteger   _rowHeight;
    NSMutableArray * _heightArr;
    NSMutableDictionary *_showDic;
    BOOL _canClick;  //此处的定义点击与否，再点击事件中并没有起到作用
}

@end

@implementation AnnouncementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公告";
    self.view.backgroundColor = [UIColor whiteColor];
//    _canClick=YES;
    
    _arrHtmlRow=[[NSMutableArray alloc]init];
    _heightArr=[[NSMutableArray alloc]init];
    _arrtitleSecon=[[NSMutableArray alloc]init];
    self.currentPage=1;
    [self createUI];
    [self GetHelpDataWithCurrent:self.currentPage PageContain:3];
}
-(void)createUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)] ;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.f green:231/255.f blue:231/255.f alpha:1];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    
    if (iosVersion >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.backgroundColor = [UIColor clearColor] ;
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reFreshData)];
    _tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:_tableView] ;
}

//调用公告接口
-(void)GetHelpDataWithCurrent:(NSInteger)current PageContain:(NSInteger)num
{
    if (self.currentPage==1)
    { 
        [_arrtitleSecon removeAllObjects];
        [_arrHtmlRow removeAllObjects];
        [_heightArr removeAllObjects];
    }
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager] ;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    NSMutableDictionary* dicParamRegister = [[NSMutableDictionary alloc] initWithCapacity:3] ;
    NSString *currentPage = [NSString stringWithFormat:@"%ld",current];
    [dicParamRegister setObject:currentPage forKey:@"currPage"];
    [dicParamRegister setObject:@"3" forKey:@"type"] ;
    //添加登陆等待视图
    UIActivityIndicatorView* aView = [[CommonTools sharedCommonTools] createLoadingView] ;
    [self.view addSubview:aView] ;
    [aView startAnimating] ;
    NSString *URL_changepwd=[NSString stringWithFormat:@"%@%@",severID,getLintriduction];
    [manager POST:URL_changepwd parameters:dicParamRegister progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //去掉等待视图
        [aView stopAnimating] ;
        [aView removeFromSuperview] ;
        NSDictionary* dicResponseReg = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] ;
        if ([dicResponseReg isKindOfClass:[NSDictionary class]])
        {
            
            NSInteger code = [[dicResponseReg objectForKey:@"code"] integerValue];
            NSString *msg=dicResponseReg[@"msg"];
            _totalPage=[dicResponseReg[@"totalPage"] integerValue];
            NSLog(@"_totalPage:%ld",_totalPage);
            if (code==0)
            {
                
                NSArray *helpArr=dicResponseReg[@"helpCenters"];
                for (NSDictionary *dict in helpArr)
                {
                    [_heightArr addObject:@"1"];
                    [_arrtitleSecon addObject:dict[@"title"]];
                    [_arrHtmlRow addObject:dict[@"content"]];
//                    NSLog(@"helpArr = %@",_heightArr);
                }
                [_tableView reloadData];
            }
            else if(code==-4)
            {
                NSLog(@"提示超时");
                [[CommonTools sharedCommonTools] showAlertViewWithMessage:@"outTimeLogin"] ;
                SafeCenterViewController *safe=[[SafeCenterViewController alloc]init];
                [safe OutTime];
                [self.navigationController popToRootViewControllerAnimated:YES];
                self.navigationController.tabBarController.selectedIndex=0;
                return ;
            }
            else
            {
                UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alter show];
            }
//            _canClick=YES;
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //去掉等待视图
        NSLog(@"出错");
        [aView stopAnimating] ;
        [aView removeFromSuperview] ;
        [[CommonTools sharedCommonTools] showAlertViewWithMessage:@"serverConnectError"] ;
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        return ;
    }];
}


-(void)loadMore
{
    
    if (self.currentPage<_totalPage)
    {
        self.currentPage++;
        [self GetHelpDataWithCurrent:self.currentPage PageContain:3];
//        _canClick=NO;
    }
    else
    {
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }
}


-(void)reFreshData
{
    self.currentPage=1;
    [_showDic removeAllObjects];
    [self GetHelpDataWithCurrent:self.currentPage PageContain:3];
    [_tableView.mj_header beginRefreshing];
//    _canClick=NO;
}

-(void)runthson:(NSString*)str
{
    [_webView loadHTMLString:str baseURL:nil];
}
//调节 高度
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSInteger height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] integerValue];
    webView.frame=CGRectMake(0, 0, self.view.frame.size.width,height);
    _rowHeight=webView.frame.size.height;
    NSString *str=[NSString stringWithFormat:@"%ld",_rowHeight];
    [_heightArr replaceObjectAtIndex:_index withObject:str];
    _webView=nil;
    
}

#pragma mark - tableView datasource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrtitleSecon.count ;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*hy ;
}
//每组的组头
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50*hy)];
    
    header.backgroundColor = [UIColor colorWithRed:231/255.f green:231/255.f blue:231/255.f alpha:1] ;
    
    if (_arrtitleSecon.count==0)
    {
        
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*hx, 10*hy, 2*hx, 20*hy)];
        imageView.backgroundColor = [UIColor redColor];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 10*hy, WIDTH, 40*hy)];
        //label
        UILabel* labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30*hx, 0, WIDTH-40*hx-30*hx, 40*hy)] ;
        labelTitle.textColor = HexRGBAlpha(0x585758, 1) ;
        labelTitle.numberOfLines=0;
        labelTitle.text = _arrtitleSecon[section] ;
        
        labelTitle.font = [UIFont systemFontOfSize:myFontSize+2] ;
        labelTitle.textAlignment = NSTextAlignmentLeft ;

        labelTitle.backgroundColor = [UIColor clearColor] ;
//        if (self.num == 1) {
//            labelTitle.backgroundColor = [UIColor yellowColor] ;
//        }
        [view addSubview:labelTitle] ;
        //箭头
        UIImageView* arrow1 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-30*hx, 0, 30*hx, 40*hy)] ;
        if (![_showDic objectForKey:[NSString stringWithFormat:@"%ld",section]])
        {
            arrow1.image = [UIImage imageNamed:@"返回2"] ;
//            NSLog(@"_showDic1 : %@",_showDic);
        }
        else
        {
            arrow1.image = [UIImage imageNamed:@"xialajian"] ;
//            NSLog(@"_showDic2 : %@",_showDic);
        }
//        arrow1.tag=section+1;
        arrow1.contentMode = UIViewContentModeCenter ;
        arrow1.backgroundColor = [UIColor clearColor] ;
        [view addSubview:imageView];
        [view addSubview:arrow1] ;
        view.backgroundColor=[UIColor whiteColor];
        [header addSubview:view];
    }
    //view的tag就等于section 代表点击了哪一个组
    header.tag=section;
    
    UITapGestureRecognizer *singleRec=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    singleRec.numberOfTapsRequired=1;
    [singleRec setNumberOfTouchesRequired:1];
    [header addGestureRecognizer:singleRec];
    if (self.num == 1) {
        [self singleTap:0];
        self.num = 0;
    }
    return  header;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_canClick)
//    {
        if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]])
        {
            NSLog(@"_showDic0 : %@",_showDic);
            NSInteger h=[_heightArr[indexPath.section] integerValue];
            NSLog(@"h = %ld",h);
            return h;
        }
    NSLog(@"_showDic00 : %@",_showDic);

//        else
//        {
        
            return 0 ;
//        }
//    }
//    else
//    {
//        return 0;
//    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* str;
    if (_arrtitleSecon.count==0)
    {
        str=@"00";
    }
    else
    {
        str = [NSString stringWithFormat:@"%ld %ld", (long)indexPath.section, (long)indexPath.row] ;
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str] ;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str] ;
    cell.backgroundColor = [UIColor clearColor] ;
    cell.clipsToBounds=YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    if (_arrtitleSecon.count==0)
    {
        
    }
    else
    {
        [self tableViewCell:cell layoutAtSection:indexPath.section andRow:indexPath.row] ;
    }
    return cell ;
}
//自定义Layout Cell
-(void) tableViewCell:(UITableViewCell*) tableViewCell layoutAtSection:(NSInteger) section andRow:(NSInteger) row
{
    UIWebView *wb=[[UIWebView alloc]initWithFrame:CGRectMake(0, 10*hy, WIDTH, _rowHeight)];
    wb.backgroundColor=[UIColor clearColor];
    //    NSLog(@"_arrHtmlRow:%@",_arrHtmlRow[section]);
    [wb loadHTMLString:_arrHtmlRow[section] baseURL:nil];
    wb.scrollView.scrollEnabled=NO;
    [tableViewCell addSubview:wb];
}
-(void)singleTap:(UIGestureRecognizer*)recognzier
{
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 45*hy)];
    _webView.delegate=self;
    NSInteger didSecton=recognzier.view.tag;
    NSLog(@"didsection = %ld",didSecton);
    NSLog(@"_showDic3 : %@",_showDic);
    if (!_showDic)
    {
        _showDic=[[NSMutableDictionary alloc]init];
        NSLog(@"_showDic33 : %@",_showDic);
    }
    NSLog(@"_showDic4 : %@",_showDic);
    //将点击了哪一组转换成字符串
    NSString *key=[NSString stringWithFormat:@"%ld",didSecton];
    if (![_showDic objectForKey:key])
    {
        [_showDic removeAllObjects];
//        _showDic=[[NSMutableDictionary alloc]init];
        [_showDic setObject:@"1" forKey:key];
        NSLog(@"_showDic5 : %@",_showDic);
    }
    else//判断的问题，因此并不能走到这一步
    {
        [_showDic removeObjectForKey:key];//并没有用，因为这个else从来都没走
        NSLog(@"_showDic6 : %@",_showDic);
    }
//    NSLog(@"_showDic7 : %@",_showDic);
    [self runthson:_arrHtmlRow[didSecton]];
    _index=didSecton;
    NSString *_section=[NSString stringWithFormat:@"%ld",didSecton];
    //记得一定要刷新tabelView，不然没有效果
    [self performSelector:@selector(relodTableView:) withObject:_section afterDelay:0.5];
    
    
    
}
-(void)relodTableView:(NSString*)SectionStr
{
    NSInteger didSection=[SectionStr integerValue];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
}



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
