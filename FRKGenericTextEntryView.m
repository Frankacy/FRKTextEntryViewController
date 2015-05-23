//
//  FRKGenericTextEntryView.m
//  Pods
//
//  Created by Francois Courville on 2015-05-23.
//
//

#import "FRKGenericTextEntryView.h"
#import "FRKLine.h"

#import <Masonry/Masonry.h>

@interface FRKGenericTextEntryView ()

@property(nonatomic, weak) FRKLine *topLine;
@property(nonatomic, weak) UIButton *sendButton;
@property(nonatomic, weak) FRKLine *bottomLine;

@property(nonatomic, assign) BOOL currentlyDetectingMentions;
@property(nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation FRKGenericTextEntryView

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self setupView];
    [self setupConstraints];
    
    return self;
}

- (void)setupView {
    FRKLine *topLine = ({
        FRKLine *view = [[FRKLine alloc] init];
        view;
    });
    topLine.backgroundColor = [UIColor grayColor];
    [self addSubview:topLine];
    self.topLine = topLine;
    
    UITextField *textEntryTextField = ({
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"Write something!";
        textField.font = [UIFont systemFontOfSize:12.0];
        textField.textColor = [UIColor blackColor];
        textField;
    });
    [self addSubview:textEntryTextField];
    self.textEntryTextField = textEntryTextField;
    
    UIButton *sendButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"Send" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [button addTarget:self action:@selector(handleSendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self addSubview:sendButton];
    self.sendButton = sendButton;
    
    FRKLine *bottomLine = ({
        FRKLine *view = [[FRKLine alloc] init];
        view;
    });
    bottomLine.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;
}

- (void)setupConstraints {
    UIEdgeInsets insets = UIEdgeInsetsMake(8, 10, 8, 8);
    
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//    }];
//    
//    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.and.right.equalTo(self).with.insets(insets);
//        make.width.mas_equalTo([self.sendButton intrinsicContentSize].width).priorityHigh();
//    }];
//    
//    [self.textEntryTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.equalTo(self).with.insets(insets);
//        make.right.equalTo(self.sendButton.mas_left).with.offset(-8);
//    }];
//    
//    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom);
//    }];
}

- (void)handleSendButtonPressed:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate textEntryView:self didSubmitText:self.textEntryTextField.text];
    }
}

@end
