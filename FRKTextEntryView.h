//
//  FRKTextEntryView.h
//  Pods
//
//  Created by Francois Courville on 2015-05-23.
//
//

#import <Foundation/Foundation.h>

@protocol FRKTextEntryViewDelegate;

@protocol FRKTextEntryView <NSObject>

@property(nonatomic, weak) UITextField *textEntryTextField;
@property(nonatomic, weak) id<FRKTextEntryViewDelegate> delegate;

- (void)reset;

@end

@protocol FRKTextEntryViewDelegate <NSObject>

- (void)textEntryView:(id<FRKTextEntryView>)textEntryView didSubmitText:(NSString *)text;

@end
