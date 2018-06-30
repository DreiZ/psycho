//
//  ZHomeTopTitleView.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeTopTitleView.h"
@interface ZHomeTopTitleView ()
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSArray *sTitleColorArr;

@property (nonatomic,strong) NSMutableArray *titleLabelArr;
@property (nonatomic,strong) NSMutableArray *sTitleLabelArr;
@end
@implementation ZHomeTopTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithHexString:@"999999"];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _titleArr = @[@"0.8", @"名称", @"投入", @"结果", @"本筒",@"上筒",@"总账"];
    _subTitleArr = @[@"0", @"#12-1", @"0.3", @"开２", @"＋0.4",@"0",@"+0.3"];
    
    _sTitleColorArr = @[@[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"222222"],[UIColor whiteColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"d00000"],[UIColor whiteColor]]];
    
    _widthArr = @[@(140.0f/1024),
                  @(137.0f/1024),
                  @(145.0f/1024),
                  @(146.0f/1024),
                  @(144.0f/1024),
                  @(145.0f/1024),
                  @(168.0f/1024)];
    

    _titleLabelArr = @[].mutableCopy;
    _sTitleLabelArr = @[].mutableCopy;
    
    UIView *tempView = nil;
    for (int i = 0; i < _titleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:_titleArr[i] titleColor:[UIColor whiteColor] backGroundColor:kBack6Color];
        [_titleLabelArr addObject:tempLabel];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self.mas_centerY);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self);
                make.bottom.equalTo(self.mas_centerY);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = tempLabel;
    }
    
    tempView = nil;
    for (int i = 0; i < _subTitleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:_subTitleArr[i] titleColor:_sTitleColorArr[i][1]  backGroundColor:_sTitleColorArr[i][0]];
        [_sTitleLabelArr addObject:tempLabel];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.top.equalTo(self.mas_centerY).offset(0.5);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.top.equalTo(self.mas_centerY).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = tempLabel;
    }
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (UILabel *)getLabel:(NSString *)title titleColor:(UIColor*)titleColor backGroundColor:(UIColor *)backColor{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = titleColor;
    tempLabel.backgroundColor = backColor;
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:tempLabel];
    return tempLabel;
}
@end