//
//  LocationManager.swift
//  IOS_25B_HW1&2
//
//  Created by Student21 on 20/05/2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLongitude: Double? = nil

    override init() {
        super.init()
        manager.delegate = self
        print("📡 LocationManager initialized – requesting location access")

        manager.requestWhenInUseAuthorization()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            print("📍 Starting location updates...")
            self.manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            print("⚠️ No location data received")
            return
        }

        let long = location.coordinate.longitude
        print("📍 Location received: longitude = \(long)")

        DispatchQueue.main.async {
            self.userLongitude = long
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Failed to get location: \(error.localizedDescription)")
    }
}
