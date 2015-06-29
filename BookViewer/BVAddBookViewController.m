//
//  BVAddBookViewController.m
//  BookViewer
//
//  Created by Air on 6/28/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "BVAddBookViewController.h"
#import "AppDelegate.h"
#import "Book.h"
#import <Parse/Parse.h>
#import "BVEnterParseViewController.h"
#import "BVEnterParseViewController.h"


@interface BVAddBookViewController () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextView *descpritionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *BookCover;
@property (strong, nonatomic)  UIImage *pickingImage;

@end

@implementation BVAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.BookCover setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)uploadCoverPressed:(id)sender {
        [self.BookCover setHidden:NO];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.pickingImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.BookCover.image = self.pickingImage;
}

- (IBAction)saveButtonPressed:(id)sender
{
    if ([self.titleTextField.text isEqual:@""] ||
        [self.authorTextField.text isEqual:@""] ||
        [self.categoryTextField.text isEqual:@""] ||
        [self.descpritionTextView.text isEqual:@""] ||
        !self.pickingImage)
    {
        UIAlertView *saveCDAlertView  = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Empty filed"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [saveCDAlertView show];
        
        return;
    }
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    Book *newBook = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:context];
    
    if (newBook)
    {
        newBook.title = self.titleTextField.text;
        newBook.author = self.authorTextField.text;
        newBook.category = self.categoryTextField.text;
        newBook.descriptionOfBook = self.descpritionTextView.text;
        newBook.coverImage = UIImagePNGRepresentation(self.pickingImage);
    }
    
    NSError *savingError = nil;
    
    if (![context save:&savingError])
    {
        UIAlertView *saveCDAlertView  = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Cant save book"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [saveCDAlertView show];
    }
    else
    {
        [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext];
        [self performSegueWithIdentifier:@"saveIsSucces" sender:self];
    }
}
- (IBAction)saveWithParsePressed:(id)sender
{
    if ([self.titleTextField.text isEqual:@""] ||
        [self.authorTextField.text isEqual:@""] ||
        [self.categoryTextField.text isEqual:@""] ||
        [self.descpritionTextView.text isEqual:@""] ||
        !self.pickingImage)
    {
        UIAlertView *saveCDAlertView  = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:@"Empty filed"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [saveCDAlertView show];
        
        return;
    }
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    BVEnterParseViewController *bvEnterBookViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"BVEnterParseViewController"];
    
    bvEnterBookViewController.titleOfBook = self.titleTextField.text;
    bvEnterBookViewController.author = self.authorTextField.text;
    bvEnterBookViewController.category = self.categoryTextField.text;
    bvEnterBookViewController.descriptionOfBook = self.descpritionTextView.text;
    bvEnterBookViewController.imageData = UIImagePNGRepresentation(self.pickingImage);
    
    [self presentViewController:bvEnterBookViewController
                       animated:YES
                     completion:nil];
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
