//
//  ViewController.m
//  NoteBook
//
//  Created by Nikolay on 25.05.15.
//  Copyright (c) 2015 gng. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CoreData.h"


@interface ViewController ()

@property (nonatomic, strong) NSArray * arrayTitleNoteBook;

- (IBAction)actionNewDetail:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    
    CoreData * core = [CoreData new];
    
    NSMutableArray * arrayDataArchiver = [core getNSData:@"Notebook" ForKey:@"data"];
    
    NSMutableArray * arrayTitle = [[NSMutableArray alloc] init];
    
    for (NSData * data in arrayDataArchiver) {
        
        NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSString * title = [dict valueForKey:@"title"];
        [arrayTitle addObject:title];
        
    }
    
    self.arrayTitleNoteBook = arrayTitle;
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrayTitleNoteBook.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * idintifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:idintifier];
    
    cell.textLabel.text = [self.arrayTitleNoteBook objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    detail.isNew = NO;
    detail.index = indexPath.row;
    //detail.value = [self.arrayEvents objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
}


- (IBAction)actionNewDetail:(id)sender {
    
    
    DetailViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    detail.isNew = YES;
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
}
@end
