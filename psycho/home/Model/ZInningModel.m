//
//  ZInningModel.m
//  psycho
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZInningModel.h"

@implementation ZInningListModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _listSort = @"";
        _listName = @"";
        _listInput = @[@""].mutableCopy;
        _listInputResult = @[@""].mutableCopy;
        _listOpenResult = @"";
        _listThisResult = @"";
        _listLastResult = @"";
        _listAllResult = @"";
    }
    return self;
}
@end


@implementation ZInningModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _sort = @"";
        _multiplying = @"";
        _multiplyingTure = @"";
        _inputAmout = @"";
        _amount = @"";
        _addAmount = @"";
        _subAmount = @"";
        _winNum = @"";
        
        _inninglist = @[].mutableCopy;
    }
    return self;
}

- (void)clearAll {
    _addAmount = @"";
    _winNum = @"";
    for (ZInningListModel *listModel in _inninglist) {
        listModel.listName = @"";
        listModel.listInput = @[@""].mutableCopy;
        listModel.listOpenResult = @"";
        listModel.listThisResult = @"";
        listModel.listLastResult = @"";
        listModel.listAllResult = @"";
    }
}
@end



@implementation ZInningItem

@end

@implementation ZSceneItem

@end

@implementation ZHistoryAllList

@end
