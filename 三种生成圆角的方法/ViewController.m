//
//  ViewController.m
//  三种生成圆角的方法
//
//  Created by Yanni on 16/8/10.
//  Copyright © 2016年 Yanni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createUI{
    /**
     第一种，最快速，但是影响性能
     */
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor = [UIColor redColor];
    //只需要设置layer层的两个属性
    //设置圆角
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    //将多余的部分切掉
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    /**
     * 第二种， 用UIBezier曲线和Core Graphics
     */
    UIImageView * imageBezier = [[UIImageView alloc]initWithFrame:CGRectMake(100, 220, 100, 100)];
     imageBezier.image = [UIImage imageNamed:@"01.jpg"];
    imageBezier.backgroundColor = [UIColor blueColor];
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(imageBezier.bounds.size, NO, 1.0);
    //使用贝塞尔曲线画出一个圆形图
    UIBezierPath * path =  [UIBezierPath bezierPathWithRoundedRect:imageBezier.bounds cornerRadius:imageBezier.frame.size.width] ;
    [path addClip];
    [imageBezier drawRect:imageBezier.bounds];
    
    imageBezier.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    [self.view addSubview:imageBezier];
    
    /**
     *  第三种，CAShapeLayer和贝塞尔曲线UIBezierPath画圆角图片
     */
    UIImageView *imageShape = [[UIImageView alloc]initWithFrame:CGRectMake(100, 360, 100, 100)];
    imageShape.image = [UIImage imageNamed:@"01.jpg"];
    imageShape.backgroundColor = [UIColor purpleColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageShape.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:imageShape.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = imageShape.bounds;
    maskLayer.path = maskPath.CGPath;
    imageShape.layer.mask = maskLayer;
    [self.view addSubview:imageShape];
}
@end
