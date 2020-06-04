//
//  ZNView.m
//  LXViewShadowPath
//
//  Created by 张聪 on 2020/6/2.
//  Copyright © 2020 漫漫. All rights reserved.
//

#import "ZNAutoResizeTextView.h"
@interface ZNAutoResizeTextView()<UITextViewDelegate>
@property (nonatomic,strong) UITextView *tv;
@end
@implementation ZNAutoResizeTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
//        self.minH = 35;
//        self.maxH = 70;
    }
    return self;
}
-(void)changeZnViewHeight{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 100);
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
-(void)setupConfigurationWithView:(UIView*)view{
    view.layer.masksToBounds = NO;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 4;

    view.layer.shadowOpacity = 0.8;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = [UIColor purpleColor].CGColor;
    view.layer.shadowRadius = 10;
}
-(void)setupTextViewConfiguration:(UITextView*)tv{
    tv.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
//    tv.textContainer.lineBreakMode = NSLineBreakByCharWrapping;//
    tv.font = [UIFont systemFontOfSize:12];
    tv.scrollEnabled = NO;
    tv.layer.cornerRadius = self.layer.shadowRadius;
    tv.clipsToBounds = YES;
}
-(void)setupUI{
    [self setupConfigurationWithView:self];
    
    //添加textview
    UITextView *tv = [[UITextView alloc]initWithFrame:self.bounds];
    [self setupTextViewConfiguration:tv];
    tv.delegate = self;
    [self addSubview:tv];
    self.tv = tv;
}
- (void)textViewDidChange:(UITextView *)textView {

    //防止输入时在中文后输入英文过长直接中文和英文换行

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;

    NSDictionary *attributes = @{
        NSFontAttributeName:textView.font,
        NSParagraphStyleAttributeName:paragraphStyle
    };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];

//换行问题解决了，那么新的问题来了，系统中文键盘输入时，中文输入时拼音会先一步显示到文本（这里是我还没选择中文输入内容，拼音就乱入了）
//
//解决方法还是放在textViewDidchange里面

///防止拼音输入时，文本直接获取拼音

    UITextRange *selectedRange = [textView markedTextRange];

    NSString * newText = [textView textInRange:selectedRange];     //获取高亮部分

    if(newText.length>0)

    {

    return;

    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (!self.tv.superview.superview) {
        return NO;
    }

    NSString *finalText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
//    NSString *str1 = @"阿鲁卡咯哦也大阿狸几哈上就来咯一我其实呵呵呵呵呵呵呵时间就阔以啦咯啦啦本溪有司机家是不是在";
    //计算时要+左右lineFragmentPadding 默认值5

    CGSize strSize = [finalText boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)- textView.textContainer.lineFragmentPadding*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size;
    CGFloat calculateH = (strSize.height + textView.textContainerInset.top + textView.textContainerInset.bottom);
    CGFloat tempH = 0;
    BOOL tempScrollEnable = NO;
    
    if (calculateH < self.minH) {
        tempH = self.minH;
        tempScrollEnable = NO;
    }else if (calculateH < self.maxH) {//增加高度
        tempH = calculateH;
        tempScrollEnable = NO;
    }else {
        tempH = self.maxH;
        tempScrollEnable = YES;
    }
    [self setupWithHeight:tempH scrollEnable:tempScrollEnable];

    //计算高度
    return YES;
    
}
-(void)setupWithHeight:(CGFloat)height scrollEnable:(BOOL)scrollEnable{
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
    self.tv.frame = self.bounds;
    self.tv.scrollEnabled = scrollEnable;
}

@end
