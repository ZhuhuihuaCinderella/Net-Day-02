//
//  UserModel.m
//  3-SDWebImage
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
//如果 服务器返回的名字 跟 我们定义的属性不一样，我们要转化属性， 类似于kvc  forUndefinedKey
// 需要重写一个方法
+ (JSONKeyMapper *)keyMapper {
    NSDictionary *dict = @{@"headimage":@"headimage1"};
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"给没有定义的成员变量赋值");
}
@end
