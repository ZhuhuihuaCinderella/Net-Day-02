//
//  UserTableViewCell.m
//  3-SDWebImage
//
//  Created by Qianfeng on 16/1/19.
//  Copyright © 2016年 王鹏宇. All rights reserved.
//

#import "UserTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface UserTableViewCell ()
@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UserModel * model;
@end
@implementation UserTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}
//创建UI
- (void)initUI {
    _headImageView = [[UIImageView alloc] init];
    _userNameLabel = [[UILabel alloc] init];
    //行数为0的时候不限制行数
    _userNameLabel.numberOfLines = 0;
    _userNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_userNameLabel];
    [self.contentView addSubview:_headImageView];
}
//设置frame 重写一个方法 布局子视图
//不能手动调用 要想调用此方法 [self layoutIfNeeded]要先调用该方法
- (void)layoutSubviews {
    [super layoutSubviews];
    _headImageView.frame = CGRectMake(20, 20, 60, 60);
    _userNameLabel.frame = CGRectMake(90, 20, 200, 60);
    
    CGFloat textH = [UserTableViewCell heightWithText:self.model.username];
    _userNameLabel.frame = CGRectMake(90, 20, 200, textH);
    
}
// 计算文本高度
+ (CGFloat)heightWithText:(NSString *)text {
    //怎么算高度
    //1 字体大小 2 需要知道文本宽度
   CGSize size =  [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200, MAXFLOAT)];
    NSLog(@"%f",size.height);
    return size.height;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)configData:(UserModel *)user {
    self.model = user;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.0.8.8/sns%@",user.headimage]];
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    
    [self.headImageView sd_setImageWithURL:url placeholderImage:image];
    self.userNameLabel.text = user.username;
    NSLog(@"%@",user.username);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
