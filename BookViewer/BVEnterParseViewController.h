//
//  BVEnterParseViewController.h
//  BookViewer
//
//  Created by Air on 6/29/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BVEnterParseViewController : UIViewController

@property (strong, nonatomic) NSString *titleOfBook;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *descriptionOfBook;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSData *imageData;

@end
