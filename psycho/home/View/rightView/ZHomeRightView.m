//
//  ZHomeRightView.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeRightView.h"
#import "ZRightTopBtnView.h"
#import "ZRightOpenView.h"
#import "ZRightBottomBtnView.h"
#import "ZRightCustomKeyBoardView.h"

@interface ZHomeRightView ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) ZRightTopBtnView *topBtnView;
@property (nonatomic,strong) ZRightOpenView *openView;
@property (nonatomic,strong) ZRightBottomBtnView *bottomBtnView;
@property (nonatomic,strong) ZRightCustomKeyBoardView *keyboardView;
@property (nonatomic,strong) UITextField *textField;
@end

@implementation ZHomeRightView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(5);
        make.height.mas_equalTo(CGFloatIn1536(1368));
    }];
    
    [self.backView addSubview:self.topBtnView];
    [_topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.backView);
        make.height.mas_equalTo(CGFloatIn1536(166));
    }];
    
    [self.backView addSubview:self.openView];
    [_openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.topBtnView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn1536(198));
    }];
    
    [self.backView addSubview:self.bottomBtnView];
    [_bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.height.mas_equalTo(CGFloatIn1536(78));
    }];
    
    [self.backView addSubview:self.keyboardView];
    [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.bottomBtnView.mas_top);
        make.top.equalTo(self.openView.mas_bottom);
    }];
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = kBack6Color.CGColor;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.shadowColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, -3);
    }
    
    return _backView;
}

-(ZRightTopBtnView *)topBtnView {
    if (!_topBtnView) {
        _topBtnView = [[ZRightTopBtnView alloc] init];
    }
    
    return _topBtnView;
}

- (ZRightOpenView *)openView {
    if (!_openView) {
        _openView = [[ZRightOpenView alloc] init];
    }
    
    return _openView;
}

- (ZRightBottomBtnView *)bottomBtnView {
    if (!_bottomBtnView) {
        _bottomBtnView = [[ZRightBottomBtnView alloc] init];
    }
    
    return _bottomBtnView;
}

- (ZRightCustomKeyBoardView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[ZRightCustomKeyBoardView alloc] initWithTextField:self.textField];
    }
    return _keyboardView;
}

@end

