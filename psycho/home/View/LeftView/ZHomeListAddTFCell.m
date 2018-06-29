//
//  ZHomeListAddTFCell.m
//  psycho
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeListAddTFCell.h"
#import "ZHomeTextFieldView.h"

@interface ZHomeListAddTFCell ()
@property (nonatomic,strong) ZHomeTextFieldView *inputView;

@end

@implementation ZHomeListAddTFCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeListAddTFCell";
    ZHomeListAddTFCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeListAddTFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setMainView];
    }
    return self;
    
}


- (void)setMainView {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (ZHomeTextFieldView *)inputView {
    if (!_inputView) {
        _inputView = [[ZHomeTextFieldView alloc] init];
        _inputView.max = 20;
        _inputView.formatterType = HNFormatterTypeAny;
        _inputView.valueChange = ^(NSString *value) {
            
        };
    }
    return _inputView;
}

+ (CGFloat)getCellHeight:(id)sender {
    return 40;
}
@end
