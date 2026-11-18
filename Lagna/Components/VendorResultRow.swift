import SwiftUI

struct VendorResultRow: View {
    var name: String
    var address: String
    var distance: String

    var body: some View {
        VStack(alignment: .leading, spacing: WPSpacing.space200) {
            Text(name)
                .font(WPFont.bodyDefault)
                .foregroundStyle(WPColor.Text.primary)
                .tracking(WPTracking.standard)
                .lineLimit(1)

            HStack(spacing: WPSpacing.space200) {
                Text(address)
                    .lineLimit(1)
                Circle()
                    .fill(WPColor.Text.secondary)
                    .frame(width: 4, height: 4)
                Text(distance)
            }
            .font(WPFont.labelDefault)
            .foregroundStyle(WPColor.Text.secondary)
            .tracking(WPTracking.standard)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, WPSpacing.space400)
        .padding(.vertical, WPSpacing.space400)
        .frame(height: 76, alignment: .center)
        .background(WPColor.Surface.card, in: RoundedRectangle(cornerRadius: WPRadius.xl2, style: .circular))
        .wpCardShadow()
    }
}
