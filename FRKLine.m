//
//  FRKLine.m
//  Pods
//
//  Created by Francois Courville on 2015-05-23.
//
//

#import "FRKLine.h"

@implementation FRKLine

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    return self;
}

- (CGSize)intrinsicContentSize {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    return CGSizeMake(width, 0.5);
}

@end
