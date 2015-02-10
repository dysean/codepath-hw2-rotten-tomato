//
//  MoviesViewController.m
//  Rotten Tomato
//
//  Created by Sean Dy on 2/3/15.
//  Copyright (c) 2015 Sean Dy. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"
#import "SVProgressHUD.h"


@interface MoviesViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITabBar *requestTabBar;
@end



@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 150;
    
    self.errorLabel.hidden = TRUE;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    UINib *cell = [UINib nibWithNibName:@"MovieTableViewCell" bundle:nil];
    [self.tableView registerNib:cell forCellReuseIdentifier:@"MovieTableViewCell"];
    [SVProgressHUD show];
    //because we already have the spinner for other refreshes
    [self getMovieData];
    

}

- (void)getMovieData {
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dfwcfhd24mzj8nvavmr4n8w7"];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
        queue:[NSOperationQueue mainQueue]
        completionHandler:^(NSURLResponse *response,
        NSData *data,
        NSError *connectionError) {
            NSLog(@"%@",connectionError);
            //ew, I know
            if (connectionError == nil) {
                NSLog(@"connectionError is nil");
                NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                self.movies = dataDict[@"movies"];
                [SVProgressHUD dismiss];
                self.errorLabel.hidden = TRUE;
            } else {
            NSLog(@"else");
            self.errorLabel.hidden = FALSE;
            }
        [self.tableView reloadData];
    }];
    
}

- (void)onRefresh {
    [self getMovieData];
    self.errorLabel.hidden = TRUE;
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSURL *imgURL = [self getOriURL:movie[@"posters"][@"thumbnail"]];
    
    [cell.posterView setImageWithURL:imgURL];

    NSLog(@"row: %ld section: %ld", indexPath.row, indexPath.section);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController *controller = [[MovieDetailsViewController alloc] init];
    NSLog(@"Here");
    controller.movie = self.movies[indexPath.row];

    controller.img = [self getOriURL:self.movies[indexPath.row][@"posters"][@"thumbnail"]];
    controller.title = self.movies[indexPath.row][@"title"];
    [self.navigationController pushViewController:controller animated:YES];
}


-(NSURL *) getOriURL:(NSString *) url {
    NSString *orig_img_url = [NSString stringWithFormat:@"%@%@",[url substringToIndex:url.length -7],@"ori.jpg"];
    NSURL *imgURL = [NSURL URLWithString:orig_img_url];
    return imgURL;
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
