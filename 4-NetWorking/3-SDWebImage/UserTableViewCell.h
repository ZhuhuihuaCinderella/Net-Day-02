//
//  UserTableViewCell.h
//  3-SDWebImage
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface UserTableViewCell : UITableViewCell
- (void)configData:(UserModel *)user;
@end
