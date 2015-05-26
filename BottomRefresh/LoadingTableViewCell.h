//
//  LoadingTableViewCell.h
//  BottomRefresh
//
//  Created by Robert Ryan on 5/26/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//
//  This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
//  http://creativecommons.org/licenses/by-sa/4.0/

#import <UIKit/UIKit.h>

/** UITableViewCell subclass for "loading" cell
 
 This is a `UITableViewCell` subclass for the cell that shows the "loading" message. 
 The only thing this class is really doing is exposing the `IBOutlet` for the `UIActivityIndicatorView`.
 */

@interface LoadingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end
