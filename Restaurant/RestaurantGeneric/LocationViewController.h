//
//  LocationViewController.h
//  TheRealJerk
//
//  Created by Eric D'Souza on 12-02-15.
//  Copyright (c) 2012 Eric D'Souza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface LocationViewController : UIViewController<CLLocationManagerDelegate> {

    CLLocationManager *locationManager;
    CLLocation *restaurantLocation;
    BOOL knowUserLocation;
}

@property (readonly, nonatomic) CLLocation *restaurantLocation;

@property (unsafe_unretained, nonatomic) IBOutlet MKMapView *mapView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageMap;

@end
