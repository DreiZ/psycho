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
    
    CGFloat maxScreenWidth = screenWidth < screenHeight ?  screenWidth:screenHeight;
    _inputTextField = [UITextField new];
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(5);
        make.height.mas_equalTo(1368.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.topBtnView];
    [_topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.backView);
        make.height.mas_equalTo(166.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.openView];
    [_openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.topBtnView.mas_bottom);
        make.height.mas_equalTo(198.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.bottomBtnView];
    [_bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.height.mas_equalTo(78.0f/1536 * maxScreenWidth);
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
        __weak typeof(self)weakSelf = self;
        _topBtnView = [[ZRightTopBtnView alloc] init];
        _topBtnView.topBlock = ^(NSInteger index) {
            if (weakSelf.topBlock) {
                weakSelf.topBlock(index);
            }
        };
    }
    
    return _topBtnView;
}

- (ZRightOpenView *)openView {
    if (!_openView) {
        __weak typeof(self)weakSelf = self;
        _openView = [[ZRightOpenView alloc] init];
        _openView.openBlock = ^{
            if (weakSelf.openBlock) {
                weakSelf.openBlock();
            }
        };
    }
    
    return _openView;
}

- (ZRightBottomBtnView *)bottomBtnView {
    if (!_bottomBtnView) {
        __weak typeof(self)weakSelf = self;
        _bottomBtnView = [[ZRightBottomBtnView alloc] init];
        _bottomBtnView.bottomBlock = ^(NSInteger index) {
            if (weakSelf.bottomBlock) {
                weakSelf.bottomBlock(index);
            }
        };
    }
    
    return _bottomBtnView;
}

- (ZRightCustomKeyBoardView *)keyboardView {
    if (!_keyboardView) {
        __weak typeof(self) weakSelf = self;
        _keyboardView = [[ZRightCustomKeyBoardView alloc] initWithTextField:self.inputTextField];
        _keyboardView.addBlock = ^{
            if (weakSelf.inningListModel) {
                [weakSelf.inningListModel.listInput addObject:@""];
                [weakSelf.inningListModel.listInputResult addObject:@""];
            }
            if (weakSelf.addBlock) {
                weakSelf.addBlock();
            }
        };
        
        _keyboardView.changeBlock = ^{
            if (weakSelf.inningListModel && weakSelf.inputTextField) {
                [weakSelf.keyboardView setTopTitle:weakSelf.inningListModel.listName value:weakSelf.inputTextField.text];
            }
            
        };
    }
    return _keyboardView;
}


- (void)setInputTextField:(UITextField *)inputTextField {
    _inputTextField = inputTextField;
    _keyboardView.textField = inputTextField;
}

- (void)setTopTitle:(NSString *)title value:(NSString *)value {
    [_keyboardView setTopTitle:title value:value];
}

- (void)setOpenNum:(NSString *)num {
    [_openView setOpenNum:num];
}

- (void)setSortNum:(NSString *)num {
    [_topBtnView setSenceAndInning:num];
}
@end

