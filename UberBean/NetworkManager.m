//
//  NetworkManager.m
//  UberBean
//
//  Created by Nathan Wainwright on 2018-09-02.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import "NetworkManager.h"
#import "Cafe.h"

@interface NetworkManager ()

@property (nonatomic, strong) NSMutableArray <Cafe*> *cafeArray;

@end


@implementation NetworkManager




- (void)getDataFromUrlAndParse {
  self.cafeArray = [[NSMutableArray alloc] init];
  
  float latitude = 49.2812;
  float longitude = -123.1170317;
  
  // 1
  NSString *dataUrl = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%f&longitude=%f", latitude, longitude];
  NSURL *url = [NSURL URLWithString:dataUrl];
  
  NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url]; // 2
  [urlRequest addValue:@"Bearer orWKEHfVmwcWFoxveGWcL6nKQF5Pdf2sFf2GyRfvQMbK9aFG0-bM3esET24G_UrfMlI0kd4n_WMT7Q_o2mXdyAU7mcaqbbuIYgAsrWHW_M3jhzLurQdiAbsUMIWMW3Yx" forHTTPHeaderField:@"Authorization"];
  
  // [urlRequest addValue:@"Bearer your_api_key" forHTTPHeaderField:@"Authorization"];

  //
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; //
  //MARK: is above line needed?
  
  // 2
  NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          // 4: Handle response here
                                          if (error) { // 1
                                            // Handle the error
                                            NSLog(@"error: %@", error.localizedDescription);
                                            return;
                                          }
                                          NSError *jsonError = nil;
                                          NSDictionary *yelpDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                          
                                          if (jsonError) { // 3
                                            // Handle the error
                                            NSLog(@"jsonError: %@", jsonError.localizedDescription);
                                            return;
                                          }
                                          NSArray* businesses = yelpDictionary[@"businesses"];
                                          // If we reach this point, we have successfully retrieved the JSON from the API
                                          for (NSDictionary *business in businesses){ // 4
                                            Cafe *cafe = [[Cafe alloc] init];
                                            cafe.placeName = business[@"name"];
                                            cafe.imageUrl = business[@"image_url"]; //the easy ones
                                            cafe.locLongitude = business[@"longitude"];
                                            cafe.locLatitude = business[@"latitude"]; //a little deeper for coordinates
                                            [self.cafeArray addObject:cafe]; //add it
                                            NSLog(@"CAFE NAME: %@", cafe.placeName);
                                          }
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                                              [self.UITableView reloadData];
                                            
                                            
                                          }];
                                        }];
  
  // 3
  [dataTask resume];
  //  NSLog(@"CAFE MASS PRINT: %@", self.cafeArray);
  
  
}









@end
