//
//  AGImageView.h
//  AGPhotoBrowser
//
//  Created by 吴书敏 on 15/4/21.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//  自定义UIImageView，
/**
 AGImageView 功能
 1. 第一次点击图片图片放大
 2. 长按放大后的图片图片被保存到手机相册，并提示保存结果
 3. 第二次点击放大后的图片 图片缩小
 
 
 
 */


#import <UIKit/UIKit.h>

@interface AGImageView : UIImageView

@property (nonatomic,retain) UIImage *imageFromUrl;

- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSURL *)imageUrl;

@end
