//
//  TrailerViewController.m
//  Flixster
//
//  Created by Hannah Hsu on 6/28/18.
//  Copyright © 2018 Hannah Hsu. All rights reserved.
//

#import "TrailerViewController.h"

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSNumber *trailerId = self.movie[@"id"];
    //NSLog(@"%d", id);
    //int id = 5620579;
    NSString *fullURL = [NSString stringWithFormat:@"%@%@%@", @"https://api.themoviedb.org/3/movie/", trailerId, @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // this chunk is called after network call is finished
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // TODO: Get the array of movies
            NSArray *trailers = dataDictionary[@"results"];
            NSDictionary *movieTrailer = trailers[0];
            
            NSString *baseURLString = @"https://www.youtube.com/watch?v=";
            NSString *keyURLString = movieTrailer[@"key"];
            //NSString *keyURLString = @"SUXWAEX2jlg";
            
            // concantenate the two urls
            NSString *fullKeyURLString = [baseURLString stringByAppendingString:keyURLString];
            NSLog(@"%@", fullKeyURLString);
            
            // make the string into a URL object
            NSURL *trailerURL = [NSURL URLWithString:fullKeyURLString];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:trailerURL];
            [self.webView loadRequest:urlRequest];
        }
    }];
    [task resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
