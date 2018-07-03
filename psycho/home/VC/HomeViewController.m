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
#import "ZInningDataManager.h"

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
@property (nonatomic,strong) ZSceneItem *lastSceneItem;

@property (nonatomic,strong) ZInningItem *inningItem;
@property (nonatomic,strong) ZInningItem *lastInningItem;

@property (nonatomic,strong) ZInningItem *historyInngItem;
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
    _sceneItem.multiplying = @"0.7";
    //历史场次
    if (!_historyAllList.allHisoryLists) {
        _sceneItem.sceneSort = @"1";
    }else{
        _sceneItem.sceneSort = [NSString stringWithFormat:@"%ld",_historyAllList.allHisoryLists.count + 1];
    }
    _inningItem = [[ZInningItem alloc] init];
    _inningItem.inningSort = @"1";
    _inningItem.sceneSort = _sceneItem.sceneSort;
    NSMutableArray *tempInnings = [[NSMutableArray alloc] initWithArray:_sceneItem.sceneLists];
    [tempInnings addObject:_inningItem];
    _sceneItem.sceneLists = tempInnings;
    
    _inningModel = [[ZInningModel alloc] init];
    _inningModel.isEnable = YES;
    _inningModel.multiplying = @"0.7";
    _inningModel.multiplyingTure = @"0.07";
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
    [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒",_sceneItem.sceneSort,_inningItem.inningSort]];

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
        NSArray *multiplying = @[@"0.7",@"0.8"];
        NSArray *multiplyingTure = @[@"0.07",@"0.08"];
        _seletedNumView = [[ZSeletedNumView alloc] init];
        _seletedNumView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _seletedNumView.numSeletBlock = ^(NSInteger index) {
            weakSelf.sceneItem.multiplying = multiplying[index];
            weakSelf.inningModel.multiplying = multiplying[index];
            weakSelf.inningModel.multiplyingTure = multiplyingTure[index];
            [weakSelf.leftView refreshHeadData];
        };
    }

    return _seletedNumView;
}

-(ZRightOpenSelectView *)seletedOpenNumView {
    if (!_seletedOpenNumView) {
        __weak typeof(self) weakSelf = self;
        _seletedOpenNumView = [[ZRightOpenSelectView alloc] init];
        _seletedOpenNumView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _seletedOpenNumView.numSeletBlock = ^(NSInteger index) {
            NSArray *titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
            weakSelf.inningItem.winNum = titleArr[index];
            weakSelf.inningModel.winNum = titleArr[index];
            [ZInningDataManager computeWithInningModel:weakSelf.inningModel];
            [weakSelf setLeftTopData];
            [weakSelf.rightView setOpenNum:weakSelf.inningModel.winNum];
            [weakSelf.leftView refreshData];
            [weakSelf.leftView refreshHeadData];
        };
    }
    
    return _seletedOpenNumView;
}

-(ZRightHistorySelectView *)historySelectView {
    if (!_historySelectView) {
        __weak typeof(self)weakSelf = self;
        _historySelectView = [[ZRightHistorySelectView alloc] init];
        _historySelectView.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        _historySelectView.numSeletBlock = ^(ZInningItem *historyItem) {
            [weakSelf handleHistorySelectView:historyItem];
        };
    }
    
    return _historySelectView;
}

