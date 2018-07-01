//
//  ZHomeRightView.h
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZHomeRightView : UIView
@property (nonatomic,strong) ZInningModel *inningModel;
@property (nonatomic,strong) UITextField *inputTextField;

@property (nonatomic,strong) void (^topBlock)(NSInteger);

- (void)setTopTitle:(NSString *)title value:(NSString *)value;
@end
