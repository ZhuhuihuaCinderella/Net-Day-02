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
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataSource = [NSMutableArray new];
    [self loadDataSource];
    [self createTabelView];

}
- (void)createTabelView {
    _tabelView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
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
//    cell.textLabel.text = user.username;
//    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.8.8/sns%@",user.headimage]];
//    UIImage *image = [UIImage imageNamed:@"placeholder"];
//    [cell.imageView sd_setImageWithURL:url placeholderImage:image];
    [cell configData:user];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
