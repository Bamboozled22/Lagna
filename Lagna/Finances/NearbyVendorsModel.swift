import CoreLocation
import MapKit
import SwiftUI

struct NearbyVendor: Identifiable {
    var id: String
    var name: String
    var address: String
    var distance: String
}

@Observable
final class NearbyVendorsModel {
    var placeLabel = "Locating…"
    var vendors: [NearbyVendor] = []

    private let locationManager = CLLocationManager()
    private var userLocation: CLLocation?

    func startLocating() async {
        locationManager.requestWhenInUseAuthorization()

        let status = locationManager.authorizationStatus
        if status == .denied || status == .restricted {
            placeLabel = "Location off"
            return
        }

        do {
            for try await update in CLLocationUpdate.liveUpdates() {
                guard let location = update.location, location.horizontalAccuracy > 0 else { continue }
                userLocation = location
                await updatePlaceLabel(from: location)
                break
            }
        } catch {
            placeLabel = "Location off"
        }
    }

    func search(text: String, category: VendorCategory) async {
        guard let userLocation else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = Self.query(text: text, category: category)
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(
            center: userLocation.coordinate,
            latitudinalMeters: 20_000,
            longitudinalMeters: 20_000
        )

        do {
            let response = try await MKLocalSearch(request: request).start()
            vendors = response.mapItems.prefix(8).compactMap { item in
                vendor(from: item, relativeTo: userLocation)
            }
        } catch {
            vendors = []
        }
    }

    private static func query(text: String, category: VendorCategory) -> String {
        let typed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !typed.isEmpty { return typed }
        if category != .all { return category.rawValue }
        return "wedding"
    }

    private func updatePlaceLabel(from location: CLLocation) async {
        guard let request = MKReverseGeocodingRequest(location: location) else { return }
        do {
            guard let item = try await request.mapItems.first else { return }
            let city = item.placemark.locality
            let region = item.placemark.administrativeArea
            if let city, let region {
                placeLabel = "\(city), \(region)"
            } else if let city {
                placeLabel = city
            }
        } catch {
            placeLabel = "Current location"
        }
    }

    private func vendor(from item: MKMapItem, relativeTo origin: CLLocation) -> NearbyVendor? {
        guard let name = item.name, !name.isEmpty else { return nil }
        let coordinate = item.placemark.coordinate
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return NearbyVendor(
            id: "\(name)-\(coordinate.latitude)-\(coordinate.longitude)",
            name: name,
            address: addressLine(for: item),
            distance: Self.distanceLabel(from: origin, to: destination)
        )
    }

    private func addressLine(for item: MKMapItem) -> String {
        let placemark = item.placemark
        let street = [placemark.subThoroughfare, placemark.thoroughfare]
            .compactMap { $0 }
            .joined(separator: " ")
        let cityState = [placemark.locality, placemark.administrativeArea]
            .compactMap { $0 }
            .joined(separator: ", ")
        let line = [street, cityState].filter { !$0.isEmpty }.joined(separator: ", ")
        return line.isEmpty ? (item.name ?? "") : line
    }

    private static func distanceLabel(from origin: CLLocation, to destination: CLLocation) -> String {
        let miles = origin.distance(from: destination) / 1609.344
        if miles < 0.1 { return "<0.1 mi" }
        if miles < 10 { return String(format: "%.1f mi", miles) }
        return String(format: "%.0f mi", miles)
    }
}
