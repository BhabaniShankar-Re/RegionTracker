//
//  RegionTrackInteractor.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import Foundation

protocol RegionTrackerBusinesssLogic {
    func startMonitoringRegions()
    func stopMonitoringRegions()
    func isMonitroingRegion() -> Bool
    func getCurrentStateConfiguration(_ state: RegionTrackerModel.TrackState)
}

class RegionTrackInteractor: RegionTrackerBusinesssLogic, LocationServiceDelegate {
    var presenter: RegionTrackerPresentingLogic?
    var worker: RegionTrackerWorkLogic = RegionTrackWorker()
    
    private var locationService = LocationServices.shared
    private var currentSateConfig: RegionTrackerViewConfiguration = RegionTrackerModel.ViewConfiguration()
    
    init() {
        locationService.delegates = self
    }
    
    func isMonitroingRegion() -> Bool {
        !locationService.getMonitoringRegionIdentifiers().isEmpty
    }
    
    func startMonitoringRegions() {
        let coordinates = worker.getRegionCoordinates()
        coordinates.forEach({
            locationService.startMonitor(latitude: $0.lat, longitude: $0.lon)
        })
        
        updateCurrentStateConfiguartion(.monitoring)
        let response = RegionTrackerModel.MonitoringResponse(isMonitoring: true, viewConfig: currentSateConfig)
        presenter?.presentStartMonitoringRegion(response: response)
    }
    
    func stopMonitoringRegions() {
        locationService.stopMonitoringAllRegion()
        
        updateCurrentStateConfiguartion(.idle)
        let response = RegionTrackerModel.MonitoringResponse(isMonitoring: false, viewConfig: currentSateConfig)
        presenter?.presentStartMonitoringRegion(response: response)
    }
    
    func getCurrentStateConfiguration(_ state: RegionTrackerModel.TrackState) {
        self.updateCurrentStateConfiguartion(state)
        self.presenter?.presentCurrentStateConfiguartion(currentSateConfig)
    }
    
    private func updateCurrentStateConfiguartion(_ state: RegionTrackerModel.TrackState) {
        var viewConfig = RegionTrackerModel.ViewConfiguration()
        
        if state == .unauthorized {
            viewConfig.isOpenSettingButtonHidden = false
            viewConfig.isStopButtonEnable = false
            viewConfig.isStartButtonEnable = false
            viewConfig.message = "Please allow locaton permission for this app"
        } else if state == .idle {
            viewConfig.isOpenSettingButtonHidden = true
            viewConfig.isStopButtonEnable = false
            viewConfig.isStartButtonEnable = true
            viewConfig.message = "Hit start to start monitoring"
        } else {
            viewConfig.isOpenSettingButtonHidden = true
            viewConfig.isStopButtonEnable = true
            viewConfig.isStartButtonEnable = false
            viewConfig.message = "Monitoring..."
        }
        
        currentSateConfig = viewConfig
    }
    
    func didExitRegion(region: String) {
        presenter?.presentExitARegion(region: region)
    }
    
    func didEnterRegion(region: String) {
        presenter?.presentEnterToARegion(region: region)
    }
    
    
}
