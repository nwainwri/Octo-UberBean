//
//  ViewController.m
//  UberBean
//
//  Created by Nathan Wainwright on 2018-09-01.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import "ViewController.h"
//#import <MapKit/MapKit.h> //imports mapkit, need this for displaying map
//#import <CoreLocation/CoreLocation.h> //imports corelocation, need this to get location of phone.
@import CoreLocation;
@import MapKit;
#import "MyAnnotation.h"

@interface ViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

//@property (strong, nonatomic) MKMapView *mapView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation ViewController





- (void)viewDidLoad {
  [super viewDidLoad];
  //  self.mapView.showsUserLocation = YES;
  
  //  sets up location manager properly, setting desired accuuracy boundaries, distant, and settine delegate for it.
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
  self.locationManager.distanceFilter = 20;
  self.locationManager.delegate = self;
  
  //************
  //
  // MARK: I WANT TO KNOW HOW TO ADD PROGRAMMATICALLY
  //
  //************
//  MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
//  [self.view addSubview:mapView];
  
  
  
  [self.locationManager requestWhenInUseAuthorization];
  
  //setups view to have a map, covering entire screen
  self.mapView.delegate = self;
  self.mapView.showsUserLocation = YES;
  self.mapView.showsPointsOfInterest = YES;
  self.mapView.mapType = MKMapTypeStandard; //MKMapTypeHybridFlyover;
  

  
  //  [self.mapView registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"myAnnotation"];
  //
  //  MyAnnotation *annotation = [[MyAnnotation alloc] init];
  //  annotation.title = @"Something weird here";
  //  annotation.subtitle = @"I dunno what";
  //  annotation.coordinate = CLLocationCoordinate2DMake(40.6892656, -74.0466891);
  //
  //  [self.mapView addAnnotation:annotation];
  
  // got an ERROR: 2018-09-02 14:54:42.619316-0700 UberBean[1088:33226] **** Manager failed: The operation couldn’t be completed. (kCLErrorDomain error 0.)
  
  
}

// MARK: - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  NSLog(@"**** Authorization status: %d", status);
  if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
    [manager startUpdatingLocation];
  }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
  NSLog(@"**** Manager failed: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
  NSLog(@"**** Updated locations %@", locations);
  CLLocation *loc = locations[0];
  [self.mapView setRegion:MKCoordinateRegionMake(loc.coordinate,
                                                 MKCoordinateSpanMake(0.03, 0.03))
                 animated:YES];
}

// MARK: - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation
{
  if ([annotation isKindOfClass:[MyAnnotation class]]) {
    MKMarkerAnnotationView *marker = (MKMarkerAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myAnnotation" forAnnotation:annotation];
    
    marker.markerTintColor = [UIColor purpleColor];
    marker.glyphText = annotation.title;
    marker.titleVisibility = MKFeatureVisibilityVisible;
    marker.animatesWhenAdded = YES;
    
    return marker;
  }
  
  return nil;
}

@end

