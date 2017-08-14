//
//  ViewController.m
//  LJBigImage
//
//  Created by 杰刘 on 2017/8/14.
//  Copyright © 2017年 刘杰. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    
    bigImageView.center = self.view.center;
    
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:@"http://139.199.211.51//jiazhuang/Upload/goods/2017-08-08/59895ae2d7ea2.png"] placeholderImage:nil];
    
    [self.view addSubview:bigImageView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
