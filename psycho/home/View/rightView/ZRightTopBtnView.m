//
//  ZRightTopBtnView.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightTopBtnView.h"

@interface ZRightTopBtnView ()
@property (nonatomic,strong) NSMutableArray *topBtnArr;
@property (nonatomic,strong) NSMutableArray *bottomBtnArr;
@end

@implementation ZRightTopBtnView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = kBack6Color;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _topBtnArr = @[].mutableCopy;
    _bottomBtnArr = @[].mutableCopy;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.backgroundColor = kBack6Color;
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(CGFloatIn1536(80));
    }];
    
    NSArray *topTitleArr = @[@"清空所有",@"第＃124-100筒 开２",@"查看总账"];
    
    for (int i = 0; i < topTitleArr.count; i++) {
        UIButton *btn = [self getBtn:i+100 title:topTitleArr[i] type:YES];
        [topView addSubview:btn];
        [_topBtnArr addObject:btn];
        if (i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.equalTo(topView);
                make.width.equalTo(topView).multipliedBy(2/7.0f);
            }];
        }else if (i == 1){
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(topView);
                make.centerX.equalTo(topView.mas_centerX);
                make.width.equalTo(topView).multipliedBy(3/7.0f).offset(-1);
            }];
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.bottom.equalTo(topView);
                make.width.equalTo(topView).multipliedBy(2/7.0f);
            }];
        }
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(topView.mas_bottom).offset(0.5);
    }];
    
    NSArray *bottomTitleArr = @[@"结束本场",@"添加新场",@"保存本筒",@"截图"];
    for (int i = 0; i < bottomTitleArr.count; i++) {
        UIButton *btn = [self getBtn:i+200 title:bottomTitleArr[i] type:NO];
        [bottomView addSubview:btn];
        [_bottomBtnArr addObject:btn];
    }

    [_bottomBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:4 leadSpacing:0 tailSpacing:0];

    [_bottomBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [_bottomBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGFloatIn1536(62));
    }];
}

- (UIButton *)getBtn:(NSInteger)index title:(NSString *)title type:(BOOL)isTop{
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = index;
    [tempBtn setTitle:title forState:UIControlStateNormal];
    if (isTop) {
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tempBtn.backgroundColor = [UIColor whiteColor];
    }else{
        [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [tempBtn setTitleColor:[UIColor colorWithHexString:@"0077df"] forState:UIControlStateNormal];
        tempBtn.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        tempBtn.layer.masksToBounds = YES;
        tempBtn.layer.cornerRadius = 13;
        tempBtn.layer.borderWidth = 1;
        tempBtn.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    }
    return tempBtn;
}

- (void)tempBtnClick:(UIButton *)sender {
    if (_topBlock) {
        _topBlock(sender.tag);
    }
}
@end