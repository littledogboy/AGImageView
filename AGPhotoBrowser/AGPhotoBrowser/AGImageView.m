//
//  AGImageView.m
//  AGPhotoBrowser
//
//  Created by 吴书敏 on 15/4/21.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "AGImageView.h"
#import "UIImageView+WebCache.h" //导入第三方类库

@interface AGImageView ()

@property (nonatomic,retain) UIView *backView;
@property (nonatomic,retain) UIImageView *photoImageView;

@end

@implementation AGImageView
- (void)dealloc
{
    [_imageFromUrl release];
    [_backView release];
    [_photoImageView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame imageUrl:(NSURL *)imageUrl
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES; // 打开用户交互
        [self sd_setImageWithURL:imageUrl]; // sd方法
        self.clipsToBounds = YES; // 超出 view的 frame 边界剪裁
        self.contentMode = UIViewContentModeScaleAspectFill; // 等比缩放 超出剪裁
        self.imageFromUrl = self.image; // 获取网络Url的image
        
        // 添加单击手势事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [self addGestureRecognizer:tapGesture];

    }
    return self;
}

- (void)tapImage
{
    // 获取keyWindow 初始化_backView
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:(UIStatusBarAnimationFade)];
    _backView = [[UIView alloc] init];
    _backView.frame = [UIScreen mainScreen].bounds;
    _backView.backgroundColor = [UIColor blackColor];
    
    // 自动调整子视图 保证与左 上  顶 下距离不变
    _backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _photoImageView = [[UIImageView alloc] initWithFrame:self.frame];
    _photoImageView.image = self.image;
    
#pragma mark- 给大图添加点击手势
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwo)];
    tapTwo.numberOfTapsRequired = 1;
    tapTwo.numberOfTouchesRequired = 1;

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    longPressGesture.numberOfTouchesRequired = 1;
    longPressGesture.minimumPressDuration = 0.5;
    _photoImageView.userInteractionEnabled = YES;
    
    [_photoImageView addGestureRecognizer:tapTwo];
    [_photoImageView addGestureRecognizer:longPressGesture];
    [tapTwo release];
    [longPressGesture release];
    
    // 放大动画
    [UIView animateWithDuration:0.2 animations:^{
        // 图片放大
        _photoImageView.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
    }];
    
    // 设置photoImageView
    _photoImageView.backgroundColor = [UIColor clearColor];
    _photoImageView.clipsToBounds = YES;
    _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_backView addSubview:_photoImageView];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_backView];

}


- (void)tapTwo
{
//    NSLog(@"第二次点击缩小");
    //    CGRect smallImageFrame = self.smallImageView.frame;
    //    CGRect photoImageFrame = self.photoImageView.frame;
    [UIView animateWithDuration:0.2 animations:^{
        self.photoImageView.frame = self.frame;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
    }];
    
}

#pragma mark- 长按触发保存图片到手机相册事件
- (void)longPress:(UILongPressGestureRecognizer *)longPG
{
    // 如果不加 state判断会触发多次，因为longPress手势不是单次执行手势
    if (longPG.state == UIGestureRecognizerStateBegan) {
        NSLog(@"longPress被触发");
        [self saveImagetoPhotos:self.photoImageView.image];
    }
}

- (void)saveImagetoPhotos:(UIImage *)saveImage
{
    NSLog(@"将要保存图片");
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil;
    if (error != nil) {
        msg = @"图片保存失败";
    }
    else
    {
        msg = @"图片保存成功";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存结果提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
