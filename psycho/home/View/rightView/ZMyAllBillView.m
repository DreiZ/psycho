//
//  ZMyAllBillView.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMyAllBillView.h"
#import "ZMyAlllBillFootView.h"
#import "ZMyAllBillListCell.h"

@interface ZMyAllBillView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) ZMyAlllBillFootView *billFootView;
@property (nonatomic,strong) ZMyAllBillListCell *leftAmountView;
@property (nonatomic,strong) ZMyAllBillListCell *rightAmountView;
@end

@implementation ZMyAllBillView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    
    
    [self addSubview:self.contView];
    [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.width.mas_equalTo(CGFloatIn2048(1200));
        make.height.mas_equalTo(CGFloatIn1536(1000));
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.text = @"查看总账";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [_contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(50 );
        make.left.right.equalTo(self.contView);
        make.height.mas_equalTo(50);
    }];
    
    UIView *hintLabelLineView = [[UIView alloc] initWithFrame:CGRectZero];
    hintLabelLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [hintLabel addSubview:hintLabelLineView];
    [hintLabelLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(hintLabel);
        make.height.mas_equalTo(0.5);
    }];
    
    self.leftTableView = [self iTableView];
    [self.contView addSubview:self.leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabelLineView.mas_bottom);
        make.right.equalTo(self.contView.mas_centerX).offset(-50);
        make.left.equalTo(self.contView.mas_left);
        make.height.mas_equalTo(245);
    }];
    
    [self.contView addSubview:self.leftAmountView];
    [self.leftAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTableView.mas_bottom);
        make.left.equalTo(self.leftTableView.mas_left);
        make.right.equalTo(self.leftTableView.mas_right);
        make.height.mas_equalTo([ZMyAllBillListCell getCellHeight:nil]);
    }];
    
    self.rightTableView = [self iTableView];
    [self.contView addSubview:self.rightTableView];
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabelLineView.mas_bottom);
        make.left.equalTo(self.contView.mas_centerX).offset(50);
        make.right.equalTo(self.contView.mas_right);
        make.height.mas_equalTo(245);
    }];
    
    [self.contView addSubview:self.rightAmountView];
    [self.rightAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightTableView.mas_bottom);
        make.left.equalTo(self.rightTableView.mas_left);
        make.right.equalTo(self.rightTableView.mas_right);
        make.height.mas_equalTo([ZMyAllBillListCell getCellHeight:nil]);
    }];
 
    [self.contView addSubview:self.billFootView];
    [_billFootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightAmountView.mas_bottom);
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.contView.mas_right);
        make.height.mas_equalTo(50);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = [UIColor whiteColor];
        
        UIView *topTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        topTitleView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [_contView addSubview:topTitleView];
        [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(topTitleView.superview);
            make.height.mas_equalTo(50);
        }];
        
        
        UILabel *topTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        topTitleLabel.textColor = [UIColor blackColor];
        topTitleLabel.text = @"总账单";
        topTitleLabel.textAlignment = NSTextAlignmentCenter;
        [topTitleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [topTitleView addSubview:topTitleLabel];
        [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(topTitleView);
        }];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [topTitleView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(topTitleView);
            make.width.mas_equalTo(50);
        }];
        
    }
    return _contView;
}

#pragma mark lazy loading...
-(ZMyAlllBillFootView *)billFootView {
    if (!_billFootView) {
        _billFootView = [[ZMyAlllBillFootView alloc] init];
        [_billFootView setAdd:@"2" sub:@"0.4" amount:@"1.6"];
    }
    return _billFootView;
}


- (void)backBtnOnclick:(id)sender {
    [self removeFromSuperview];
}

-(ZMyAllBillListCell *)leftAmountView {
    if (!_leftAmountView) {
        _leftAmountView = [ZMyAllBillListCell cellWithTableView:self.leftTableView];
        _leftAmountView.style = 1;
        [_leftAmountView setLeftTitle:@"赢总额" rightTitle:@"０.9"];
    }
    return _leftAmountView;
}

-(ZMyAllBillListCell *)rightAmountView {
    if (!_rightAmountView) {
        _rightAmountView = [ZMyAllBillListCell cellWithTableView:self.rightTableView];
        _rightAmountView.style = 3;
        [_rightAmountView setLeftTitle:@"输总额" rightTitle:@"０.３"];
    }
    return _rightAmountView;
}

-(UITableView *)iTableView {
    UITableView *iTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if ([iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
        iTableView.estimatedRowHeight = 0;
        iTableView.estimatedSectionHeaderHeight = 0;
        iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    } else {
       
    }
    iTableView.delegate = self;
    iTableView.dataSource = self;
    return iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMyAllBillListCell *cell = [ZMyAllBillListCell cellWithTableView:tableView];
    if (tableView == _leftTableView) {
//        if (indexPath.row == 4) {
//            cell.style = 1;
//            [cell setLeftTitle:@"赢总额" rightTitle:@"０.9"];
//        }else{
            cell.style = 0;
            [cell setLeftTitle:@"张三" rightTitle:@"０.3"];
//        }
    }else{
//        if (indexPath.row == 4) {
//            cell.style = 3;
//            [cell setLeftTitle:@"输总额" rightTitle:@"０.9"];
//        }else{
            cell.style = 2;
            [cell setLeftTitle:@"张三" rightTitle:@"０.3"];
//        }
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMyAllBillListCell getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end

