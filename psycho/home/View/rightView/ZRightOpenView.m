//
//  ZRightOpenView.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightOpenView.h"

@interface ZRightOpenView ()
@property (nonatomic,strong) UIButton *openBtn;
@property (nonatomic,strong) YYLabel *openLabel;

@end

@implementation ZRightOpenView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.openLabel];
    [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.openBtn];
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (YYLabel *)openLabel {
    if (!_openLabel) {
        _openLabel = [[YYLabel alloc] init];
        _openLabel.numberOfLines = 1;
        NSString *openStr =  @"开筒";
        NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:openStr];
        introText.font = [UIFont systemFontOfSize:24];
        introText.color = [UIColor blackColor];
        
        _openLabel.attributedText = introText;
        _openLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _openLabel;
}


- (UIButton *)openBtn {
    if (!_openBtn) {
        _openBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openBtn addTarget:self action:@selector(openOnclick:) forControlEvents:UIControlEventTouchUpInside];
        _openBtn.layer.masksToBounds = YES;
    }
    return _openBtn;
}

- (void)openOnclick:(id)sender {
    if (_openBlock) {
        _openBlock();
    }
    NSString *result =  @"本筒开３";
    NSString *title =  @"３";
    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:result];
    introText.font = [UIFont systemFontOfSize:24];
    
    NSRange range1 = NSMakeRange(result.length-title.length, title.length);
    //文字颜色
    [introText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"d00000"] range:range1];
    _openLabel.attributedText = introText;
    _openLabel.textAlignment = NSTextAlignmentCenter;
}


@end

