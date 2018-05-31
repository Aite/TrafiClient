//
//  StopSchedule.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 29.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class StopSchedule: NSObject {
    var name : String
    var destination : String?
    var departures = [Departure]()

    init(name: String) {
        self.name = name
    }

    convenience init?(json: [String: String]) {
        guard let name = json["Name"] else {
            return nil
        }

        self.init(name: name)
    }
}
