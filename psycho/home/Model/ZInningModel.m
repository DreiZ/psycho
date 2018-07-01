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
        _openNum  = @"";
        _amount = @"";
        _addAmount = @"";
        _subAmount = @"";
        
        _inninglist = @[].mutableCopy;
    }
    return self;
}
@end