- (void)handleHistorySelectView:(ZInningItem *)history {
    _historyInngItem = history;
    if (history) {
        self.leftView.inningModel = history.itemModel;
        self.rightView.inningModel = history.itemModel;
        self.leftView.topSubTitleArr = @[@"",
                                         [NSString stringWithFormat:@"#%@-%@",history.sceneSort,history.inningSort],
                                         history.itemModel.inputAmout,
                                         [NSString stringWithFormat:@"开%@",history.itemModel.winNum],
                                         history.itemModel.amount,
                                         history.itemModel.lastAmount,
                                         history.itemModel.allAmount];
        [self.rightView setTopTitle:@"" value:@""];
        [self.rightView setOpenNum:history.itemModel.winNum];
        
        [self.leftView refreshData];
        if (history.winNum && history.winNum.length > 0 &&![history.winNum isKindOfClass:[NSNull class]]) {
            [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒 开%@",history.sceneSort,history.inningSort,history.winNum]];
        }else{
            [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒",history.sceneSort,history.inningSort]];
        }
        
    }else{
        self.leftView.inningModel = _inningModel;
        self.rightView.inningModel = _inningModel;
        self.leftView.topSubTitleArr = @[@"",
                                         [NSString stringWithFormat:@"#%@-%@",self.sceneItem.sceneSort,self.inningItem.inningSort],
                                         self.inningModel.inputAmout,
                                         [NSString stringWithFormat:@"开%@",self.inningModel.winNum],
                                         self.inningModel.amount,
                                         self.inningModel.lastAmount,
                                         self.inningModel.allAmount];
        [self.rightView setTopTitle:@"" value:@""];
        [self.rightView setOpenNum:@""];
        
        [self.leftView refreshData];
        
        [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒",_sceneItem.sceneSort,_inningItem.inningSort]];
    }
    
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
            [self setLeftTopData];
            [_leftView refreshData];
            [_leftView refreshHeadData];
        }
            break;
        case 101:
            //第几场
        {
            ZHistoryAllList *history = [[ZHistoryAllList alloc] init];
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:self.historyAllList.allHisoryLists];
            [tempArr addObject:_sceneItem];
            history.allHisoryLists = tempArr;
            self.historySelectView.historyAllList = history;
            
            [self.view addSubview:self.historySelectView];
        }
            
            break;
        case 102:
            //查看总账
            [self.view addSubview:self.myAllbillView];
            break;
        case 200:
            //结束本场
            [self endThisSence];
            break;
        case 201:
            //添加新场
            [self addNewSence];
            break;
        case 202:
            //保存本筒
            [self saveThisInning];
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

//保存本筒
- (void)saveThisInning {
    //历史场次
    _lastInningItem = _inningItem;
    _lastInningItem.itemModel.isEnable = NO;
    _lastInningItem.winNum = _inningModel.winNum;
    [self checkNameChange];

    
    NSInteger index = [_inningItem.inningSort integerValue];
    _inningItem = [[ZInningItem alloc] init];
    _inningItem.sceneSort = _sceneItem.sceneSort;
    _inningItem.inningSort = [NSString stringWithFormat:@"%ld",index + 1];
    NSMutableArray *tempInnings = [[NSMutableArray alloc] initWithArray:_sceneItem.sceneLists];
    [tempInnings addObject:_inningItem];
    _sceneItem.sceneLists = tempInnings;
    
    _inningModel = [[ZInningModel alloc] init];
    
    _inningModel.isEnable = YES;
    _inningModel.multiplying = _lastInningItem.itemModel.multiplying;
    _inningModel.multiplyingTure = _lastInningItem.itemModel.multiplyingTure;
    _inningModel.lastAmount = _lastInningItem.itemModel.allAmount;
    _inningModel.allAmount = _lastInningItem.itemModel.allAmount;
    
    _inningItem.itemModel = _inningModel;
    _inningItem.winNum = _inningModel.winNum;
    
    for (int i = 0; i < _lastInningItem.itemModel.inninglist.count; i++) {
        ZInningListModel *lastListModel = _lastInningItem.itemModel.inninglist[i];
        ZInningListModel *listModel = [[ZInningListModel alloc] init];
        listModel.listSort = [NSString stringWithFormat:@"%ld",(long)i+1];
        listModel.listName = lastListModel.listName;
        listModel.listLastResult = lastListModel.listAllResult;
        listModel.listAllResult = lastListModel.listAllResult;
        [_inningModel.inninglist addObject:listModel];
    }
//    for (int i = 0; i < 40; i++) {
//        ZInningListModel *listModel = [[ZInningListModel alloc] init];
//        listModel.listSort = [NSString stringWithFormat:@"%ld",(long)i+1];
//        [_inningModel.inninglist addObject:listModel];
//    }
    self.leftView.inningModel = _inningModel;
    self.rightView.inningModel = _inningModel;
    
    
    [self setLeftTopData];
    [self.leftView refreshData];
    [self setRightData];
    [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒",_sceneItem.sceneSort,_inningItem.inningSort]];
    
}

- (void)checkNameChange {
    for (int i = 0 ; i < _sceneItem.sceneLists.count; i++) {
        ZInningModel *inngModel = _sceneItem.sceneLists[i].itemModel;
        for (int j = 0; j < inngModel.inninglist.count; j++) {
            ZInningListModel *listModel = inngModel.inninglist[j];
            ZInningListModel *nlistModel = _inningModel.inninglist[j];
            listModel.listName = nlistModel.listName;
        }
    }
}

//添加新场
- (void)addNewSence {
    [self endThisSence];
}

//结束本场
- (void)endThisSence {
    [self checkNameChange];
    NSMutableArray *historyArr = [[NSMutableArray alloc] initWithArray:self.historyAllList.allHisoryLists];
    [historyArr addObject:_sceneItem];
    self.historyAllList.allHisoryLists = historyArr;
    
    [self updateHistory];
    
    _lastSceneItem = _sceneItem;
    
    NSInteger index = [_sceneItem.sceneSort integerValue];
    
    _sceneItem = [[ZSceneItem alloc] init];
    _sceneItem.multiplying = @"0.7";
    //历史场次
    _sceneItem.sceneSort = [NSString stringWithFormat:@"%ld",index + 1];
    
    _inningItem = [[ZInningItem alloc] init];
    _inningItem.inningSort = @"1";
    _inningItem.sceneSort = _sceneItem.sceneSort;
    
    NSMutableArray *tempInnings = [[NSMutableArray alloc] initWithArray:_sceneItem.sceneLists];
    [tempInnings addObject:_inningItem];
    _sceneItem.sceneLists = tempInnings;
    
    _inningModel = [[ZInningModel alloc] init];
    _inningModel.isEnable = YES;
    _inningModel.multiplying = @"0.7";
    _inningModel.multiplyingTure = @"0.07";
    _inningItem.itemModel = _inningModel;
    
    for (int i = 0; i < 40; i++) {
        ZInningListModel *listModel = [[ZInningListModel alloc] init];
        listModel.listSort = [NSString stringWithFormat:@"%ld",(long)i+1];
        [_inningModel.inninglist addObject:listModel];
    }
    
    [self.view addSubview:self.seletedNumView];
    self.leftView.inningModel = _inningModel;
    self.rightView.inningModel = _inningModel;
    
    
    [self setLeftTopData];
    [self.leftView refreshData];
    [self setRightData];
    [self.rightView setSortNum:[NSString stringWithFormat:@"第#%@-%@筒",_sceneItem.sceneSort,_inningItem.inningSort]];
}

- (void)setLeftTopData {
    self.leftView.topSubTitleArr = @[@"",
                                         [NSString stringWithFormat:@"#%@-%@",self.sceneItem.sceneSort,self.inningItem.inningSort],
                                         self.inningModel.inputAmout,
                                         [NSString stringWithFormat:@"开%@",self.inningModel.winNum],
                                         self.inningModel.amount,
                                         self.inningModel.lastAmount,
                                         self.inningModel.allAmount];
}

- (void)setRightData {
    [self.rightView setTopTitle:@"" value:@""];
    [self.rightView setOpenNum:@""];
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
