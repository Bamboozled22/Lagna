import SwiftUI

struct PrimaryButton: View {
    var title: String
    var prefixImage: String? = "IconPlus"
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            HStack(spacing: WPSpacing.space200) {
                if let prefixImage {
                    Image(prefixImage)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: WPSize.iconButtonPrefix, height: WPSize.iconButtonPrefix)
                }
                Text(title)
                    .font(WPFont.bodyDefault)
                    .tracking(WPTracking.standard)
            }
            .foregroundStyle(WPColor.Text.onAccent)
            .padding(.horizontal, WPSpacing.space400)
            .padding(.vertical, WPSpacing.space200)
            .frame(height: WPSize.touchTargetMin)
            .background(WPColor.Surface.accent, in: RoundedRectangle(cornerRadius: WPRadius.md, style: .continuous))
        }
        .buttonStyle(.plain)
        .wpButtonShadow()
        .accessibilityLabel(title)
    }
}
