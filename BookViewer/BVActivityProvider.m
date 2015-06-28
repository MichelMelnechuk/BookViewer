//
//  PRAActivityProcurer.m
//  Phonicle
//
//  Created by Air on 6/10/15.
//  Copyright (c) 2015 Yuriy Berdnikov. All rights reserved.
//

#import "BVActivityProvider.h"

@implementation BVActivityProvider

- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType
{

    NSString *stringForAnother = [NSString stringWithFormat:@"I read now %@ %@", self.author, self.title];
    
    if ([activityType isEqualToString:UIActivityTypePostToTwitter])
    {
        NSString *stringForTwitter = [NSString stringWithFormat:@"I read now %@ %@ for tweet-tweet", self.author, self.title];
        return stringForTwitter;
    }
    else if ([activityType isEqualToString:UIActivityTypeMail])
    {
        NSString *stringForMail = [NSString stringWithFormat:@"I read now %@ %@ for mail", self.author, self.title];;
        [activityViewController setValue:@"BookViewer - who wanna read?" forKey:@"subject"];
        return stringForMail;
    }
    return stringForAnother;
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return @"";
}

@end
