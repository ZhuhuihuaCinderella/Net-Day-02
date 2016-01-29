//
//  Person.m
//  KVC
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "Person.h"

@implementation Person
//为了防止 用kvc给没有定义的属性赋值而导致的崩溃
//- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
//    NSLog(@"给没有赋值");
//    if]) {
//        <#statements#>
//    }
//}
- (id)valueForKey:(NSString *)key {
    //用kvc 去定义没有定义的属性值的时候防止崩溃，需要重写这个方法
    if ([key isEqualToString:@"id"]) {
        return [self valueForKey:@"name"];
    }
    return nil;
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@",_name];
}
@end
