//
//  ViewController.swift
//  VoltLinesExercise
//
//  Created by Alaa Al-Zaibak on 25.05.2018.
//  Copyright © 2018 Alaa Al-Zaibak. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class ViewController: UIViewController {

    var mapView : GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        // Levant location
//        let lat = 41.080037
//        let long = 29.008330
//
        // Rio De Janeiro location
        let lat = -22.891144
        let long = -43.225440

        loadGoogleMap(withLatitude: lat, longitude: long)
        loadStops(atLatitude: lat, longitude: long)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods

    /* Loads google map viewing the passed location
     */
    private func loadGoogleMap(withLatitude lat: Double, longitude long: Double) {

        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        view.addSubview(mapView)

        mapView.snp.makeConstraints { (constraintMaker) in
            if #available(iOS 11, *) {
                constraintMaker.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
                constraintMaker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottomMargin)
            } else {
                constraintMaker.top.equalToSuperview()
                constraintMaker.bottom.equalToSuperview()
            }
            constraintMaker.leading.equalToSuperview()
            constraintMaker.trailing.equalToSuperview()
        }
    }

    /* Loads the stops at the location using TrafiAPIManager, and create markers for them on the map.
     * It shows an alert to the user if an error occurred
     */
    private func loadStops(atLatitude lat: Double, longitude long: Double) {
        TrafiAPIManager.default.retreiveStops(atLatitude: lat, longitude: long) { (stopsArray, error) in
            guard error == nil else {
                // Show an alert to the user if an error occurred
                let alert = UIAlertController(title: "Error!", message: "Can't connect to the server, please try again later!", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard let stops = stopsArray else {
                // Do nothing if there are no stops in the array
                return
            }

            for stop in stops {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(
                    latitude: stop.coordinate.latitiude,
                    longitude: stop.coordinate.longitiude
                )
                marker.title = stop.name
                // Add the stop to the marker as user data to be used later if needed
                marker.userData = stop
                marker.map = self.mapView
            }
        }
    }

}

