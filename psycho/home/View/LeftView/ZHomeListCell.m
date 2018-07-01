//
//  ZHomeListCell.m
//  psycho
//
//  Created by zzz on 2018/6/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeListCell.h"
#import "ZHomeTextFieldView.h"
#import "ZHomeListAddTFView.h"

@interface ZHomeListCell ()
@property (nonatomic,strong) UIView *backView;
//名称view
@property (nonatomic,strong) ZHomeTextFieldView *nameInputTF;
//加注view
@property (nonatomic,strong) ZHomeListAddTFView *addTFView;


@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) UIColor *lineColor;

@end

@implementation ZHomeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeListCell";
    ZHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _lineColor = kBack6Color;

        _titleArr = @[@"0", @"", @"", @"", @"",@"",@""];
        _widthArr = @[@(140.0f/1024),
                      @(137.0f/1024),
                      @(145.0f/1024),
                      @(146.0f/1024),
                      @(144.0f/1024),
                      @(145.0f/1024),
                      @(168.0f/1024)];
        
        [self setMainView];
    }
    return self;
}

- (void)setMainView {
    _labelArr = @[].mutableCopy;
    self.backgroundColor = [UIColor colorWithHexString:@"999999"];
    
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView  *tempView = nil;
    for (int i = 0; i < _titleArr.count; i++) {
        UIView *aView = nil;
        if (i == 1) {
            aView = self.nameInputTF;
        }else if(i == 2){
            aView = self.addTFView;
        }else{
            aView = [self getLabel:_titleArr[i]];
        }
        
        [_labelArr addObject:aView];
        if (tempView) {
            [aView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [aView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = aView;
    }
}


- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = [UIColor colorWithHexString:@"222222"];
    tempLabel.backgroundColor = [UIColor whiteColor];
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:18]];
    [self.backView addSubview:tempLabel];
    return tempLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = _lineColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = _lineColor.CGColor;
    }
    return _backView;
}

- (ZHomeTextFieldView *)nameInputTF {
    if (!_nameInputTF) {
        __weak typeof(self) weakSelf = self;
        _nameInputTF = [[ZHomeTextFieldView alloc] init];
        _nameInputTF.max = 10;
        _nameInputTF.isCustomKeyboard = NO;
        [_nameInputTF setIsCustomKeyboardType:NO];
        _nameInputTF.formatterType = HNFormatterTypeAny;
        _nameInputTF.valueChange = ^(NSString *value) {
            if (weakSelf.nameValueChange) {
                weakSelf.nameValueChange(value);
            }
        };
        
        [_backView addSubview:_nameInputTF];
    }
    return _nameInputTF;
}

- (ZHomeListAddTFView *)addTFView {
    if (!_addTFView) {
        __weak typeof(self) weakSelf = self;
        _addTFView = [[ZHomeListAddTFView alloc] init];
        _addTFView.isCustomKeyboard = YES;
        _addTFView.valueChange = ^(NSString *value) {
            if (weakSelf.valueChange) {
                weakSelf.valueChange(value);
            }
        };
        
        _addTFView.beginChange = ^(UITextField *textField) {
            if (weakSelf.beginChange) {
                weakSelf.beginChange(textField);
            }
        };
        
        _addTFView.endChange = ^(UITextField *textField) {
            if (weakSelf.endChange) {
                weakSelf.endChange(textField);
            }
        };
        [_backView addSubview:_addTFView];
    }
    
    return _addTFView;
}

- (void)setListModel:(ZInningListModel *)listModel {
    _listModel = listModel;
    for (int i = 0; i < _labelArr.count; i++) {
        if (i == 1) {
            _nameInputTF.inputTF.text = [NSString stringWithFormat:@"%@",listModel.listName];
        }else if (i == 2){
            _addTFView.inputList = listModel.listInput;
        }else{
            if ([_labelArr[i] isKindOfClass:[UILabel class]]) {
                UILabel *tempLabel = _labelArr[i];
                switch (i) {
                    case 0:
                        tempLabel.text = [NSString stringWithFormat:@"%@",listModel.listSort];
                        break;
                    case 3:
                        tempLabel.text = [NSString stringWithFormat:@"%@",listModel.listOpenResult];
                        break;
                    case 4:
                        tempLabel.text = [NSString stringWithFormat:@"%@",listModel.listThisResult];
                        break;
                    case 5:
                        tempLabel.text = [NSString stringWithFormat:@"%@",listModel.listLastResult];
                        break;
                    case 6:
                        tempLabel.text = [NSString stringWithFormat:@"%@",listModel.listAllResult];
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

+ (CGFloat)getCellHeight:(id)sender {
    NSArray *tempArr = sender;
    if (tempArr && tempArr.count > 1) {
        return 40 * tempArr.count;
    }
    return 40;
}
@end

