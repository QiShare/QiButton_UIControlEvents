//
//  QiButton_UIControlEventsViewController.m
//  QiButton_UIControlEvents
//
//  Created by QiShare on 2018/8/6.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiButton_UIControlEventsViewController.h"

static NSUInteger kDisplaceStep = 0;    //!< 偏移位数
static long long const kDisplacementBase = 0x01;   //!< 偏移基数

@implementation QiButton_UIControlEventsViewController {
    
    NSDictionary *_controlEventDictionary;  //!< UIControlEvents 枚举字典
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIControlEvents";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    
    [self controlEventsDemo];
}

#pragma mark - private functions

- (void)prepareData {
    
    _controlEventDictionary = @{
                           @(UIControlEventTouchDown) : @"UIControlEventTouchDown",
                           @(UIControlEventTouchDownRepeat) : @"UIControlEventTouchDownRepeat",
                           @(UIControlEventTouchDragInside) : @"UIControlEventTouchDragInside",
                           @(UIControlEventTouchDragOutside) : @"UIControlEventTouchDragOutside",
                           @(UIControlEventTouchDragEnter) : @"UIControlEventTouchDragEnter",
                           @(UIControlEventTouchDragExit) : @"UIControlEventTouchDragExit",
                           @(UIControlEventTouchUpInside) : @"UIControlEventTouchUpInside",
                           @(UIControlEventTouchUpOutside) : @"UIControlEventTouchUpOutside",
                           @(UIControlEventTouchCancel) : @"UIControlEventTouchCancel",
                           @(UIControlEventValueChanged) : @"UIControlEventValueChanged",
                           @(UIControlEventPrimaryActionTriggered) : @"UIControlEventPrimaryActionTriggered",
                           @(UIControlEventEditingDidBegin):@"UIControlEventEditingDidBegin",
                           @(UIControlEventEditingChanged):@"UIControlEventEditingChanged",
                           @(UIControlEventEditingDidEnd):@"UIControlEventEditingDidEnd",
                           @(UIControlEventEditingDidEndOnExit):@"UIControlEventEditingDidEndOnExit",
                           @(UIControlEventAllTouchEvents):@"UIControlEventAllTouchEvents",
                           @(UIControlEventAllEditingEvents):@"UIControlEventAllEditingEvents",
                           @(UIControlEventApplicationReserved):@"UIControlEventApplicationReserved",
                           @(UIControlEventSystemReserved):@"UIControlEventSystemReserved",
                           @(UIControlEventAllEvents):@"UIControlEventAllEvents",
                           };
}

