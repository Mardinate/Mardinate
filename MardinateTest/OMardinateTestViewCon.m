//
//  OMardinateTestViewCon.m
//  MardinateTest
//

#import "OMardinateTestViewCon.h"
#import "OMardinate.h"
#import "MKMapView+ZoomExt.h"

@interface OMardinateTestViewCon ()
{
    IBOutlet MKMapView* _mapView;
    IBOutlet UILabel* _differenceLabel;
    IBOutlet UILabel* _accuracyLabel;
    IBOutlet UILabel* _latitudeLabel;
    IBOutlet UILabel* _longitudeLabel;

    CLLocationManager* _locationManager;

    MKPointAnnotation* _wgs84Anno;
    MKPointAnnotation* _mardinateAnno;

    CLLocationCoordinate2D _lastWGS84Coordinate;
    CLLocationCoordinate2D _lastMardinateCalculated;
    CLLocationCoordinate2D _lastMardinateMapKit;

    BOOL _zoomed;
}

@end

@implementation OMardinateTestViewCon

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    _mapView.delegate = self;

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_locationManager startUpdatingLocation];
    _mapView.showsUserLocation = YES;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation* location = [locations lastObject];

    _lastWGS84Coordinate = location.coordinate;

    _lastMardinateCalculated = [OMardinate convertWGS84Coordinate:_lastWGS84Coordinate];

    if (_wgs84Anno == nil)
    {
        _wgs84Anno = [[MKPointAnnotation alloc] init];
        _mardinateAnno = [[MKPointAnnotation alloc] init];

        _wgs84Anno.title = @"WGS84 Coordinate";
        _mardinateAnno.title = @"Mardinate";

        [_mapView addAnnotation:_wgs84Anno];
        [_mapView addAnnotation:_mardinateAnno];
    }

    _wgs84Anno.coordinate = _lastWGS84Coordinate;
    _mardinateAnno.coordinate = _lastMardinateCalculated;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation class] == MKUserLocation.class)
    {
        return nil;
    }

    MKPinAnnotationView* annoView = (MKPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"Anno"];
    if (annoView == nil)
    {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Anno"];
        annoView.canShowCallout = YES;
    }

    if (annotation == _wgs84Anno)
    {
        annoView.pinColor = MKPinAnnotationColorRed;
    }
    else
    {
        annoView.pinColor = MKPinAnnotationColorGreen;
    }

    return annoView;
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    _zoomed = NO;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _lastMardinateMapKit = userLocation.coordinate;
    [self locationChangeUpdate];
}

- (void)locationChangeUpdate
{
    CLLocation* locationA = [[CLLocation alloc] initWithLatitude:_lastMardinateMapKit.latitude
                                                       longitude:_lastMardinateMapKit.longitude];

    CLLocation* locationB = [[CLLocation alloc] initWithLatitude:_lastMardinateCalculated.latitude
                                                       longitude:_lastMardinateCalculated.longitude];

    CLLocationDistance distance = [locationA distanceFromLocation:locationB];

    _differenceLabel.text = [NSString stringWithFormat:@"Diff with MapKit - %2.2f meters.", distance];
    _accuracyLabel.text = [NSString stringWithFormat:@"Location Accuracy - %2.2f meters.", _mapView.userLocation.location.horizontalAccuracy];
    _latitudeLabel.text = [NSString stringWithFormat:@"Latitude - %2.5f.", _lastWGS84Coordinate.latitude];
    _longitudeLabel.text = [NSString stringWithFormat:@"Longitude - %2.5f.", _lastWGS84Coordinate.longitude];

    if (!_zoomed)
    {
        NSArray* pinLocations = @[locationA, locationB, [[CLLocation alloc] initWithLatitude:_lastWGS84Coordinate.latitude
                                                                                longitude:_lastWGS84Coordinate.longitude]];

        [_mapView zoomToFitLocations:pinLocations
                            animated:YES
                         edgePadding:UIEdgeInsetsMake(150, 50, 50, 50)];
        _zoomed = YES;
    }
}

@end
