//
//  LocationServices.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didEnterRegion(region: String)
    func didExitRegion(region: String)
}


class LocationServices: NSObject {
    private (set) static var shared: LocationServices = LocationServices()
    
    private var locationManager: CLLocationManager = .init()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    weak var delegates: LocationServiceDelegate?
    
    func startMonitor(latitude: Double, longitude: Double, radius: Double = 100.0, identifier: String = UUID().uuidString) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoringAllRegion() {
        let regions = locationManager.monitoredRegions
        print(regions)
        regions.forEach({ locationManager.stopMonitoring(for: $0)})
    }
    
    func getMonitoringRegionIdentifiers() -> [String] {
        locationManager.monitoredRegions.map({ $0.identifier })
    }
}

extension LocationServices: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let clregion = region as? CLCircularRegion else { return print("\(region.identifier) is not a circular region")}
        print("entry - ",region)
        let strRegion = "lat - \(clregion.center.latitude)\nlon - \(clregion.center.longitude)"
        delegates?.didEnterRegion(region: strRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard let clregion = region as? CLCircularRegion else { return print("\(region.identifier) is not a circular region")}
        print("exit - ",region)
        let strRegion = "lat - \(clregion.center.latitude)\nlon - \(clregion.center.longitude)"
        delegates?.didExitRegion(region: strRegion)
    }
}
