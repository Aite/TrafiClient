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
    public var direction: String
    public var coordinate: Coordinate
    public var iconUrl: String

    init(id: String, name: String?, direction: String?, iconUrl: String?, coordinate: Coordinate) {
        self.id = id
        self.name = name ?? "Unknown"
        self.direction = direction ?? ""
        self.iconUrl = iconUrl ?? ""
        self.coordinate = coordinate
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

        let name = json["Name"] as? String
        let direction = json["Direction"] as? String
        let iconUrl = json["IconUrl"] as? String

        self.init(id: id, name: name, direction: direction, iconUrl: iconUrl, coordinate: coordinate)
    }
}
