//
//  ViewController.m
//  AnnounView
//
//  Created by Arthur on 2018/6/6.
//  Copyright © 2018年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int _currentRow;
}

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.view addSubview:self.label];
    
    
    //这种三种方式创建的定时器不用加入到RunLoop，是由于系统已经将其加入到了默认的RunLoop中。而且这种定时器创建就会启动。
    
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"-------timer1--------");
    }];
    
    
//    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:5 invocation:<#(nonnull NSInvocation *)#> repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(printAction:) userInfo:@{@"value" : @"timer3"} repeats:YES];
    
    //这种三种方式创建的定时器都需要我们自己去加入到RunLoop中，不然定时器无法启动。
    NSTimer *timer4 = [NSTimer timerWithTimeInterval:7 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"-------timer4--------");
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer4 forMode:NSDefaultRunLoopMode];
//    NSTimer *timer5 = [NSTimer timerWithTimeInterval:<#(NSTimeInterval)#> invocation:<#(nonnull NSInvocation *)#> repeats:<#(BOOL)#>];
    NSTimer *timer6 = [NSTimer timerWithTimeInterval:9 target:self selector:@selector(printAction:) userInfo:@{@"value" : @"timer6"} repeats:YES];
//    timer6.fireDate = [NSDate distantPast]; //启动定时器
    timer6.fireDate = [NSDate distantFuture]; //停止定时器
    [[NSRunLoop mainRunLoop] addTimer:timer6 forMode:NSDefaultRunLoopMode];
    
    
    [[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addAnimationll) userInfo:nil repeats:YES] fire];
    
}

- (void)printAction:(NSTimer *)timer {
    NSLog(@"------%@--------",[timer.userInfo objectForKey:@"value"]);
}

- (void)addAnimationll{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _label.frame = CGRectMake(_label.frame.origin.x, 200, 100, 100);
    } completion:^(BOOL finished) {
        _label.frame = CGRectMake(_label.frame.origin.x, 100, 100, 100);
    }];
    
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _label.backgroundColor = [UIColor grayColor];
    }
    return _label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
