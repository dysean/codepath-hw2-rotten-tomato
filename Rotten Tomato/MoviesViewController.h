//
//  MoviesViewController.h
//  Rotten Tomato
//
//  Created by Sean Dy on 2/3/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *movieTableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
-(NSURL *) getOriURL:(NSString*) url;
@end