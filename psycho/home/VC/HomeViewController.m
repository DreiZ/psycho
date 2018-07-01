//
//  HomeViewController.m
//  psycho
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

#import "ZHomeTitleCell.h"
#import "ZHomeRightView.h"
#import "ZHomeLeftView.h"
#import "ZSeletedNumView.h"
#import "ZMyAllBillView.h"

#import "ZInningModel.h"

@interface HomeViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZInningModel *inningModel;

@property (nonatomic,strong) ZHomeRightView *rightView;
@property (nonatomic,strong) ZHomeLeftView *leftView;

@property (nonatomic,strong) ZSeletedNumView *seletedNumView;
@property (nonatomic,strong) ZMyAllBillView *myAllbillView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setMainData];
    [self setupMainView];
}

- (void)setMainData {
    _inningModel = [[ZInningModel alloc] init];
    for (int i = 0; i < 40; i++) {
        ZInningListModel *listModel = [[ZInningListModel alloc] init];
        listModel.listSort = [NSString stringWithFormat:@"%ld",(long)i];
        [_inningModel.inninglist addObject:listModel];
    }
}

- (void)setupMainView {
    
    UIButton *lognBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [lognBtn addTarget:self action:@selector(lognBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    lognBtn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:lognBtn];
    [lognBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_bottom).offset(-220);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(290);
    }];
    
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectZero];
    statusBar.backgroundColor = kBack6Color;
    [self.view addSubview:statusBar];
    [statusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(SafeAreaTopHeight);
    }];
    
    [self.view addSubview:self.rightView];
    if (self.isHorizontal) {
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.view);
            make.width.mas_equalTo(CGFloatIn2048(636));
        }];
    }else{
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.view);
            make.width.mas_equalTo(0.1f);
        }];
    }
    
    [self.view addSubview:self.leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.rightView.mas_left);
        make.top.equalTo(statusBar.mas_bottom);
    }];
    
    self.leftView.inningModel = _inningModel;
    self.rightView.inningModel = _inningModel;
}

#pragma mark lazy loading...
-(ZHomeRightView *)rightView {
    if (!_rightView) {
        __weak typeof(self) weakSelf = self;
        _rightView = [[ZHomeRightView alloc] init];
        _rightView.topBlock = ^(NSInteger index) {
            [weakSelf handleTopBlock:index];
        };
    }
    
    return _rightView;
}

-(ZHomeLeftView *)leftView {
    if (!_leftView) {
        _leftView = [[ZHomeLeftView alloc] init];
 
        __weak typeof(self) weakSelf = self;
        _leftView.nameValueChange = ^(NSString *value, ZInningListModel *listModel) {
            
        };
        
        _leftView.valueChange = ^(NSString *value, ZInningListModel *listModel) {
            
        };
        
        _leftView.beginChange = ^(UITextField *textField, ZInningListModel *listModel) {
           weakSelf.rightView.inputTextField = textField;
            [weakSelf.rightView setTopTitle:listModel.listName value:textField.text];
        };
        
        _leftView.endChange = ^(UITextField *textField, ZInningListModel *listModel) {
            weakSelf.rightView.inputTextField = nil;
            [weakSelf.rightView setTopTitle:@"" value:@""];
        };
    }
    
    return _leftView;
}

-(ZSeletedNumView *)seletedNumView {
    if (!_seletedNumView) {
        _seletedNumView = [[ZSeletedNumView alloc] init];
        _seletedNumView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }

    return _seletedNumView;
}

-(ZMyAllBillView *)myAllbillView {
    if (!_myAllbillView) {
        _myAllbillView = [[ZMyAllBillView alloc] init];
        _myAllbillView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }
    
    return _myAllbillView;
}
#pragma mark 退出
- (void)lognBtnOnclick:(id)sender {
    [[AppDelegate App] pushLogingVC];
}

#pragma mark 键盘上角按钮处理
- (void)handleTopBlock:(NSInteger)index {
    switch (index) {
        case 100:
            
            break;
        case 101:
            [self.view addSubview:self.seletedNumView];
            break;
        case 102:
            [self.view addSubview:self.myAllbillView];
            break;
        case 200:
            
            break;
        case 201:
            
            break;
        case 202:
            
            break;
            
        default:
            break;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 此处编写弹出日期选择器的代码。
    NSLog(@"asdfa");
    return NO;
}

//获取设备方向 更新 UI
-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    NSLog(@"sddfs");
    if (isHorizontal) {
        [_rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.view);
            make.width.mas_equalTo(CGFloatIn2048(636));
        }];
    }else{
        [_rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(self.view);
            make.width.mas_equalTo(0.1f);
        }];
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
