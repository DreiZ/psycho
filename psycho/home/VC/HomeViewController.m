//
//  HomeViewController.m
//  psycho
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "HomeViewController.h"
#import "DataWorkManager.h"
#import "AppDelegate.h"

#import "ZHomeTitleCell.h"
#import "ZHomeRightView.h"
#import "ZHomeLeftView.h"
#import "ZSeletedNumView.h"
#import "ZRightOpenSelectView.h"
#import "ZMyAllBillView.h"
#import "ZRightHistorySelectView.h"

#import "ZInningModel.h"

@interface HomeViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) ZInningModel *inningModel;

@property (nonatomic,strong) ZHomeRightView *rightView;
@property (nonatomic,strong) ZHomeLeftView *leftView;

@property (nonatomic,strong) ZSeletedNumView *seletedNumView;
@property (nonatomic,strong) ZMyAllBillView *myAllbillView;
@property (nonatomic,strong) ZRightOpenSelectView *seletedOpenNumView;
@property (nonatomic,strong) ZRightHistorySelectView *historySelectView;


@property (nonatomic,strong) ZInningListModel *seletListModel;

@property (nonatomic,strong) ZHistoryAllList *historyAllList;
@property (nonatomic,strong) ZSceneItem *sceneItem;
@property (nonatomic,strong) ZInningItem *inningItem;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setMainData];
    [self setupMainView];
    [self initInningData];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark 数据初始化
- (void)setMainData {
    [self getHistory];
    _sceneItem = [[ZSceneItem alloc] init];
    //历史场次
    if (!_historyAllList.allHisoryLists) {
        _sceneItem.sceneSort = @"1";
    }else{
        _sceneItem.sceneSort = [NSString stringWithFormat:@"%ld",_historyAllList.allHisoryLists.count + 1];
    }
    _inningItem = [[ZInningItem alloc] init];
    _inningItem.inningSort = @"1";
    _inningModel.isEnable = YES;
    _inningModel = [[ZInningModel alloc] init];
    _inningItem.itemModel = _inningModel;
    
    for (int i = 0; i < 40; i++) {
        ZInningListModel *listModel = [[ZInningListModel alloc] init];
        listModel.listSort = [NSString stringWithFormat:@"%ld",(long)i+1];
        [_inningModel.inninglist addObject:listModel];
    }
}

- (void)getHistory {
    self.historyAllList = [[DataWorkManager shareInstance] getDBModelData:[ZHistoryAllList class]];
    if (!self.historyAllList) {
        self.historyAllList = [ZHistoryAllList new];
    }
}

- (void)updateHistory {
    [[DataWorkManager shareInstance] addOrUpdateModel:self.historyAllList];
}


- (void)initInningData {
    self.leftView.topSubTitleArr = @[@"",
                                     [NSString stringWithFormat:@"#%@-%@",_sceneItem.sceneSort,_inningItem.inningSort],
                                     @"",
                                     @"开",
                                     @"0.00",
                                     @"0.00",
                                     @"0.00"];
    
    [self.view addSubview:self.seletedNumView];
    [self.rightView setSenceAndInning:[NSString stringWithFormat:@"#%@-%@",_sceneItem.sceneSort,_inningItem.inningSort]];
}

#pragma mark 初始化 view
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

#pragma mark  懒加载
-(ZHomeRightView *)rightView {
    if (!_rightView) {
        __weak typeof(self) weakSelf = self;
        _rightView = [[ZHomeRightView alloc] init];
        _rightView.topBlock = ^(NSInteger index) {
            [weakSelf handleTopBlock:index];
        };
        
        _rightView.addBlock = ^{
            [AppDelegate App].isAddRefresh = YES;
            [weakSelf.leftView refreshData];
        };
        _rightView.openBlock = ^{
            [weakSelf.view addSubview:weakSelf.seletedOpenNumView];
        };
        
        _rightView.bottomBlock = ^(NSInteger index) {
            [weakSelf handleBottomBlock:index];
        };
    }
    
    return _rightView;
}

-(ZHomeLeftView *)leftView {
    if (!_leftView) {
        _leftView = [[ZHomeLeftView alloc] init];
 
        __weak typeof(self) weakSelf = self;
        _leftView.nameValueChange = ^(NSString *value, ZInningListModel *listModel) {
            weakSelf.seletListModel = listModel;
            weakSelf.rightView.inningListModel = listModel;
            [weakSelf.rightView setTopTitle:listModel.listName value:listModel.listInput[0]];
        };
        
        _leftView.nameBeginChange = ^(NSString *value, ZInningListModel *listModel) {
            weakSelf.seletListModel = listModel;
            weakSelf.rightView.inningListModel = listModel;
            [weakSelf.rightView setTopTitle:listModel.listName value:listModel.listInput[0]];
        };
        
        _leftView.valueChange = ^(NSString *value, ZInningListModel *listModel) {
            weakSelf.seletListModel = listModel;
            weakSelf.rightView.inningListModel = listModel;
            [weakSelf.rightView setTopTitle:listModel.listName value:value];
        };
        
        _leftView.beginChange = ^(UITextField *textField, ZInningListModel *listModel) {
            weakSelf.rightView.inputTextField = textField;
            weakSelf.seletListModel = listModel;
            weakSelf.rightView.inningListModel = listModel;
            [weakSelf.rightView setTopTitle:listModel.listName value:textField.text];
        };
        
        _leftView.endChange = ^(UITextField *textField, ZInningListModel *listModel) {
            weakSelf.rightView.inputTextField = nil;
            weakSelf.seletListModel = nil;
            weakSelf.rightView.inningListModel = nil;
            [weakSelf.rightView setTopTitle:@"" value:@""];
        };
    }
    
    return _leftView;
}

