import SwiftUI

enum VendorCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case venueRentals = "Venue & Rentals"
    case cateringBar = "Catering & Bar"
    case musicEntertainment = "Music & Entertainment"
    case attireRings = "Attire & Rings"
    case hairMakeup = "Hair & Makeup"
    case stationeryPaper = "Stationery & Paper"
    case transportation = "Transportation"
    case giftsFavors = "Gifts & Favors"
    case ceremonyOfficiant = "Ceremony & Officiant"
    case contingencyMisc = "Contingency & Misc"

    var id: String { rawValue }
}
