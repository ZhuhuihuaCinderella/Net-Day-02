//
//  ViewController.m
//  KVC
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //访问对象的一个方法 kvc 键值编码
    Person *xiaoming = [[Person alloc] init];
    xiaoming.name = @"小明";
    NSLog(@"%@",xiaoming.name);
    NSLog(@"%@",[xiaoming valueForKey:@"name"]);
    
    //kvc 来赋值
    [xiaoming setValue:@"大明" forKey:@"name"];
    NSLog(@"%@",xiaoming.name);
    
    //kvc 赋值方式 第二种
    [xiaoming setValue:@"老明" forKeyPath:@"name"];
    NSLog(@"%@",xiaoming.name);
    
    //字典转模型
    NSDictionary *dict = @{@"name":@"明明",@"age":@"158"};
    
    [xiaoming setValuesForKeysWithDictionary:dict];
    NSLog(@"%@ ,%@",xiaoming.name,xiaoming.age);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
