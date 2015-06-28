//
//  BVBookTableViewCell.h
//  BookViewer
//
//  Created by Air on 6/28/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BVBookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong) Book *book;

@end
