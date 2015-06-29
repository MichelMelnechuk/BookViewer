//
//  BVEnterParseViewController.m
//  BookViewer
//
//  Created by Air on 6/29/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "BVEnterParseViewController.h"
#import <Parse/Parse.h>
#import "BVUser.h"
#import "AppDelegate.h"

static  NSString *keyForFirstLaunch = @"lNoFirstLaunchKey";

@interface BVEnterParseViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;

@end

@implementation BVEnterParseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveBook:(id)sender {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:keyForFirstLaunch])
    {
        PFObject *user = [[PFObject alloc]initWithClassName:@"BVUser"];
        user[@"name"] = self.loginTextField.text;
        user[@"password"] = self.passwordTextFiled.text;
        [user saveEventually];
        
        NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
        
        Book *book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
        book.title = self.titleOfBook;
        book.author = self.author;
        book.category = self.category;
        book.coverImage = self.imageData;
        book.descriptionOfBook = self.descriptionOfBook;
        
        
        NSMutableArray * locationArray = [NSMutableArray new];
            [locationArray addObject:book];
        NSString * result = [[locationArray valueForKey:@"description"] componentsJoinedByString:@""];

        
        user[@"books"] = result;
        
        [user saveEventually];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:keyForFirstLaunch];
        
    }
    else
    {
        PFObject *retUser = [[PFObject alloc]initWithClassName:@"BVUser"];
        
        if ([retUser[@"name"] isEqualToString:self.loginTextField.text] ||
            [retUser[@"password"] isEqualToString:self.passwordTextFiled.text])
        {
            PFObject *user = [[PFObject alloc]initWithClassName:@"BVUser"];
            NSMutableArray *books = user[@"books"];
            Book *book;
            book.title = self.titleOfBook;
            book.author = self.author;
            book.category = self.category;
            book.coverImage = self.imageData;
            book.descriptionOfBook = self.descriptionOfBook;
            
            [books addObject:book];
            
            user[@"books"] = book;
            
            [user saveEventually];

        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
