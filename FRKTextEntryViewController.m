//
//  FRKTextEntryViewController.m
//  Pods
//
//  Created by Francois Courville on 2015-05-23.
//
//

#import "FRKTextEntryViewController.h"
#import "FRKGenericTextEntryView.h"

#import <Masonry/Masonry.h>

@interface FRKTextEntryViewController () <FRKTextEntryViewDelegate>

@property(nonatomic, strong) MASConstraint *bottomConstraint;
@property(nonatomic, strong) MASConstraint *heightConstraint;

@end

@implementation FRKTextEntryViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    
    UIView<FRKTextEntryView> *textEntryView = ({
        UIView<FRKTextEntryView> *view = [[FRKGenericTextEntryView alloc] init];
        view.delegate = self;
        view;
    });
    [self.view addSubview:textEntryView];
    self.textEntryView = textEntryView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.textEntryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.textEntryView.superview);
    }];
    
    [self registerForKeyboardNotifications];
}

#pragma mark - TNSTextEntryViewDelegate

- (void)textEntryView:(TNSTextEntryView *)view didPressSendWithText:(NSString *)text {
    NSAssert(NO, @"Implement in subclass");
}

#pragma mark - Private

- (void)handleKeyboardAnimation:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect keyboardEndFrame = [self.view convertRect:[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    CGFloat onscreenHeight = CGRectGetHeight(self.view.bounds) - keyboardEndFrame.origin.y;
    if (onscreenHeight < 0) {
        onscreenHeight = 0;
    }
    
    self.bottomConstraint.offset = -onscreenHeight;
    [self.textEntryView setNeedsLayout];
  
    void (^animations)() = ^() {
        [self.view layoutIfNeeded];
    };
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:nil];
}

- (void)resetTextEntry {
    [self.textEntryView reset];
    [self.textEntryView resignFirstResponder];
}

- (void)registerForKeyboardNotifications {
    NSArray *keyboardNotifications = @[UIKeyboardWillShowNotification,
                                       UIKeyboardWillHideNotification,
                                       UIKeyboardWillChangeFrameNotification];
    for (NSString *notificationName in keyboardNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardAnimation:)
                                                     name:notificationName
                                                   object:nil];
    }
}

- (void)deregisterForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