- (void)controlEventsDemo {
    
    // - (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
    /**
     * Demo思路 创建5个按钮 并且添加事件处理
        * 1. 中规中矩创建按钮添加事件 并且添加事件处理 点击按钮后 方法正常执行
        * 2. target 设置为nil 点击按钮后方法正常执行 在响应链上找一个对象响应消息
        * 3. action 设置为null 或者是 方法写错名字 会崩溃 unrecognized selector sent to instance 0x7fef757063e0'
        * 4. 给按钮添加 事件 UIControlEventAllEvents
        * 5. 复位按钮 当前功能是设置 kDisplaceStep = 0;
        查看效果：
        * 6. 读者可以试着改变UIControlEvents 位移枚举 输出为按钮添加的UIControlEvents的内容
        * 其中还有别的内容像 UITextField 像 UISlider 中的一些事件处理
     */
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    if (screenH == 812.0 && screenW == 375.0) {
        screenH -= 122.0;
    }else {
        screenH -= 64.0;
    }
    CGFloat btnTopMargin = 20.0;
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnH = (screenH - (btnTopMargin * 5)) / 5;
    
    UIButton *normalBtn = [[UIButton alloc] initWithFrame:CGRectMake(.0, btnTopMargin, btnW, btnH)];
    [self.view addSubview:normalBtn];
    [normalBtn setTitle:@"normalButton" forState:UIControlStateNormal];
    normalBtn.backgroundColor = [UIColor lightGrayColor];
    [normalBtn addTarget:self action:@selector(normalButtonClicked:) forControlEvents:UIControlEventTouchDown];
    [normalBtn addTarget:self action:@selector(normalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *targetNilBtn = [[UIButton alloc] initWithFrame:CGRectMake(.0, (btnTopMargin * 2 + btnH), btnW, btnH)];
    [self.view addSubview:targetNilBtn];
    [targetNilBtn setTitle:@"targetNilButton" forState:UIControlStateNormal];
    targetNilBtn.backgroundColor = [UIColor grayColor];
    [targetNilBtn addTarget:nil action:@selector(targetNilButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [targetNilBtn addTarget:nil action:@selector(targetNilButtonClicked:) forControlEvents:UIControlEventTouchDown];
    
    UIButton *selectorNullBtn = [[UIButton alloc] initWithFrame:CGRectMake(.0, (btnTopMargin * 3 + btnH * 2), btnW, btnH)];
    [self.view addSubview:selectorNullBtn];
    [selectorNullBtn setTitle:@"null Selector Button" forState:UIControlStateNormal];
    selectorNullBtn.backgroundColor = [UIColor darkGrayColor];
    [selectorNullBtn addTarget:self action:@selector(null) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *allEventsBtn = [[UIButton alloc] initWithFrame:CGRectMake(.0, (btnTopMargin * 4 + btnH * 3), btnW, btnH)];
    [self.view addSubview:allEventsBtn];
    [allEventsBtn setTitle:@"allEventsButton" forState:UIControlStateNormal];
    allEventsBtn.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.6];
    [allEventsBtn addTarget:self action:@selector(allEventButtonClicked:) forControlEvents:UIControlEventAllEvents];
    
    UIButton *resetBtn = [[UIButton alloc] initWithFrame:CGRectMake(.0, (btnTopMargin * 5 + btnH * 4), btnW, btnH)];
    [self.view addSubview:resetBtn];
    [resetBtn setTitle:@"复位" forState:UIControlStateNormal];
    resetBtn.backgroundColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.8];
    [resetBtn addTarget:self action:@selector(resetButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - action functions

- (void)normalButtonClicked:(UIButton *)sender {
    
    UIControlEvents tempEvents = sender.allControlEvents;
    
    for (; kDisplaceStep < 32; ++ kDisplaceStep) {
        if (tempEvents & (kDisplacementBase << kDisplaceStep)) {
            NSLog(@"添加的allControlEvents:%lu",(unsigned long)sender.allControlEvents);
            NSLog(@"分别为: %llu--%@", (kDisplacementBase << kDisplaceStep),_controlEventDictionary[@(kDisplacementBase << kDisplaceStep)]); // %o %x
            // 65 相当于 UIControlEventTouchDown | UIControlEventTouchUpInside
        }
    }
    NSLog(@"%s",__FUNCTION__);
}

- (void)targetNilButtonClicked:(UIButton *)sender {
    
    NSLog(@"添加的allControlEvents:%lu",(unsigned long)sender.allControlEvents);
    NSLog(@"%s",__FUNCTION__);
    // 调用次数为2 是因为测试的UIControlEventTouchDown 和 UIControlEventTouchUpInside 各调用了一次
}

- (void)allEventButtonClicked:(UIButton *)sender {
    
    UIControlEvents tempEvents = sender.allControlEvents;
    for (; kDisplaceStep < 32; ++ kDisplaceStep) {
        if (tempEvents & (kDisplacementBase << kDisplaceStep)) {
            NSLog(@"添加的allControlEvents:%lu",(unsigned long)sender.allControlEvents);
            NSLog(@"可能有: %llu--%@", (kDisplacementBase << kDisplaceStep),_controlEventDictionary[@(kDisplacementBase << kDisplaceStep)]); // %o %x
        }
    }
    // 其输出结果代表其可以响应很多事件，这种情况下就不能够准确的确定是那个事件了， 因为可能是彼此之间二进制位重复的值 做的 或 操作后的结果。
    NSLog(@"%s",__FUNCTION__);
}

- (void)resetButtonClicked:(UIButton *)sender {
    
    NSLog(@"%s",__FUNCTION__);
    kDisplaceStep = 0;
}


#pragma mark - ReadMe

- (void)readMe {

#if 0
    typedef NS_OPTIONS(NSUInteger, UIControlEvents) {
        UIControlEventTouchDown                                         = 1 <<  0,      // on all touch downs
        UIControlEventTouchDownRepeat                                   = 1 <<  1,      // on multiple touchdowns (tap count > 1)
        UIControlEventTouchDragInside                                   = 1 <<  2,
        UIControlEventTouchDragOutside                                  = 1 <<  3,
        UIControlEventTouchDragEnter                                    = 1 <<  4,
        UIControlEventTouchDragExit                                     = 1 <<  5,
        UIControlEventTouchUpInside                                     = 1 <<  6,
        UIControlEventTouchUpOutside                                    = 1 <<  7,
        UIControlEventTouchCancel                                       = 1 <<  8,
        
        UIControlEventValueChanged                                      = 1 << 12,     // sliders, etc.
        UIControlEventPrimaryActionTriggered NS_ENUM_AVAILABLE_IOS(9_0) = 1 << 13,     // semantic action: for buttons, etc.
        
        UIControlEventEditingDidBegin                                   = 1 << 16,     // UITextField
        UIControlEventEditingChanged                                    = 1 << 17,
        UIControlEventEditingDidEnd                                     = 1 << 18,
        UIControlEventEditingDidEndOnExit                               = 1 << 19,     // 'return key' ending editing
        
        UIControlEventAllTouchEvents                                    = 0x00000FFF,  // for touch events
        UIControlEventAllEditingEvents                                  = 0x000F0000,  // for UITextField
        UIControlEventApplicationReserved                               = 0x0F000000,  // range available for application use
        UIControlEventSystemReserved                                    = 0xF0000000,  // range reserved for internal framework use
        UIControlEventAllEvents                                         = 0xFFFFFFFF   // 相当于上边的所有值的 或
    };
#endif
    
#if 0
    
        UIControlEventTouchDown
            A touch-down event in the control.
            触下control 中的事件(这个可以用于监测 刚刚按下按钮 或者是UISlider的时候的事件)
    
        UIControlEventTouchDownRepeat
            A repeated touch-down event in the control; for this event the value of the UITouch tapCount method is greater than one.
            在control上重复地按下的事件 这个事件的tap数量大于1
        
        UIControlEventTouchDragInside
            An event where a finger is dragged inside the bounds of the control.
            手指在control的bounds范围内拖动的的事件
        
        UIControlEventTouchDragOutside
            An event where a finger is dragged just outside the bounds of the control.
            当手指拖动刚好在control的bounds 范围外的事件
        
        UIControlEventTouchDragEnter
            An event where a finger is dragged into the bounds of the control.
            当手指拖动进入control范围内的事件
        
        UIControlEventTouchDragExit
            An event where a finger is dragged from within a control to outside its bounds.
            当手指从control范围内到它的bounds外的时候的事件
        
        UIControlEventTouchUpInside
            A touch-up event in the control where the finger is inside the bounds of the control.
            手指在在control内部 触发的touch-up事件(经常给按钮添加这个事件)
        
        UIControlEventTouchUpOutside
            A touch-up event in the control where the finger is outside the bounds of the control.
            手指在在control外部 触发的touch-up事件
        
        UIControlEventTouchCancel
            A system event canceling the current touches for the control.
                一种系统事件 取消control当前触摸的事件
            
        UIControlEventValueChanged
            A touch dragging or otherwise manipulating a control, causing it to emit a series of different values.
            拖动触摸 或 其他操作一个control引起这个control显示一系列不同的值(像UISlider在拖动的时候值的变化可以通过这个事件来监测)
        
        UIControlEventPrimaryActionTriggered
            A semantic action triggered by buttons.
            按钮触发的语义动作? 这个没用过
        
        UIControlEventEditingDidBegin
            A touch initiating an editing session in a UITextField object by entering its bounds.
            当触摸UITextField对象后 通过进入它的bounds 初始化一个编辑会话
        
        UIControlEventEditingChanged
            A touch making an editing change in a UITextField object.
            触摸UITextField对象后一个编辑改变
        
        UIControlEventEditingDidEnd
            A touch ending an editing session in a UITextField object by leaving its bounds.
            在手指离开TextFiled对象的bounds的时候 触摸结束的一个编辑会话
        
        UIControlEventEditingDidEndOnExit
            A touch ending an editing session in a UITextField object.
            在UITextField对象中 触摸结束编辑会话
        
        UIControlEventAllTouchEvents
            All touch events.
            所有的触摸事件
        
        UIControlEventAllEditingEvents
            All editing touches for UITextField objects.
                对于UITextFiled对象的所有的的编辑触摸
            
        UIControlEventApplicationReserved
            A range of control-event values available for application use.
                为应用使用的预留的 一系列可用的的control-event值
                
        UIControlEventSystemReserved
            A range of control-event values reserved for internal framework use.
                    为内部framework预留的 一系列control-event values
                    
        UIControlEventAllEvents
            All events, including system events.
            所有的事件 包括系统事件
#endif
    /**
     * 只要是加了UIControlEventTouchDown像那么相应的方式是会首先要调用的
     * 其余的像UIControlEventTouchUpInside对应的方法可能会调用
     * 像UIControlEventTouchDragInside 则可能在手指在按钮中拖动的时候 会调用对应的方法
     * 对于UISlider经常用到的有依次添加 UIControlTouchDown UIControlEventValueChanged UIControlEventTouchUpInside 对应的方法来处理UISlider滑动过程中的问题
     * 参考学习网址：
     * https://developer.apple.com/documentation/uikit/uicontrolevents?language=objc
     *
     */
}

@end
