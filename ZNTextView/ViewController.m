//
//  ViewController.m
//  ZNTextView
//
//  Created by 张聪 on 2020/6/4.
//  Copyright © 2020 李煜. All rights reserved.
//

#import "ViewController.h"
#import "ZNAutoResizeTextView.h"
@interface ViewController ()
@property (nonatomic,strong) ZNAutoResizeTextView *zn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ZNAutoResizeTextView *zn = [[ZNAutoResizeTextView alloc]initWithFrame:CGRectMake(50, 300, 200, 30)];
    [self.view addSubview:zn];
    zn.maxH = 70;
    zn.minH = 35;

    self.zn = zn;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *ani = [[CABasicAnimation alloc]init];
    ani.keyPath = @"position";
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 500)];
    ani.duration = 3;
    ani.repeatCount = MAXFLOAT;
    [self.zn.layer addAnimation:ani forKey:nil];
}
@end
