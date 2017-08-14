//
//  UIImage+LJTools.h
//  LJBigImage
//
//  Created by 杰刘 on 2017/8/14.
//  Copyright © 2017年 刘杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LJTools)


/**
 通过颜色，大小取得图片
 
 @param color <#color description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 缩放图片到指定Size
 */
-(UIImage *)scaleImageWithSize:(CGSize)size;

/**
 按比例缩放图片，scale就是缩放比例
 */
- (UIImage *)scaleImageWithScale:(CGFloat)scale;

/**
 缩放图片到指定宽
 */
- (UIImage *)scaleImageToTargetWidth:(CGFloat)targetW;

/**
 缩放图片到指定高
 */
- (UIImage *)scaleImageToTargetHeight:(CGFloat)targetH;


#pragma mark - 裁剪

/**
 根据贝塞尔路径来裁剪
 */
- (UIImage *)clipImageWithPath:(UIBezierPath *)path bgColor:(UIColor *)bgColor;

#pragma mark - 图片压缩
/**
 压缩到指定像素px
 */
- (UIImage *)compressImageToTargetPx:(CGFloat)targetPx;




@end
