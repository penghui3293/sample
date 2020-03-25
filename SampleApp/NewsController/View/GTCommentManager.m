//
//  GTCommentManager.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/7.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTCommentManager.h"
#import "GTScreen.h"

@interface GTCommentManager()<UITextViewDelegate>

@property(nonatomic,strong,readwrite)UIView *backgroudView;

@property(nonatomic,strong,readwrite)UIView *floatView;

@property(nonatomic,strong,readwrite)UITextView *textView;

@property (nonatomic, strong, readwrite) UIButton *releaseButton;

@end
@implementation GTCommentManager

+ (GTCommentManager *) shareManager{
    static GTCommentManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTCommentManager alloc] init];
    });
    return manager;
}

- (instancetype) init{
    self = [ super init];
    if (self) {
        _backgroudView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _backgroudView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [_backgroudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapBackgroud)]];
        
        [_backgroudView addSubview:({
            _floatView = [[UIView alloc] initWithFrame:CGRectMake(0, _backgroudView.bounds.size.height, SCREEN_WIDTH, UI(120))];
            _floatView.backgroundColor = [UIColor whiteColor];
            _floatView;
        })];
        
        [_backgroudView addSubview:({
            _textView = [[UITextView alloc]  initWithFrame:CGRectMake(UI(10), _backgroudView.bounds.size.height, SCREEN_WIDTH-UI(80), UI(100))];
            _textView.backgroundColor = [UIColor lightGrayColor];
            _textView.layer.cornerRadius = 10;
            _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _textView.layer.borderWidth = 2.f;
            _textView.delegate = self;
            _textView;
        })];
        
        [_backgroudView addSubview:({
            _releaseButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - UI(65), _backgroudView.bounds.size.height, UI(60), UI(40))];
            _releaseButton.backgroundColor = [UIColor whiteColor];
            [_releaseButton setTitle:@"发布" forState:UIControlStateNormal];
            [_releaseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            _releaseButton.layer.cornerRadius = UI(15);
            _releaseButton;
        })];

        [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_doTextViewAnimationWithNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -

- (void) showCommentView{
    [[UIApplication sharedApplication].keyWindow addSubview:_backgroudView];
    [_textView becomeFirstResponder];
}

- (void) _tapBackgroud{
    [_textView resignFirstResponder];
    [ _backgroudView removeFromSuperview];
}

- (void) _doTextViewAnimationWithNotification:(NSNotification *) noti{

    CGFloat duration  = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect  keybordFrame =[ [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if (keybordFrame.origin.y >= SCREEN_HEIGHT) {
        //收起
        [UIView animateWithDuration:duration animations:^{
            
            self.floatView.frame = CGRectMake(0, self.backgroudView.bounds.size.height, SCREEN_WIDTH, UI(120));
            
             self.textView.frame = CGRectMake(UI(10), self.backgroudView.bounds.size.height, SCREEN_WIDTH-UI(80), UI(100));

             self.releaseButton.frame = CGRectMake(SCREEN_WIDTH - UI(65), self.backgroudView.bounds.size.height, UI(60), UI(40));
        }];
    }else{
//升起
        [UIView animateWithDuration:duration animations:^{
            
            self.floatView.frame = CGRectMake(0, self.backgroudView.bounds.size.height - keybordFrame.size.height - UI(120), SCREEN_WIDTH, UI(120));

            self.textView.frame = CGRectMake(UI(10), self.backgroudView.bounds.size.height - keybordFrame.size.height - UI(110), SCREEN_WIDTH-UI(80), UI(100));

            self.releaseButton.frame = CGRectMake(SCREEN_WIDTH - UI(65), self.backgroudView.bounds.size.height  - keybordFrame.size.height - UI(80), UI(60), UI(40));

        }];

//        [UIView animateWithDuration:duration animations:^{
//            self.floatView.frame = CGRectMake(0, self.backgroudView.bounds.size.height - keybordFrame.size.height - UI(100), SCREEN_WIDTH, UI(100));
//        }];
    }
}

@end
