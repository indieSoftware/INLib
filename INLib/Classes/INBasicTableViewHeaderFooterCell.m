// INBasicTableViewHeaderFooterCell.m
//
// Copyright (c) 2014 Sven Korset
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "INBasicTableViewHeaderFooterCell.h"

@interface INBasicTableViewHeaderFooterViewStats : NSObject

@property (nonatomic) CGFloat viewHeight;
@property (nonatomic, strong) NSString *viewIdentifier;

@end


@implementation INBasicTableViewHeaderFooterViewStats

@end



static NSMutableDictionary *__dictINBasicTableViewHeaderFooterViewStats;


@interface INBasicTableViewHeaderFooterView()

@end


@implementation INBasicTableViewHeaderFooterView

+ (instancetype)view {
    INBasicTableViewHeaderFooterView *sectionHeaderFooter = [[self alloc] initWithReuseIdentifier:[self viewIdentifier]];
    return sectionHeaderFooter;
}

+ (UIView *)contentViewFromNibForOwner:(id)owner {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil];
    UIView *view = [nib objectAtIndex:0];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

+ (CGFloat)viewDefaultHeight {
    INBasicTableViewHeaderFooterViewStats *viewStats = [self viewStats];
    CGFloat height = viewStats.viewHeight;
    return height;
}

+ (NSString *)viewIdentifier {
    INBasicTableViewHeaderFooterViewStats *viewStats = [self viewStats];
    NSString *identifier = viewStats.viewIdentifier;
    return identifier;
}

+ (INBasicTableViewHeaderFooterViewStats *)viewStats {
    if (__dictINBasicTableViewHeaderFooterViewStats == nil) {
        __dictINBasicTableViewHeaderFooterViewStats = [NSMutableDictionary dictionary];
    }
    NSString *className = NSStringFromClass(self);
    INBasicTableViewHeaderFooterViewStats *viewStats = [__dictINBasicTableViewHeaderFooterViewStats objectForKey:className];
    if (viewStats == nil) {
        viewStats = [[INBasicTableViewHeaderFooterViewStats alloc] init];
        INBasicTableViewHeaderFooterView *dummyOwner = [[self alloc] initWithReuseIdentifier:nil];
        UIView *view = [self contentViewFromNibForOwner:dummyOwner];
        [viewStats setViewHeight:view.frame.size.height];
        [viewStats setViewIdentifier:className];
        [__dictINBasicTableViewHeaderFooterViewStats setObject:viewStats forKey:className];
    }
    return viewStats;
}

+ (void)registerAtTableView:(UITableView *)tableView {
    // register class instead of nibs, because with Xcode 6 it's not possible to create table header footer views in nibs
    // and using table view cells instead doesn't resize the contentView according to any constraints
    [tableView registerClass:self forHeaderFooterViewReuseIdentifier:[self viewIdentifier]];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self == nil) return self;
    
    UIView *content = [self.class contentViewFromNibForOwner:self];
    [self.contentView addSubview:content];
    NSDictionary *bindings = NSDictionaryOfVariableBindings(content);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[content]|" options:0 metrics:0 views:bindings]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[content]|" options:0 metrics:0 views:bindings]];
    
    return self;
}


@end
