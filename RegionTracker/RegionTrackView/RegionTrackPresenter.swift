//
//  RegiionTrackPresenter.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import Foundation

protocol RegionTrackerPresentingLogic {
    func presentCurrentStateConfiguartion(_ config: RegionTrackerViewConfiguration)
    func presentStartMonitoringRegion(response: RegionTrackerModel.MonitoringResponse)
    func presentStopMonitoringRegion(response: RegionTrackerModel.MonitoringResponse)
    func presentEnterToARegion(region: String)
    func presentExitARegion(region: String)
}

class RegionTrackPresenter: RegionTrackerPresentingLogic {
    weak var viewController: RegionTrackerDisplayLogic?
    
    
    func presentCurrentStateConfiguartion(_ config: RegionTrackerViewConfiguration) {
        DispatchQueue.main.async {
            self.viewController?.applyCurrentStateConfiguration(config: config)
        }
    }
    func presentStartMonitoringRegion(response: RegionTrackerModel.MonitoringResponse) {
        DispatchQueue.main.async {
            self.viewController?.didStartMonitoringRegion(response: response)
        }
    }
    func presentStopMonitoringRegion(response: RegionTrackerModel.MonitoringResponse) {
        DispatchQueue.main.async {
            self.viewController?.didStopMonitoringRegion(response: response)
        }
    }
    func presentEnterToARegion(region: String) {
        DispatchQueue.main.async {
            self.viewController?.didEnterToARegion(region: region)
        }
    }
    func presentExitARegion(region: String) {
        DispatchQueue.main.async {
            self.viewController?.didExitARegion(region: region)
        }
    }
}
