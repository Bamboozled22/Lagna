import SwiftUI

struct FinancesHomeView: View {
    @State private var isAddingVendor = false

    var body: some View {
        VStack(alignment: .leading, spacing: WPSpacing.space200) {
            Text("Finances")
                .font(WPFont.pageTitle)
                .foregroundStyle(WPColor.Text.primary)
                .tracking(WPTracking.standard)
                .frame(maxWidth: .infinity, minHeight: 39, alignment: .leading)
                .padding(.horizontal, WPSpacing.space400)

            VStack(spacing: WPSpacing.space600) {
                budgetCard
                emptyVendors
                Spacer(minLength: 0)
            }
            .padding(WPSpacing.space400)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(WPColor.Surface.subPage)
            .overlay {
                UnevenRoundedRectangle(
                    topLeadingRadius: WPRadius.subPageTop,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: WPRadius.subPageTop,
                    style: .continuous
                )
                .stroke(WPColor.Border.subPage, lineWidth: 1)
            }
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: WPRadius.subPageTop,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: WPRadius.subPageTop,
                    style: .continuous
                )
            )
            .ignoresSafeArea(edges: [.bottom, .horizontal])
        }
        .padding(.top, WPSpacing.space600)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(WPColor.Surface.page)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $isAddingVendor) {
            AddVendorSheetView()
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(WPRadius.xl4)
        }
    }

    private var budgetCard: some View {
        VStack(alignment: .leading, spacing: WPSpacing.space400) {
            VStack(alignment: .leading, spacing: WPSpacing.space100) {
                Text("Left to spend")
                    .font(WPFont.rowTitle)
                    .foregroundStyle(WPColor.Text.secondary)
                    .tracking(WPTracking.standard)

                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("$54,000")
                        .foregroundStyle(WPColor.Text.primary)
                    Text(".00")
                        .foregroundStyle(WPColor.Text.secondary)
                }
                .font(WPFont.amount)
                .tracking(WPTracking.standard)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Left to spend $54,000.00")

            VStack(alignment: .leading, spacing: WPSpacing.space200) {
                HStack(alignment: .firstTextBaseline, spacing: WPSpacing.space100) {
                    Text("Total budget")
                        .font(WPFont.bodyDefault)
                        .foregroundStyle(WPColor.Text.secondary)
                        .tracking(WPTracking.standard)
                    Spacer()
                    Text("$0.00")
                        .font(WPFont.bodyDefault)
                        .foregroundStyle(WPColor.Text.primary)
                        .tracking(WPTracking.standard)
                    Text("of $54,000.00")
                        .font(WPFont.bodyDefault)
                        .foregroundStyle(WPColor.Text.secondary)
                        .tracking(WPTracking.standard)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Total budget $0.00 of $54,000.00")

                ProgressBar()
            }
        }
        .padding(WPSpacing.space600)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: WPRadius.xl3, style: .circular)
                .fill(WPColor.Surface.card)
                .wpCardShadow()
        }
        .accessibilityElement(children: .contain)
    }

    private var emptyVendors: some View {
        VStack(spacing: WPSpacing.space600) {
            VStack(spacing: WPSpacing.space200) {
                Text("You have no vendors")
                    .font(WPFont.emptyTitle)
                    .foregroundStyle(WPColor.Text.primary)
                    .tracking(WPTracking.standard)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)

                Text("You currently have no vendors. Add a vendor to get started and track your finances.")
                    .font(WPFont.bodyLight)
                    .foregroundStyle(WPColor.Text.secondary)
                    .tracking(WPTracking.standard)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }

            PrimaryButton(title: "Add a vendor") {
                isAddingVendor = true
            }
        }
        .padding(.vertical, WPSpacing.space1200)
        .frame(maxWidth: .infinity)
    }
}

#Preview("Light") {
    FinancesHomeView()
}

#Preview("Dark") {
    FinancesHomeView()
        .preferredColorScheme(.dark)
}
