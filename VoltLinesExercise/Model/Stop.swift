//
//  Stop.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 26.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit

class Stop {
    public var id: String
    public var name: String
    public var coordinate: Coordinate
    public var tooltip : StopTooltip

    init(id: String, name: String, coordinate: Coordinate, tooltip: StopTooltip) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.tooltip = tooltip
    }


    convenience init?(json: [String: Any]) {
        guard let id = json["Id"] as? String else {
            return nil
        }
        guard let coordinateDictionary = json["Coordinate"] as? [String: Double] else {
            return nil
        }
        guard let coordinate = Coordinate(json: coordinateDictionary) else {
            return nil
        }

        let name = (json["Name"] as? String) ?? "Unknown"

        var tooltip : StopTooltip
        if let tooltipDictionary = json["StopTooltip"] as? [String: Any] {
            tooltip = StopTooltip(json: tooltipDictionary)
        }
        else {
            tooltip = StopTooltip(name: name)
        }

        self.init(id: id, name: name, coordinate: coordinate, tooltip: tooltip)
    }
}
