//
//  PRAActivityProcurer.h
//  Phonicle
//
//  Created by Air on 6/10/15.
//  Copyright (c) 2015 Yuriy Berdnikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import <UIKit/UIKit.h>


@interface BVActivityProvider : UIActivityItemProvider <UIActivityItemSource>

@property(strong, nonatomic) NSString *author;
@property(strong, nonatomic) NSString *title;

@end
