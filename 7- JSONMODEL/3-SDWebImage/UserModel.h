//
//  UserModel.h
//  3-SDWebImage
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface UserModel : JSONModel
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *headimage;
//@property (nonatomic, copy)NSString *headimage2;//headimage02(服务器返回的),我们需要01 这个值给对应我们的 1 上
@end
