//
//  ViewController.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 22/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let trackView = UIStoryboard(name: "RegionTrackView", bundle: .main).instantiateViewController(withIdentifier: "RegionTrackerViewController") as! RegionTrackerViewController
            trackView.modalTransitionStyle = .crossDissolve
            trackView.modalPresentationStyle = .overCurrentContext
            
            RegionTrackerConfigurator.configure(viewController: trackView)
            
            self.present(trackView, animated: true)
        }
    }


}

