//
//  BVBooksTableViewController.m
//  BookViewer
//
//  Created by Air on 6/28/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "BVBooksTableViewController.h"
#import "BVBookTableViewCell.h"
#import "Book.h"
#import "AppDelegate.h"
#import "BVBookViewController.h"

static NSString *const allBooksFetchID = @"fetchBooksID";

@interface BVBooksTableViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *booksSearchBar;
@property (strong, nonatomic) NSMutableArray *filteredBooks;
@property BOOL isFiltered;

@end

@implementation BVBooksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.booksSearchBar.delegate = (id)self;
    self.isFiltered = NO;
    
}

- (NSArray *)resultBooks
{
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSArray *resultBooks = [context executeFetchRequest:fetchRequest error:&error];
    
    return resultBooks;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.isFiltered)
        return [[self resultBooks]count];
    else
        return self.filteredBooks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BVBookTableViewCell *bookCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Book *book;
    
    if (self.isFiltered)
        book = [self.filteredBooks objectAtIndex:indexPath.row];
    else
        book = [[self resultBooks] objectAtIndex:indexPath.row];
    
    bookCell.titleLabel.text = book.title;
    bookCell.authorLabel.text = book.author;
    bookCell.categoryLabel.text = book.category;
    bookCell.book = book;
    
    return bookCell;
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        self.isFiltered = NO;
    }
    else
    {
        self.isFiltered = YES;
        self.filteredBooks = [[NSMutableArray alloc] init];
        
        for (Book *book in [self resultBooks])
        {
            NSRange authorRange = [book.author rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange titleRange = [book.title rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange categoryRange = [book.category rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if(authorRange.location != NSNotFound ||
               titleRange.location != NSNotFound ||
               categoryRange.location != NSNotFound)
                [self.filteredBooks addObject:book];
        }
    }
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    BVBookViewController *bvBookViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"BVBookViewController"];
    
    if (self.isFiltered)
        bvBookViewController.book = [self.filteredBooks objectAtIndex:indexPath.row];
    else
        bvBookViewController.book = [[self resultBooks] objectAtIndex:indexPath.row];
    
    [self presentViewController:bvBookViewController
                       animated:YES
                     completion:nil];

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSError *error = nil;
    
    Book *bookForDelete = [[self resultBooks] objectAtIndex:indexPath.row];
    
    [[(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext] deleteObject: bookForDelete];
    
    if (![[(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext] save:&error]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"error"
                                                            message:@"cant delete"
                                                           delegate:self cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    
}



@end
