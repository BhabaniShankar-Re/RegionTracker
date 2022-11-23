//
//  RegionTrackerConfigurator.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import UIKit


class RegionTrackerConfigurator {
    
    static func configure(viewController: RegionTrackerViewController) {
        let router = RegionTrackRouter()
        let presenter = RegionTrackPresenter()
        let interactor = RegionTrackInteractor()
        
        
        presenter.viewController = viewController
        
        router.viewController = viewController
        
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        viewController.router = router
    }
}


