import SwiftUI

struct FilterChip: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(WPFont.labelDefault)
                .tracking(WPTracking.standard)
                .foregroundStyle(isSelected ? AnyShapeStyle(WPColor.Text.accent) : AnyShapeStyle(WPColor.Text.primary))
                .padding(.horizontal, WPSpacing.space400)
                .frame(height: WPSize.touchTargetMin)
                .background(
                    Capsule()
                        .fill(isSelected ? WPColor.Surface.accentSubtle : Color.clear)
                )
                .overlay {
                    Capsule()
                        .strokeBorder(
                            isSelected ? AnyShapeStyle(WPColor.Border.accent) : AnyShapeStyle(WPColor.Border.chip),
                            lineWidth: 1
                        )
                }
        }
        .buttonStyle(ChipButtonStyle())
    }
}

private struct ChipButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
