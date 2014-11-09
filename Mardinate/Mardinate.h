#ifndef Mardinate_h
#define Mardinate_h

#if __cplusplus
extern "C"
{
#endif

void MardinateConvertWGS84Coordinate(double wLatitude, double wLongitude, double* mLatitude, double* mLongitude);

void MardinateAddOffset(double wLatitude, double wLongitude, double* mLatitude, double* mLongitude);

#if __cplusplus
}
#endif

#endif
