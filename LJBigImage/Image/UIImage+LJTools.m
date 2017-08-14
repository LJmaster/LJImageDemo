//
//  UIImage+LJTools.m
//  LJBigImage
//
//  Created by 杰刘 on 2017/8/14.
//  Copyright © 2017年 刘杰. All rights reserved.
//  图片的相关操作的工具类

#import "UIImage+LJTools.h"

@implementation UIImage (LJTools)

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{

    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //创建位图大小。并设置为当前上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    //
    CGContextRef context = UIGraphicsGetCurrentContext();
    //颜色填充到创建的位图
    CGContextSetFillColorWithColor(context, color.CGColor);
    //画图形
    CGContextFillRect(context, rect);
    //取得绘制的image
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘制
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(UIImage *)scaleImageWithSize:(CGSize)size{

    UIGraphicsBeginImageContextWithOptions(size, YES, self.scale);
    //根据size重绘制image
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //获取的新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return newImage;

}

-(UIImage *)scaleImageWithScale:(CGFloat)scale{

    if (scale < 0) {
        return self;
    }
    CGSize scaleSize = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    return [self scaleImageWithSize:scaleSize];
}


- (UIImage *)scaleImageToTargetWidth:(CGFloat)targetW{
    
    CGSize size = self.size;
    
    if (size.width <= targetW) {
        return self;
    }
    
    CGFloat scale = targetW / size.width;
    
    return [self scaleImageWithScale:scale];
}

- (UIImage *)scaleImageToTargetHeight:(CGFloat)targetH{
    
    CGSize size = self.size;
    
    if (size.height <= targetH) {
        return self;
    }
    
    CGFloat scale = targetH / size.height;
    
    return [self scaleImageWithScale:scale];
}

-(UIImage *)clipImageWithPath:(UIBezierPath *)path bgColor:(UIColor *)bgColor{

    CGSize imageSize = self.size;
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, self.scale);
    
    if (bgColor) {
        
        UIBezierPath * bgRect = [UIBezierPath bezierPathWithRect:rect];
        
        [bgColor setFill];
        
        [bgRect fill];
        
    }
    //裁剪
    [path addClip];
    //绘制
    [self drawInRect:rect];
    
    UIImage * clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return clipImage;
    
}


-(UIImage *)compressImageToTargetPx:(CGFloat)targetPx{

    UIImage * compressImage = nil;
    
    CGSize imageSize = self.size;
    
    CGFloat compressScale = 0;//压缩比例
    //压缩后的目标size
    CGSize targetSize = CGSizeMake(targetPx, targetPx);
    //实际宽高比例
    CGFloat factor = imageSize.width/imageSize.height;

    if (imageSize.width < targetSize.width && imageSize.height < targetSize.height) {
    //图片实际宽高 都小于 目标宽高 ，没必要压缩
        compressImage = self;
    }else if (imageSize.width > targetSize.width && imageSize.height < targetSize.height){
     //图片实际宽高 都大于 目标宽高
        if (factor <= 2) {
            //宽高比例小于等于2,获取大的等比压缩
            compressScale = targetPx / MAX(imageSize.width,imageSize.height);
        }else{
            //宽高比例大于2,获取小的等比压缩
            compressScale = targetPx / MIN(imageSize.width,imageSize.height);
        }
    }else if(imageSize.width > targetSize.width && imageSize.height < imageSize.height){
        //宽大于目标宽,高小于目标高
        if (factor <= 2) {
            compressScale = targetSize.width / imageSize.width;
        }else{
            compressImage = self;
        }
    }else if(imageSize.width < targetSize.width && imageSize.height > imageSize.height){
        //宽小于目标宽,高大于目标高
        if (factor <= 2) {
            compressScale = targetSize.height / imageSize.height;
        }else{
            compressImage = self;
        }
    }

    //需要压缩
    if (compressScale > 0 && !compressImage) {
        
        CGSize compressSize = CGSizeMake(self.size.width * compressScale, self.size.height * compressScale);
        
        UIGraphicsBeginImageContextWithOptions(compressSize, YES, 1);
        
        [self drawInRect:CGRectMake(0, 0, compressSize.width, compressSize.height)];
        
        compressImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    if (!compressImage) {
        
        compressImage = self;
    }
    
    return compressImage;
}




















@end
