//
//  DropDown.m
//  yuexi
//
//  Created by ltz on 15/3/30.
//  Copyright (c) 2015年 李志彬. All rights reserved.
//

#import "DropDown.h"

@implementation DropDown 

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height<200) {
        frameHeight = 150;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        _tv = [[UITableView alloc] initWithFrame:CGRectMake(30, 30, frame.size.width - 30, 0)];
        _tv.delegate = self;
        _tv.dataSource = self;
        _tv.backgroundColor = [UIColor whiteColor];
        _tv.separatorColor = [UIColor lightGrayColor];
        _tv.hidden = YES;
        _tv.showsHorizontalScrollIndicator = NO;
        _tv.showsVerticalScrollIndicator = NO;
        _tv.layer.borderWidth = 1;
        _tv.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [self addSubview:_tv];
        
        _bt = [UIButton buttonWithType:0];
        _bt.frame = CGRectMake(0, 0, frame.size.width, 30);
        _bt.layer.borderWidth = 0.5;
        _bt.layer.borderColor = [UIColor grayColor].CGColor;
        _bt.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        _bt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       
        [_bt setTitleColor:[UIColor darkGrayColor]forState:UIControlStateNormal];
        [_bt addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:_bt];
    }
    
    return self;
}

-(void)dropdown{
    [_textField resignFirstResponder];
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
       // _textField.enabled = NO;
 
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = _tv.frame;
        frame.size.height = 0;
        _tv.frame = frame;
        frame.size.height = tabheight-40;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _tv.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [_bt setTitle:_btTitle forState:UIControlStateNormal];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 28;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //_textField.text = [_tableArray objectAtIndex:[indexPath row]];
    [_bt setTitle:[_tableArray objectAtIndex:[indexPath row]] forState:0];
    showList = NO;
    _tv.hidden = YES;
   // _textField.enabled = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = _tv.frame;
    frame.size.height = 0;
    _tv.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
