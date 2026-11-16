import SwiftUI

struct ProgressBar: View {
    @Environment(\.colorScheme) private var colorScheme

    /// Flat sRGB fill. A 44pt `RoundedRectangle` inside `TabView` was picking up iOS 27 glass.
    private var trackColor: Color {
        switch colorScheme {
        case .dark:
            Color(.sRGB, red: 48 / 255, green: 50 / 255, blue: 51 / 255, opacity: 1) // #303233
        default:
            Color(.sRGB, red: 237 / 255, green: 237 / 255, blue: 237 / 255, opacity: 1) // #EDEDED
        }
    }

    var body: some View {
        Canvas { context, size in
            let path = RoundedRectangle(cornerRadius: WPRadius.sm, style: .circular)
                .path(in: CGRect(origin: .zero, size: size))
            context.fill(path, with: .color(trackColor))
        }
        .frame(height: WPSize.progressBarHeight)
        .accessibilityLabel("Budget progress")
        .accessibilityValue("Empty")
    }
}
