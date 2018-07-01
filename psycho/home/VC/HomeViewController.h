//
//  HomeViewController.h
//  psycho
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseViewController.h"
#import "ZBaseModel.h"
#import "ZInningModel.h"

@interface ZSearchItem : ZBaseModel
@property(nonatomic, strong) ZInningModel *itemStr;
@end

@interface ZSearchList : ZBaseModel
@property(nonatomic, strong) NSArray <ZSearchItem *> *lists;
@end

@interface HomeViewController : ZBaseViewController

@end
