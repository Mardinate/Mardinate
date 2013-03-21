//
//  MKMapView+ZoomExt.m
//

#import "MKMapView+ZoomExt.h"

@implementation MKMapView (ZoomExt)

- (void)zoomToFitLocations:(NSArray*)locations
                  animated:(BOOL)animated
               edgePadding:(UIEdgeInsets)edgePadding
{
    MKMapRect zoomRect = MKMapRectNull;
    
    for (CLLocation* location in locations)
    {
        MKMapPoint point = MKMapPointForCoordinate(location.coordinate);
        MKMapRect pointRect = MKMapRectMake(point.x, point.y, 0.01, 0.01);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }

    [self setVisibleMapRect:zoomRect edgePadding:edgePadding animated:animated];
}

@end
