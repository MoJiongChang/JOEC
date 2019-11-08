//
//  DropDown.h
//  yuexi
//
//  Created by ltz on 15/3/30.
//  Copyright (c) 2015年 李志彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDown : UIView <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tv;//下拉列表
    NSArray *_tableArray;//下拉列表数据
    UITextField *_textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
    
    NSString *_btTitle;
    
    UIButton *_bt;

}

@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *tableArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *bt;
@property (nonatomic,strong) NSString *btTitle;

@end
