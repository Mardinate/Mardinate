//
//  MKMapView+ZoomExt.h
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomExt)

- (void)zoomToFitLocations:(NSArray*)locations
                  animated:(BOOL)animated
               edgePadding:(UIEdgeInsets)edgePadding;

@end
