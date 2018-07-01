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
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *openNum;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *addAmount;
@property (nonatomic, strong) NSString *subAmount;

@property (nonatomic,strong) NSMutableArray <ZInningListModel *> *inninglist;

@end
