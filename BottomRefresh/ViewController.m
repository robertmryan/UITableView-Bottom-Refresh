//
//  ViewController.m
//  BottomRefresh
//
//  Created by Robert Ryan on 5/26/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//
//  This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
//  http://creativecommons.org/licenses/by-sa/4.0/

#import "ViewController.h"
#import "LoadingTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *objects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.objects = [NSMutableArray array];
    
    [self addSomeObjects];
}

#pragma mark - UITableViewDataSource

// add one for the "loading" cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count + 1;
}

// if within the range of model, return cell with model object in it, otherwise show "loading" cell.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStandardIdentifier = @"Cell";
    static NSString *cellLoadingIdentifier = @"Loading";
    
    if (indexPath.row < self.objects.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStandardIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.objects[indexPath.row];
        return cell;
    } else {
        LoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLoadingIdentifier forIndexPath:indexPath];
        [cell.activityIndicatorView startAnimating];
        
        [self fetchMoreData];

        return cell;
    }
}

#pragma mark - Data Fetching 

/** Fetch more data.
 
 Simulate network request fetching more data. When done, it will reload the tableview.
 */
- (void)fetchMoreData {
    static BOOL fetchInProgress = FALSE;
    
    if (fetchInProgress)
        return;
    
    typeof(self) __weak weakSelf = self;
    
    fetchInProgress = TRUE;

    // this simulates a background fetch; I'm just going to delay for a second
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            NSArray *indexPaths = [strongSelf addSomeObjects];
            [strongSelf.tableView beginUpdates];
            [strongSelf.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            fetchInProgress = FALSE;
            [strongSelf.tableView endUpdates];
        }
    });
}

/** Add some objects to our model.
 
 This simulates the retrieval of 20 more items from our data source. This adds the objects to our model 
 returns an array of `NSIndexPath objects that we can use to refresh our table view.
 
 @return An array of `NSIndexPath` objects.
 */

- (NSArray *)addSomeObjects {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i++) {
        [self.objects addObject:[formatter stringFromNumber:@([self.objects count] + 1)]];
        [indexPaths addObject:[NSIndexPath indexPathForRow:self.objects.count - 1 inSection:0]];
    }
    
    return indexPaths;
}


@end
