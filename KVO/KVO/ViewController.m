//
//  ViewController.m
//  KVO
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
    //kvo 键值观察，是观察者模式的一种实现，另一种实现是 通知
    //对谁有兴趣 就去观察谁
    //self.view backgroundColor
    //1 谁观察 2观察那个属性 3观察的选项
//    NSKeyValueObservingOptionNew = 0x01,
//    NSKeyValueObservingOptionOld = 0x02,
    [self.view addObserver:self forKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew context:nil];
    //谁观察了，谁就要实现一个方法
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"背景颜色发生了变化");
    //获得新变化的值
    //0.596078 0.8 0.894118 1 淡蓝
    //0.47451 0.976471 0.498039 1 亮绿
    //0.235294 0.968627 0.290196 1
    //0.478431 0.694118 0.384314 1 墨绿
    //0.137255 0.313725 0.866667 1 亮蓝
    //0.796078 0.784314 0.823529 1 浅灰
    UIColor *newColor = change[@"new"];
    NSLog(@"%@",newColor);
}
#define randomValue arc4random()%256/255.0
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    self.view.backgroundColor = [UIColor colorWithRed:randomValue green:randomValue blue:randomValue alpha:1];
}
- (void)dealloc
{
    [self removeObserver:self.view forKeyPath:@"backgroundColor"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
