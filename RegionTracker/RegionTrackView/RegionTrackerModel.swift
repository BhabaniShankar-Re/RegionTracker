//
//  RegionTrackerModel.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import Foundation


struct RegionTrackerModel {
    enum TrackState {
        case unauthorized, monitoring, idle
        
    }
    
    struct MonitoringResponse {
        var isMonitoring: Bool
        var viewConfig: RegionTrackerViewConfiguration
    }
    
    struct CoordinatePoint {
        var lat: Double
        var lon: Double
    }
    
    struct ViewConfiguration: RegionTrackerViewConfiguration {
        var message: String = ""
        
        var isStopButtonEnable: Bool = false
        var isStartButtonEnable: Bool = true
        var isOpenSettingButtonHidden: Bool = true
    }
}
