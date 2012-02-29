//
//  LocationViewController.m
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-15.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import "LocationViewController.h"
#import "GlobalFunctions.h"
#import "RestaurantClass.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationViewController
@synthesize mapView;
@synthesize imageMap;
@synthesize restaurantLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Location", @"Location");
        self.tabBarItem.image = [UIImage imageNamed:@"07-map-marker"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - location stuff

- (void)removeAllAnnotationsExceptUser
{
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (id <MKAnnotation> myAnnotation in [mapView annotations])
        if (! [myAnnotation isKindOfClass:[ MKUserLocation class]] ) 
            [locations addObject:myAnnotation];
    
    [mapView removeAnnotations:locations];
    
}


- (void)addRestaurantAnnotation
{
    
    [self removeAllAnnotationsExceptUser];
    
    // convert restaurant location to 2D
    CLLocationCoordinate2D restaurantLocation2D;
    restaurantLocation2D.latitude = restaurantLocation.coordinate.latitude;
    restaurantLocation2D.longitude = restaurantLocation.coordinate.longitude;
    
    // add restaurant to map
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = restaurantLocation2D;
    annotationPoint.title = [GlobalFunctions pointTitleForActiveLocation];
    annotationPoint.subtitle = [GlobalFunctions pointSubtitleForActiveLocation];
    [mapView addAnnotation:annotationPoint]; 
        
}

- (void)zoomToIncludeRestaurantAndUser
{
    NSLog(@"zooming...");
    
    // convert restaurant location to 2D
    CLLocationCoordinate2D restaurantLocation2D;
    restaurantLocation2D.latitude = restaurantLocation.coordinate.latitude;
    restaurantLocation2D.longitude = restaurantLocation.coordinate.longitude;
    
    // set distance from restaurant to user
    CLLocationDistance zoomDistance = 1500;
    if (knowUserLocation)
    {
        CLLocation *myUserLocation = [[CLLocation alloc] initWithLatitude:mapView.userLocation.coordinate.latitude 
                                                                longitude:mapView.userLocation.coordinate.longitude];
        zoomDistance = [myUserLocation distanceFromLocation:restaurantLocation] * 2;
        
        // sometimes userLocation is (0,0), I don't know why
        if (mapView.userLocation.coordinate.latitude == 0.0 && mapView.userLocation.coordinate.longitude == 0.0)
            zoomDistance = 1500;

        if (mapView.userLocation.coordinate.latitude == -180.0 && mapView.userLocation.coordinate.longitude == -180.0)
            zoomDistance = 1500;

    }
    
    // center on restaurant, zoom to include user
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(restaurantLocation2D, zoomDistance, zoomDistance);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES]; 
    
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500;
    
    [locationManager startUpdatingLocation];
}


- (void)stopStandardUpdates
{
    [locationManager stopUpdatingHeading];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation (%f, %f)", mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude);
    
    [self stopStandardUpdates];
    
    knowUserLocation = TRUE;
    [self zoomToIncludeRestaurantAndUser];

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // instantiate locationManager
    locationManager = [[CLLocationManager alloc] init];
    
    // default is we don't know nothing
    imageMap.hidden = FALSE;
    knowUserLocation = FALSE;

}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // in case user has changed active location in other tabs
    restaurantLocation = [GlobalFunctions clLocationForActiveLocation];

    // maybe we can connect now, e.g. user turned of Airplane Mode
    // but we don't want to hide a map that loaded and then user lost internet access, so don't turn off as default 
    if ([GlobalFunctions canConnectToInternet])
    {
        imageMap.hidden = TRUE;

        // try to get user location to include user on map 
        if ([CLLocationManager locationServicesEnabled]) 
            [self startStandardUpdates];
    }
        
    [self addRestaurantAnnotation];
    [self zoomToIncludeRestaurantAndUser];
    
}


- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setImageMap:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
