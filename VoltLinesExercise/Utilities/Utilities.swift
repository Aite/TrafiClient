//
//  Utilities.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 28.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import GoogleMaps

class Utilities: NSObject {
    /* Holds the singleton instance.
     */
    private static var instance = Utilities()

    /* Returns the default singleton instance.
     */
    open class var `default`: Utilities {
        get {
            return instance
        }
    }

    public func getDistanceMetresBetweenLocationCoordinates(_ coordinates1: CLLocationCoordinate2D, _ coordinates2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coordinates1.latitude, longitude: coordinates1.longitude)
        let location2 = CLLocation(latitude: coordinates2.latitude, longitude: coordinates2.longitude)

        return location1.distance(from: location2)
    }
}
