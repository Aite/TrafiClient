//
//  Departure.swift
//  TrafiClient
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class Departure: NSObject {
    var remainingMinutes : Int
    var destination : String

    init(remainingMinutes: Int, destination: String) {
        self.remainingMinutes = remainingMinutes
        self.destination = destination
    }

    convenience init?(json: [String: Any]) {
        guard let remainingMinutes = json["RemainingMinutes"] as? Int else {
            return nil
        }
        guard let destination = json["Destination"] as? String else {
            return nil
        }

        self.init(remainingMinutes: remainingMinutes, destination: destination)
    }
}
