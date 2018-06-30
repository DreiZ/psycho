//
//  ZHomeListCell.h
//  psycho
//
//  Created by zzz on 2018/6/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHomeListCell : UITableViewCell
@property (nonatomic,assign) NSInteger addNum;
@property (nonatomic,assign) NSInteger sort;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(id)sender;
@end
