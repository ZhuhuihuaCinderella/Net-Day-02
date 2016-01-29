//
//  ViewController.m
//  3-SDWebImage
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "UserTableViewCell.h"
#import "AFNetworking.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataSource = [NSMutableArray new];
   // [self loadDataSource2];
    [self loadDataAFPost];
    [self createTabelView];
    
}
- (void)createTabelView {
    _tabelView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    
}
- (void)loadDataSource2 {
    
    //请求管理器
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    //第二 响应解析器，指定数据解析方式。如果我们知道我们的接口是json格式的就可以在这里设置 省了一步（json解析）
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    //发起请求
    //1 url (字符串就行) 2 get请求参数，一般是字典
    NSString *urlStr = @"http://iappfree.candou.com:8080/free/applications/limited";
    NSDictionary *params = @{@"currency": @"rmb", @"page": @"1"};
    [manger GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功回调
        NSLog(@"请求成功%@",responseObject);
        NSArray *apps = [responseObject objectForKey:@"applications"];
        for (NSDictionary *dict  in apps) {
            UserModel *app = [UserModel new];
            app.username = dict[@"name"];
            app.headimage = dict[@"iconUrl"];
            [_dataSource addObject:app];
        }
        [self.tabelView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //失败的回调
        NSLog(@"请求失败%@",error);
    }];
}
- (void)loadDataAFPost {
    AFHTTPRequestOperationManager *maneger = [AFHTTPRequestOperationManager manager];
    
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php";
    NSDictionary *params = @{@"a":@"list", @"c": @"data", @"type":@10};
    //json格式的所以 就不用这种 响应解析器
    [maneger POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //成功里面 装模型
        NSLog(@"$%@",responseObject);
        NSArray *list = [responseObject objectForKey:@"list"];
        for (NSDictionary * dict in list) {
            //cdn_img text
            UserModel * model = [UserModel new];
            model.username = dict[@"text"];
            model.headimage = dict[@"cdn_img"];
            [self.dataSource addObject:model];
        }
        [self.tabelView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)loadDataSource {
    NSURL *url = [NSURL URLWithString:@"http://10.0.8.8/sns/my/user_list.php?page=1&number=10"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray * users = dict[@"users"];
        for (NSDictionary * dic in users) {
            UserModel * user = [[UserModel alloc] init];
            user.username = dic[@"username"];
            user.headimage = dic[@"headimage"];
            [self.dataSource addObject:user];
        }
        [self.tabelView reloadData];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
#pragma mark - 实现代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //取出对应的model
    UserModel *user = self.dataSource[indexPath.row];
    [cell configData:user];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
