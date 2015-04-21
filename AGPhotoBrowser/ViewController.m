//
//  ViewController.m
//  AGPhotoBrowser
//
//  Created by 吴书敏 on 15/4/21.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ViewController.h"
#import "AGImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr0nly5j20pf0gygo6.jpg"];

    AGImageView *agImageView = [[AGImageView alloc] initWithFrame:(CGRectMake(50, 50,220,124.5)) imageUrl:url];
    [self.view addSubview:agImageView];
    [agImageView release];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
