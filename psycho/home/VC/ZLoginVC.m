//
//  ZLoginVC.m
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import "ZLoginVC.h"
#import "ZMainPublicNetworkManager.h"

@interface ZLoginVC ()<UITextFieldDelegate>
//输入类型
@property (assign, nonatomic) HNFormatterType formatterType;
//自定义类型
@property (strong, nonatomic) NSString *inputTypeStr;
//长度限制 默认8
@property (assign, nonatomic) NSInteger max;

@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;

@end

@implementation ZLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    
}

- (void)setupMainView {
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"神算子用户登录";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel setFont:[UIFont systemFontOfSize:30.0f]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(CGFloatIn2048(98));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.view addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).offset(22);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.userNameTF];
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLineView.mas_bottom).offset(64);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(300);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.text = @"账号";
    nameLabel.numberOfLines = 0;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.userNameTF.mas_left).offset(-36);
        make.centerY.equalTo(self.userNameTF.mas_centerY);
    }];
    
    
    
    [self.view addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTF.mas_bottom).offset(28);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(300);
    }];
    
    
    UILabel *passwdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    passwdLabel.textColor = [UIColor blackColor];
    passwdLabel.text = @"密码";
    passwdLabel.numberOfLines = 0;
    passwdLabel.textAlignment = NSTextAlignmentLeft;
    [passwdLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [self.view addSubview:passwdLabel];
    [passwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordTF.mas_left).offset(-36);
        make.centerY.equalTo(self.passwordTF.mas_centerY);
    }];
    
    [self.view addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).offset(28);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
}


- (NSMutableDictionary *)handleUserInfo:(NSDictionary *)info {
    NSMutableDictionary *userinfo = [[NSMutableDictionary alloc] initWithDictionary:info];
    NSArray *keyValue = [userinfo allKeys];
    for (NSString *key in keyValue) {
        if ([userinfo[key] isKindOfClass:[NSNull class]]) {
            [userinfo setObject:@"" forKey:key];
        }
    }
    return userinfo;
}

#pragma mark lazy loading -------
- (UITextField *)userNameTF {
    if (!_userNameTF ) {
        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 101;
        [_userNameTF setFont:[UIFont systemFontOfSize:18]];
        _userNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeySearch];
        [_userNameTF setPlaceholder:@"输入账号"];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypeDefault;
        _userNameTF.layer.masksToBounds = YES;
        _userNameTF.layer.borderWidth = 1;
        _userNameTF.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        _userNameTF.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userNameTF;
}


- (UITextField *)passwordTF {
    if (!_passwordTF ) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.tag = 102;
        [_passwordTF setFont:[UIFont systemFontOfSize:18]];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTF setBorderStyle:UITextBorderStyleNone];
        [_passwordTF setBackgroundColor:[UIColor clearColor]];
        [_passwordTF setReturnKeyType:UIReturnKeySearch];
        [_passwordTF setPlaceholder:@"输入密码"];
        [_passwordTF setSecureTextEntry:YES];
        _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 10)];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.delegate = self;
        _passwordTF.layer.masksToBounds = YES;
        _passwordTF.layer.borderWidth = 1;
        _passwordTF.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
        _passwordTF.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _passwordTF.keyboardType = UIKeyboardTypeDefault;
        [_passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn addTarget:self action:@selector(loginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"009688"];
        [_loginBtn setTitle:@"登入" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _loginBtn;
}

- (void)loginBtnOnClick:(id)sender {
   
    if (_userNameTF.text.length != 11) {
        [self showErrorWithMsg:@"请输入正确的手机号"];
        return;
    }

    if (_passwordTF.text.length == 0) {
        [self showErrorWithMsg:@"请输入密码"];
        return;
    }
    if (_passwordTF.text.length < 6) {
        [self showErrorWithMsg:@"密码长度不能小于6位"];
        return;
    }
    
    NSDictionary *dic = @{@"userPhone":_userNameTF.text,
                          @"userPassword":_passwordTF.text};
    
    __weak typeof(self) weakSelf = self;
    [ZMainPublicNetworkManager userLogin:dic success:^(NSDictionary *info) {
        NSLog(@"zzz userLogin:%@",info);
        [weakSelf handleLoginBlock:info postDict:dic];
    } faile:^(NSError *error) {
        [self showErrorWithMsg:@"登录失败"];
    }];
}

- (void)handleLoginBlock:(NSDictionary*)info postDict:(NSDictionary *)dic {
    if ([info objectForKey:@"result"] && [info[@"result"] intValue] == 200) {
        if ([info objectForKey:@"message"] && [info[@"message"] isKindOfClass:[NSString class]]) {
            [self showErrorWithMsg:info[@"message"]];
        }else{
            [self showSuccessWithMsg:@"登录成功"];
        }
//         [[AppDelegate App] changeRootViewController];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        [[AppDelegate App] changeRootViewController];
    }else{
        if ([info objectForKey:@"message"] && [info[@"message"] isKindOfClass:[NSString class]]) {
            [self showErrorWithMsg:info[@"message"]];
        }else{
            [self showErrorWithMsg:@"登录失败"];
        }
    }
}


-(void)loginSuccess {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self showErrorWithMsg:@"登录成功"];
    [self dismissViewControllerAnimated:YES completion:^{
        [self pushRefreshdNotifi];
        
    }];
}

-(void)pushRefreshdNotifi {
    NSNotification *notification =[NSNotification notificationWithName:kRefreshMainRegion object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //    NSNotification *notificatioLogin =[NSNotification notificationWithName:kRefreshLoginRegion object:nil userInfo:nil];
    //    //通过通知中心发送通知
    //    [[NSNotificationCenter defaultCenter] postNotification:notificatioLogin];
}

#pragma mark textField delegate ---------
- (void)textFieldDidChange:(UITextField*)textField {
    if (_formatterType == HNFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, _max) - 0.01  > 0.000001) {
            [self showErrorWithMsg:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
        
//        if (_valueChange) {
//            _valueChange(textField.text);
//        }
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
    
//    if (_valueChange) {
//        _valueChange(textField.text);
//    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 101) {
        _formatterType = HNFormatterTypePhoneNumber;
        _max = 11;
    }else if (textField.tag == 102) {
        _formatterType = HNFormatterTypeAny;
        _max = 12;
    }
    
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

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
