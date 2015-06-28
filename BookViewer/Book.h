//
//  Book.h
//  BookViewer
//
//  Created by Air on 6/28/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSData * coverImage;
@property (nonatomic, retain) NSString * descriptionOfBook;

@end
