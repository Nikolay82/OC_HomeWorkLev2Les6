//
//  DetailViewController.m
//  NoteBook
//
//  Created by Nikolay on 25.05.15.
//  Copyright (c) 2015 gng. All rights reserved.
//

#import "DetailViewController.h"
#import "CoreData.h"


@interface DetailViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;

@property (weak, nonatomic) IBOutlet UITextField *textFieldAbout;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;


- (IBAction)saveAction:(id)sender;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isNew) {
        
        self.imageView.image = [UIImage imageNamed:@"imgAvatarDef.png"];
        
        self.saveButton.alpha = 1;
        self.textFieldTitle.enabled = YES;
        self.textFieldAbout.enabled = YES;

        
    }
    else {
        
        CoreData * core = [CoreData new];
        
        NSMutableArray * arrayDataArchiver = [core getNSData:@"Notebook" ForKey:@"data"];
        
        NSData * data = [arrayDataArchiver objectAtIndex:self.index];

        NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];

        self.textFieldTitle.text = [dict valueForKey:@"title"];
        self.textFieldAbout.text = [dict valueForKey:@"about"];
        self.imageView.image = [UIImage imageWithData:[dict valueForKey:@"image"]];
        
        self.saveButton.alpha = 0;
        self.textFieldTitle.enabled = NO;
        self.textFieldAbout.enabled = NO;

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAlertwithMessage: (NSString *) message {
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (IBAction)saveAction:(id)sender {
    
    NSData * imageData = UIImagePNGRepresentation(self.imageView.image);
    NSString * textTitle = self.textFieldTitle.text;
    NSString * textAbout = self.textFieldAbout.text;
    
    BOOL enableSave = YES;
    
    if (textTitle.length == 0) {
        
        [self showAlertwithMessage:@"Введите заголовок"];
        
        enableSave = NO;
    }
    else if (textAbout.length == 0) {
        
        [self showAlertwithMessage:@"Введите описание"];
        
        enableSave = NO;
        
    }
    
    if (enableSave) {
        
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               textTitle, @"title",
                               textAbout, @"about",
                               imageData, @"image", nil];
        
        NSData * dataArchiver = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
        CoreData * core = [CoreData new];
        
        [core saveNSData:@"Notebook" Value:dataArchiver Key:@"data"];
        
    }
    
  
}
@end
