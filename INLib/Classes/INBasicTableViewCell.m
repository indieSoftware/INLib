// INBasicTableViewCell.m
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


#import "INBasicTableViewCell.h"

@interface INBasicTableViewCellStats : NSObject

@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, strong) NSString *cellIdentifier;

@end


@implementation INBasicTableViewCellStats

@end



static NSMutableDictionary *__dictINBasicTableViewCellStats;


@interface INBasicTableViewCell()

@end


@implementation INBasicTableViewCell

#pragma mark - public 

+ (instancetype)cell {
    NSString *className = NSStringFromClass(self);
    className = [className componentsSeparatedByString:@"."].lastObject;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil];
	id cell = [nib objectAtIndex:0];
    return cell;
}

+ (CGFloat)cellDefaultHeight {
    INBasicTableViewCellStats *cellStats = [self cellStats];
    CGFloat height = cellStats.cellHeight;
    return height;
}

+ (NSString *)cellIdentifier {
    INBasicTableViewCellStats *cellStats = [self cellStats];
    NSString *identifier = cellStats.cellIdentifier;
    return identifier;
}

+ (INBasicTableViewCellStats *)cellStats {
    if (__dictINBasicTableViewCellStats == nil) {
        __dictINBasicTableViewCellStats = [NSMutableDictionary dictionary];
    }
    NSString *className = NSStringFromClass(self);
    className = [className componentsSeparatedByString:@"."].lastObject;
    INBasicTableViewCellStats *cellStats = [__dictINBasicTableViewCellStats objectForKey:className];
    if (cellStats == nil) {
        cellStats = [[INBasicTableViewCellStats alloc] init];
        INBasicTableViewCell *cell = [self cell];
        [cellStats setCellHeight:cell.frame.size.height];
        if (cell.reuseIdentifier != nil) {
            [cellStats setCellIdentifier:cell.reuseIdentifier];
        } else {
            // each cell should have set a reuseIdentifier by the nib-file
            // just in case it has not, create a default string for returning
            [cellStats setCellIdentifier:className];
        }
        [__dictINBasicTableViewCellStats setObject:cellStats forKey:className];
    }
    return cellStats;
}

+ (void)registerAtTableView:(UITableView *)tableView {
    NSString *className = NSStringFromClass(self);
    className = [className componentsSeparatedByString:@"."].lastObject;
    [tableView registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:[self cellIdentifier]];
}


@end
