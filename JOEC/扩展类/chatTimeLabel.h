//
//  chatTimeLabel.h
//  StudyAbroad
//
//  Created by ltz on 16/5/28.
//  Copyright © 2016年 gdshwhl007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatTimeLabel : UILabel

// 剩余的秒数
@property (nonatomic, assign) NSTimeInterval countDownTimeInterval;

//// 默认为NO，当进入后台一段时间后定时器将会暂停及时，再次
//// 回到前台才会启动，设置为YES时弥补这种状态 如果用户更改系统时间的话，此方法不适用
//@property (nonatomic, assign) BOOL recoderTimeIntervalDidInBackground;

- (void)stopCountDown;

- (void)pauseTheChatTime:(BOOL)isPause;

@end

//@protocol ZQCountDownViewDelegate <NSObject>
//
//- (void)countDownDidFinished;
//
//
//@end
