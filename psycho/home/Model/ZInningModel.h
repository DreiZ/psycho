//
//  ZInningModel.h
//  psycho
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"

@interface ZInningListModel : ZBaseModel
@property (nonatomic,strong) NSString *listSort;
@property (nonatomic,strong) NSString *listName;
@property (nonatomic,strong) NSMutableArray <NSString *>*listInput;
@property (nonatomic,strong) NSString *listOpenResult;
@property (nonatomic,strong) NSString *listThisResult;
@property (nonatomic,strong) NSString *listLastResult;
@property (nonatomic,strong) NSString *listAllResult;
@end

@interface ZInningModel : ZBaseModel
//是否为b
@property (nonatomic, assign) BOOL isEnable;
//序列
@property (nonatomic, strong) NSString *sort;
//初始倍率
@property (nonatomic, strong) NSString *openNum;
//开通数字
@property (nonatomic, strong) NSString *winNum;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *addAmount;
@property (nonatomic, strong) NSString *subAmount;

@property (nonatomic,strong) NSMutableArray <ZInningListModel *> *inninglist;
//清空所有
- (void)clearAll;
@end


@interface ZInningItem : ZBaseModel
//筒次
@property(nonatomic, strong) NSString *inningSort;
@property(nonatomic, strong) ZInningModel *itemModel;
@end

@interface ZSceneItem : ZBaseModel
//场次
@property(nonatomic, strong) NSString *sceneSort;
@property(nonatomic, strong) NSString *openNum;
@property(nonatomic, strong) NSArray <ZInningItem *> *sceneLists;
@end

@interface ZHistoryAllList : ZBaseModel
@property(nonatomic, strong) NSArray <ZSceneItem *> *allHisoryLists;
@end
