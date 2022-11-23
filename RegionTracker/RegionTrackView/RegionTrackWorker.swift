//
//  RegionTrackWorker.swift
//  RegionTracker
//
//  Created by Bhabani Shankar on 23/11/22.
//

import Foundation

protocol RegionTrackerWorkLogic {
    func getRegionCoordinates() -> [RegionTrackerModel.CoordinatePoint]
}

class RegionTrackWorker: RegionTrackerWorkLogic {
    
    func getRegionCoordinates() -> [RegionTrackerModel.CoordinatePoint] {
        return [
            .init(lat: 12.953013054035946, lon: 77.5417514266668),
            .init(lat: 12.95428866232216, lon: 77.5438757362066),
            .init(lat: 12.95558517552543, lon: 77.54565672299249),
            .init(lat: 12.956442543452548, lon: 77.54752354046686),
            .init(lat: 12.95675621390793, lon: 77.54919723889215),
            .init(lat: 12.957069883968225, lon: 77.55112842938287),
            .init(lat: 12.957711349517467, lon: 77.55308710458465),
            .init(lat: 12.958464154110917, lon: 77.55514704110809),
            .init(lat: 12.959656090062529, lon: 77.5559409749765),
            .init(lat: 12.960814324441305, lon: 77.5574167738546),
            .init(lat: 12.961253455257907, lon: 77.5592192183126),
            .init(lat: 12.96156308861349, lon: 77.56126500049922),
            .init(lat: 12.961814019848779, lon: 77.56308890262935),
            .init(lat: 12.962775920574138, lon: 77.56592131534907),
            .init(lat: 12.963340512746937, lon: 77.5676379291186),
            .init(lat: 12.96411114676894, lon: 77.56951526792183),
            .init(lat: 12.964382986146292, lon: 77.5717254081501),
            .init(lat: 12.964584624077109, lon: 77.57370388966811),
            .init(lat: 12.964542802687657, lon: 77.57591402989638),
            .init(lat: 12.963795326167373, lon: 77.57798997552734),
            .init(lat: 12.96358621848664, lon: 77.58015720041138),
            .init(lat: 12.963481664580394, lon: 77.58189527185303)
        ]
    }
}
