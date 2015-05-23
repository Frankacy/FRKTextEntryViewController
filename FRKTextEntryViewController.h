//
//  FRKTextEntryViewController.h
//  Pods
//
//  Created by Francois Courville on 2015-05-23.
//
//

#import <UIKit/UIKit.h>

@class FRKTextEntryViewController;
@protocol FRKTextEntryView;

@protocol FRKTextEntryViewControllerDelegate <NSObject>

- (void)textEntryViewController:(FRKTextEntryViewController *)controller didPressSendWithText:(NSString *)text;

@end

@interface FRKTextEntryViewController : UIViewController

@property(nonatomic, weak) id<FRKTextEntryViewControllerDelegate> delegate;
@property(nonatomic, weak) UIView<FRKTextEntryView> textEntryView;

@end
