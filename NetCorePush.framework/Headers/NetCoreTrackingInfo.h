#ifndef NetCoreTrackingInfo_h
#define NetCoreTrackingInfo_h

enum AppTrackingEvents {
    tracking_AppExit        = 6,
    tracking_FirstLaunch    = 20,
    tracking_AppLaunch      = 21,
    tracking_AppUnInstall   = 24,
    tracking_AppUpdate      = 81,
    tracking_AppReinstall   = 83
};

enum AdFrequencyCapping {
    freq_session,
    freq_day,
    freq_campaign
};

/**
 @brief NCEventStatus is an enum to know events status.
 */
typedef NS_ENUM(NSUInteger, NCEventStatus) {
    NCEventStatusSuccess    = 1,
    NCEventStatusFailed     = 2
};

#endif /* NetCoreTrackingInfo_h */
