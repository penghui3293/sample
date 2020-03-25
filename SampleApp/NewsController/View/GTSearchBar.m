//
//  GTSearchBar.m
//  SampleApp
//
//  Created by penghuizhang on 2020/3/6.
//  Copyright © 2020 penghuizhang. All rights reserved.
//

#import "GTSearchBar.h"
#import "GTScreen.h"

@interface GTSearchBar()<UITextFieldDelegate>

@property (nonatomic,strong,readwrite) UITextField *textField;

@end

@implementation GTSearchBar

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _textField = [[UITextField alloc] initWithFrame:CGRectMake(UI(5), UI(5), frame.size.width - UI(5)*2, frame.size.height - UI(5)*2)];
            _textField.backgroundColor = [UIColor whiteColor];
            _textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search" ]];
            _textField.leftViewMode = UITextFieldViewModeAlways;
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.layer.cornerRadius = 10;
            _textField.delegate = self;
            _textField.placeholder = @"今日热点推荐";
//              [_textField becomeFirstResponder];
            _textField;
        })];
        
    }
    return self;
}

#pragma mark - delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    字数判断
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return YES;
}


@end
