//
//  BVBookViewController.m
//  BookViewer
//
//  Created by Air on 6/28/15.
//  Copyright (c) 2015 Air. All rights reserved.
//

#import "BVBookViewController.h"
#import "BVActivityProvider.h"

@interface BVBookViewController ()

@property (weak, nonatomic) IBOutlet UILabel *Author;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation BVBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.Author.text = self.book.author;
    self.bookTitleLabel.text = self.book.title;
    if (self.book.coverImage)
        self.coverImage.image = [UIImage imageWithData:self.book.coverImage];
    else
        self.coverImage.image = [UIImage imageNamed:@"9T4o7EeLc.png"];
    self.descriptionLabel.text = self.book.descriptionOfBook;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareButtonPressed:(id)sender
{
    BVActivityProvider *activityProvider = [[BVActivityProvider alloc] init];
    activityProvider.author = self.Author.text;
    activityProvider.title = self.bookTitleLabel.text;
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[activityProvider] applicationActivities:nil];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard];
    
    [self presentViewController:activityViewController animated:YES completion:nil];

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
