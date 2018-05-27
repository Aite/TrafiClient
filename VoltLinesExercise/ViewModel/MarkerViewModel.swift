//
//  MarkerViewModel.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 27.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import GoogleMaps

class MarkerViewModel: NSObject {

    /* Holds the marker id (which will be the same as stop id).
     */
    private(set) var id : String!

    /* Holds the marker title.
     */
    private(set) var title : String!

    /* Holds the marker position (latitude & longitude).
     */
    private(set) var position : CLLocationCoordinate2D!

    /* Holds the stop that is represented by marker on the map,
     * when the stop is set the stop properties will initialize the other properties of this class.
     */
    private(set) var stop : Stop {
        didSet {
            initializeProperties()
        }
    }

    init(withStop stop: Stop) {
        self.stop = stop
        super.init()
        self.initializeProperties()
    }

    private func initializeProperties() {
        self.id = stop.id
        self.title = stop.name
        self.position = CLLocationCoordinate2D(
            latitude: stop.coordinate.latitiude,
            longitude: stop.coordinate.longitiude
        )
    }

}