-(ZSeletedNumView *)seletedNumView {
    if (!_seletedNumView) {
        __weak typeof(self) weakSelf = self;
        NSArray *openNum = @[@"0.7",@"0.8"];
        _seletedNumView = [[ZSeletedNumView alloc] init];
        _seletedNumView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _seletedNumView.numSeletBlock = ^(NSInteger index) {
            weakSelf.sceneItem.openNum = openNum[index];
            weakSelf.inningModel.openNum = openNum[index];
            [weakSelf.leftView refreshHeadData];
        };
    }

    return _seletedNumView;
}

-(ZRightOpenSelectView *)seletedOpenNumView {
    if (!_seletedOpenNumView) {
        _seletedOpenNumView = [[ZRightOpenSelectView alloc] init];
        _seletedOpenNumView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _seletedOpenNumView.numSeletBlock = ^(NSInteger index) {
            
        };
    }
    
    return _seletedOpenNumView;
}

-(ZRightHistorySelectView *)historySelectView {
    if (!_historySelectView) {
        _historySelectView = [[ZRightHistorySelectView alloc] init];
        _historySelectView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _historySelectView.numSeletBlock = ^(NSInteger index) {
            
        };
    }
    
    return _historySelectView;
}

-(ZMyAllBillView *)myAllbillView {
    if (!_myAllbillView) {
        _myAllbillView = [[ZMyAllBillView alloc] init];
        _myAllbillView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    }
    
    return _myAllbillView;
}

#pragma mark 键盘头部上按钮处理
- (void)handleTopBlock:(NSInteger)index {
    switch (index) {
        case 100:
            //清空所有
        {
            [_inningModel clearAll];
            [_leftView refreshData];
            [_leftView refreshHeadData];
        }
            break;
        case 101:
            //第几场
           
            [self.view addSubview:self.historySelectView];
            break;
        case 102:
            //查看总账
            [self.view addSubview:self.myAllbillView];
            break;
        case 200:
            //结束本场
            break;
        case 201:
            //添加新场
            
            break;
        case 202:
            //保存本筒
            
            break;
        case 203:
            //截屏
            [self cutPicture];
            break;
            
        default:
            break;
    }
}

- (void)handleBottomBlock:(NSInteger)index {
    switch (index) {
        case 0:
            //上移一行
        {
            if ([AppDelegate App].listIndex > 1) {
                [AppDelegate App].isAddRefresh = YES;
                [AppDelegate App].listIndex -= 1;
                [AppDelegate App].firstIndex = 0;
                [_leftView refreshData];
            }
            
        }
            break;
        case 1:
            //修改本筒
        {
            [self.view addSubview:self.seletedOpenNumView];
        }
            break;
        case 2:
            //下一行
            {
                if ([AppDelegate App].listIndex < _inningModel.inninglist.count) {
                    [AppDelegate App].isAddRefresh = YES;
                    [AppDelegate App].listIndex += 1;
                    [AppDelegate App].firstIndex = 0;
                    [_leftView refreshData];
                }else{
                    ZInningListModel *listModel = [[ZInningListModel alloc] init];
                    listModel.listSort = [NSString stringWithFormat:@"%ld",(long)_inningModel.inninglist.count+1];
                    [_inningModel.inninglist addObject:listModel];
                    [AppDelegate App].isAddRefresh = YES;
                    [AppDelegate App].listIndex += 1;
                    [AppDelegate App].firstIndex = 0;
                    [_leftView refreshData];
                }
            }
            break;
        
        default:
            break;
    }
}

#pragma mark 截图处理
- (void)cutPicture {
    UIImage * img = [self cut];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        [self showSuccessWithMsg:@"截图已保存到系统相册"];
    } else {
        [self showSuccessWithMsg:@"截图失败"];
    }
}

- (UIImage *)cut {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark 屏幕旋转处理
//获取设备方向 更新 UI
-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
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

//#pragma mark 退出
//- (void)lognBtnOnclick:(id)sender {
//    [[AppDelegate App] pushLogingVC];
//}

@end
