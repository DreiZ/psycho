//
//  ZHomeListAddTFView.h
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHomeListAddTFView : UIView
@property (nonatomic,strong) NSMutableArray *inputList;

@property (assign, nonatomic) BOOL isCustomKeyboard;
@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField);
@property (strong, nonatomic) void (^endChange)(UITextField *textField);
@end
