//
//  RegionTrackViewController.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import UIKit
import PermissionsKit
import LocationAlwaysPermission

protocol RegionTrackerDisplayLogic: AnyObject {
    func didStartMonitoringRegion(response: RegionTrackerModel.MonitoringResponse)
    func didStopMonitoringRegion(response: RegionTrackerModel.MonitoringResponse)
    func didEnterToARegion(region: String)
    func didExitARegion(region: String)
    func applyCurrentStateConfiguration(config: RegionTrackerViewConfiguration)
}

protocol RegionTrackerViewConfiguration {
    var message: String { get }
    var isStartButtonEnable: Bool { get }
    var isStopButtonEnable: Bool { get }
    var isOpenSettingButtonHidden: Bool { get }
}

class RegionTrackerViewController: UIViewController, RegionTrackerDisplayLogic {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var openSettingBtn: UIButton!
    
    @IBOutlet weak var enteredRegView: UIView!
    @IBOutlet weak var exitRegView: UIView!
    @IBOutlet weak var enteredRegionLabel: UILabel!
    @IBOutlet weak var exitRegionLabel: UILabel!
    
    var interactor: RegionTrackerBusinesssLogic?
    var router: RegionTrackerRoutingLogic?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationAlwaysPermission.locationAlways.request {
            self.checkCurrentState()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkCurrentState()
    }
    
    
    
    private func checkCurrentState() {
        let status = Permission.locationAlways.status
        if status == .authorized, let isMonitoring = interactor?.isMonitroingRegion() {
            interactor?.getCurrentStateConfiguration(isMonitoring ? .monitoring : .idle)
        } else {
            interactor?.getCurrentStateConfiguration(.unauthorized)
        }
    }
    
    func applyCurrentStateConfiguration(config: RegionTrackerViewConfiguration) {
        enteredRegionLabel.text = ""
        exitRegionLabel.text = ""
        messageLabel.text = config.message
        openSettingBtn.isHidden = config.isOpenSettingButtonHidden
        startButton.isEnabled = config.isStartButtonEnable
        stopButton.isEnabled = config.isStopButtonEnable
    }
    
    
    
    @IBAction func stopMonitoring(_ sender: UIButton) {
        interactor?.stopMonitoringRegions()
        
    }
    
    @IBAction func startMonitoring(_ sender: UIButton) {
        interactor?.startMonitoringRegions()
    }
    
    @IBAction func openSettingApp(_ sender: UIButton) {
        Permission.locationAlways.openSettingPage()
    }
    

    
    func didStopMonitoringRegion(response: RegionTrackerModel.MonitoringResponse) {
        self.applyCurrentStateConfiguration(config: response.viewConfig)
    }
    
    func didStartMonitoringRegion(response: RegionTrackerModel.MonitoringResponse) {
        self.applyCurrentStateConfiguration(config: response.viewConfig)
    }
    
    func didEnterToARegion(region: String) {
        self.enteredRegionLabel.text = region
    }
    
    func didExitARegion(region: String) {
        self.exitRegionLabel.text = region
    }
}

