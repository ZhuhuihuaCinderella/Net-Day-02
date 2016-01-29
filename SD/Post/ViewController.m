//
//  ViewController.m
//  Post
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *btn;

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
        NSLog(@"%@",dict);
    }];
    
    NSString *headimage = @"http://10.0.8.8/sns/my/headimage.php?uid=82781";
//    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headimage]];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:headimage] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //用sdwebimage 下载图片的时候，就会保存在沙盒里面。当你再次下载一个url的时候，就会直接去沙盒里面寻找，保存时的名称 直接用的是url加密之后的字符串
    
    NSLog(@"沙盒路径%@",NSHomeDirectory());
    //self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn sd_setImageWithURL:[NSURL URLWithString:headimage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder"]];
    NSURL *url1 = [NSURL URLWithString:headimage];
    UIImage *imageP = [UIImage imageNamed:@""];
     [self.headImage sd_setImageWithURL:url1 placeholderImage:imageP options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         NSLog(@"接收数据大小%ld 期望的大小%ld",receivedSize,expectedSize);
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         NSLog(@"下载完成");
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
