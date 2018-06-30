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

@interface HomeViewController ()<UITextFieldDelegate>


@property (nonatomic,strong) UITextField *testTF;
@property (nonatomic,assign) HNFormatterType formatterType;
//自定义类型
@property (strong, nonatomic) NSString *inputTypeStr;
//长度限制 默认8
@property (assign, nonatomic) NSInteger max;


@property (nonatomic,strong) ZHomeRightView *rightView;
@property (nonatomic,strong) ZHomeLeftView *leftView;

@property (nonatomic,strong) ZSeletedNumView *seletedNumView;
@property (nonatomic,strong) ZMyAllBillView *myAllbillView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _max = 100;
   
    [self.view addSubview:self.testTF];
    [_testTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(290);
    }];
    
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

- (UITextField *)testTF {
    if (!_testTF ) {
        _testTF  = [[UITextField alloc] init];
        [_testTF  setFont:[UIFont systemFontOfSize:24]];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        leftView.backgroundColor = [UIColor grayColor];
        _testTF.leftView = leftView;
        _testTF.leftViewMode = UITextFieldViewModeAlways;
        [_testTF  setBorderStyle:UITextBorderStyleNone];
        [_testTF  setBackgroundColor:[UIColor grayColor]];
        [_testTF  setReturnKeyType:UIReturnKeySearch];
        [_testTF  setPlaceholder:@"cesi"];
        _testTF .delegate = self;
        [_testTF  addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _testTF;
}


- (void)textFieldDidChange:(UITextField*)textField {
    if (_formatterType == HNFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, _max) - 0.01  > 0.000001) {
            [self showErrorWithMsg:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
        
        return;
        
    }
    if (textField.text.length > _max) {
        [self showErrorWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = _max;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *regexString;
    switch (_formatterType) {
        case HNFormatterTypeAny:
        {
            return YES;
        }
        case HNFormatterTypePhoneNumber:
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case HNFormatterTypeNumber:
        {
            regexString = @"^\\d*$";
            break;
        }
        case HNFormatterTypeDecimal:
        {
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (unsigned long)2];
            break;
        }
        case HNFormatterTypeAlphabet:
        {
            regexString = @"^[a-zA-Z]*$";
            break;
        }
        case HNFormatterTypeNumberAndAlphabet:
        {
            regexString = @"^[a-zA-Z0-9]*$";
            break;
        }
        case HNFormatterTypeIDCard:
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case HNFormatterTypeCustom:
        {
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", _inputTypeStr, (long)_max];
            break;
        }
        default:
            break;
    }
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
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
