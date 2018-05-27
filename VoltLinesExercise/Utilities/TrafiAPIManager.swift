//
//  TrafiAPIManager.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 27.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import Moya

class TrafiAPIManager: NSObject {
    /* olds the singleton instance.
     */
    fileprivate static var instance = TrafiAPIManager()

    /* Returns the default singleton instance.
     */
    open class var `default`: TrafiAPIManager {
        get {
            return instance
        }
    }

    /* Holds Moya provider instance for TrafiAPI.
     */
    fileprivate let provider = MoyaProvider<TrafiAPI>()

    /* Gets the stops info at the location using TrafiAPI, create Stop instances, and send them in the completion block to the caller in array.
     * If an error occurred it will be returned in the parameter `error` and the parameter `stops` will be nil
     */
    public func retreiveStops(atLatitude lat: Double, longitude long: Double, _ completion: @escaping (_ stops: [Stop]?, _ error: Error?) -> Void) {
        provider.request(.nearbyStops(latitiude: lat, longitiude: long)) { result in

            switch result {
            case let .success(moyaResponse):
                do {
                    _ = try moyaResponse.filterSuccessfulStatusCodes()
                    let json = try moyaResponse.mapJSON()

                    var stops = [Stop]()
                    if let json = json as? [String: Any] {
                        if let rawStops = json["Stops"] as? [[String: Any]] {
                            var stopIds = [String]()
                            for rawStop in rawStops {
                                if let stop = Stop(json: rawStop) {
                                    guard !stopIds.contains(stop.id) else {
                                        continue
                                    }
                                    stopIds.append(stop.id)
                                    stops.append(stop)
                                }
                            }
                        }
                    }
                    completion(stops, nil)
                }
                catch let error {
                    // show an error to your user
                    print(error)
                    completion(nil, error)
                }

            case let .failure(error):
                print(error)
                completion(nil, error)

            }
        }
    }
}
