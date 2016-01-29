//
//  ViewController.m
//  Post
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //post请求，带参数的请求，在请求里添加参数
    NSURL *url = [NSURL URLWithString:@"http://10.0.8.8/sns/my/user_list.php?page=1&number=10"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //一般默认为是get请求，可以设置post
    request.HTTPMethod = @"post";
    //参数 第一页十条数据
    NSString *paramStr = @"number=10&page=1";
    //把参数放到请求体 encode 编码
    request.HTTPBody = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
    //发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //拿到的十而精致数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
