import SwiftUI

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct WPAdaptiveColor: ShapeStyle {
    var light: Color
    var dark: Color

    func resolved(_ colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? dark : light
    }

    func resolve(in environment: EnvironmentValues) -> Color {
        resolved(environment.colorScheme)
    }
}

enum WPColor {
    enum Surface {
        /// Frame `543:36455` Light `#F4F4F4`. Dark: DS `surface/page` → neutral/1100 `#141617`.
        static let page = WPAdaptiveColor(light: Color(hex: 0xF4F4F4), dark: Color(hex: 0x141617))
        /// Light from this frame. Dark from Marc: `#141617`.
        static let subPage = WPAdaptiveColor(light: Color(hex: 0xFFFFFF), dark: Color(hex: 0x141617))
        /// DS: Light white · Dark `#1D1E1F`.
        static let card = WPAdaptiveColor(light: Color(hex: 0xFFFFFF), dark: Color(hex: 0x1D1E1F))
        /// DS: Light purple/700 `#5A31F4` · Dark purple/600 `#6E5FFE`.
        static let accent = WPAdaptiveColor(light: Color(hex: 0x5A31F4), dark: Color(hex: 0x6E5FFE))
        /// DS: Light `#EDEDED` · Dark `#303233`.
        static let progressTrack = WPAdaptiveColor(light: Color(hex: 0xEDEDED), dark: Color(hex: 0x303233))
        /// Frame location chip: `surface/inverse` `#1C1C1C`.
        static let inverse = WPAdaptiveColor(light: Color(hex: 0x1C1C1C), dark: Color(hex: 0xFBFBFB))
        /// Selected chip fill `purple-alpha/20`.
        static let accentSubtle = Color(hex: 0x5A31F4, opacity: 0.2)
        /// Close control fill `rgba(120,120,128,0.16)`.
        static let closeButton = Color(red: 120 / 255, green: 120 / 255, blue: 128 / 255, opacity: 0.16)
        static let grabber = Color(hex: 0xDDDDDD)
    }

    enum Text {
        /// Light `#1C1C1C`. Dark: DS `text/primary` → neutral/100 `#FBFBFB`.
        static let primary = WPAdaptiveColor(light: Color(hex: 0x1C1C1C), dark: Color(hex: 0xFBFBFB))
        /// Light `#1C1C1C` 50%. Dark: white 50%.
        static let secondary = WPAdaptiveColor(light: Color(hex: 0x1C1C1C, opacity: 0.5), dark: Color.white.opacity(0.5))
        static let onAccent = Color.white
        static let onInverse = WPAdaptiveColor(light: Color.white, dark: Color(hex: 0x1C1C1C))
        /// `text/accent` Light purple/700 · Dark purple/400.
        static let accent = WPAdaptiveColor(light: Color(hex: 0x5A31F4), dark: Color(hex: 0xABAFFF))
    }

    enum Border {
        /// Frame `543:36458` hairline `rgba(28,28,28,0.05)`.
        static let subPage = Color(hex: 0x1C1C1C, opacity: 0.05)
        static let chip = Color.black.opacity(0.1)
        static let accent = Color(hex: 0x5A31F4)
        static let divider = Color.black.opacity(0.1)
    }
}

enum WPSpacing {
    static let space100: CGFloat = 4
    static let space150: CGFloat = 6
    static let space200: CGFloat = 8
    static let space300: CGFloat = 12
    static let space400: CGFloat = 16
    static let space600: CGFloat = 24
    static let space800: CGFloat = 32
    static let space1200: CGFloat = 48
}

enum WPRadius {
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let xl2: CGFloat = 32
    static let xl3: CGFloat = 40
    static let xl4: CGFloat = 48
    static let full: CGFloat = 9999
    /// Frame `543:36458` top corners. Not in the DS radius scale (4xl is 48).
    static let subPageTop: CGFloat = 56
}

enum WPSize {
    static let iconLG: CGFloat = 24
    static let iconButtonPrefix: CGFloat = 20
    static let touchTargetMin: CGFloat = 44
    static let progressBarHeight: CGFloat = 44
    static let fontXS: CGFloat = 10
    static let fontSM: CGFloat = 14
    static let fontMD: CGFloat = 16
    static let fontLG: CGFloat = 18
    static let fontXL2: CGFloat = 24
    static let fontXL3: CGFloat = 32
}

enum WPTracking {
    static let standard: CGFloat = -0.5
}

enum WPFont {
    private static let family = "Inter Tight"

    static func tight(_ size: CGFloat, weight: Font.Weight, relativeTo textStyle: Font.TextStyle) -> Font {
        Font.custom(family, size: size, relativeTo: textStyle).weight(weight)
    }

    static let pageTitle = tight(WPSize.fontXL3, weight: .bold, relativeTo: .title)
    static let amount = tight(WPSize.fontXL3, weight: .bold, relativeTo: .title)
    static let emptyTitle = tight(WPSize.fontXL2, weight: .bold, relativeTo: .title2)
    static let rowTitle = tight(WPSize.fontLG, weight: .medium, relativeTo: .body)
    static let bodyDefault = tight(WPSize.fontMD, weight: .medium, relativeTo: .body)
    static let bodyLight = tight(WPSize.fontMD, weight: .regular, relativeTo: .body)
    static let labelDefault = tight(WPSize.fontSM, weight: .medium, relativeTo: .subheadline)
    static let sheetTitle = tight(WPSize.fontMD, weight: .bold, relativeTo: .headline)
    static let sectionHeading = tight(WPSize.fontXL2, weight: .medium, relativeTo: .title2)
    static let tabLabel = tight(WPSize.fontXS, weight: .medium, relativeTo: .caption2)
}

extension View {
    func wpShadowMD() -> some View {
        shadow(color: Color.black.opacity(0.25), radius: 16, x: 0, y: 4)
    }

    /// Frame `543:36459`: `0px 4px 8px rgba(0,0,0,0.1)`.
    func wpCardShadow() -> some View {
        shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }

    func wpButtonShadow() -> some View {
        shadow(color: Color.black.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}
