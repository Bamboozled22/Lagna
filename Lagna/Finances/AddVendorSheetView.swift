import SwiftUI

struct AddVendorSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var selectedCategory: VendorCategory = .all
    @State private var vendorsModel = NearbyVendorsModel()

    var body: some View {
        VStack(spacing: WPSpacing.space200) {
            header
            ScrollView {
                VStack(alignment: .leading, spacing: WPSpacing.space800) {
                    searchAndFilters
                    vendorList
                }
                .padding(.horizontal, WPSpacing.space600)
                .padding(.bottom, WPSpacing.space600)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(WPColor.Surface.card)
        .ignoresSafeArea(edges: .bottom)
        .task {
            await vendorsModel.startLocating()
        }
        .task(id: "\(searchText)|\(selectedCategory.rawValue)|\(vendorsModel.placeLabel)") {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            await vendorsModel.search(text: searchText, category: selectedCategory)
        }
    }

    private var header: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(WPColor.Surface.grabber)
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .frame(height: 16)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("IconClose")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: WPSize.iconLG, height: WPSize.iconLG)
                        .foregroundStyle(WPColor.Text.primary)
                        .frame(width: WPSize.touchTargetMin, height: WPSize.touchTargetMin)
                        .background(WPColor.Surface.closeButton, in: Circle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Close")

                Text("Add a New Vendor")
                    .font(WPFont.sheetTitle)
                    .foregroundStyle(WPColor.Text.primary)
                    .tracking(WPTracking.standard)
                    .frame(maxWidth: .infinity)

                Color.clear
                    .frame(width: WPSize.touchTargetMin, height: WPSize.touchTargetMin)
            }
            .padding(.horizontal, WPSpacing.space400)
            .padding(.bottom, 10)
        }
    }

    private var searchAndFilters: some View {
        VStack(alignment: .leading, spacing: WPSpacing.space600) {
            HStack(spacing: WPSpacing.space100) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(WPColor.Text.primary)
                TextField("Search for vendors", text: $searchText)
                    .font(WPFont.bodyDefault)
                    .tracking(WPTracking.standard)
            }
            .padding(.leading, 11)
            .padding(.trailing, 10)
            .frame(height: 48)
            .background(.regularMaterial, in: Capsule())

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: WPSpacing.space300) {
                    locationChip
                    Rectangle()
                        .fill(WPColor.Border.divider)
                        .frame(width: 1, height: 31)
                    ForEach(VendorCategory.allCases) { category in
                        FilterChip(
                            title: category.rawValue,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = category
                        }
                    }
                }
            }
        }
    }

    private var locationChip: some View {
        HStack(spacing: WPSpacing.space200) {
            Image("IconPin")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
            Text(vendorsModel.placeLabel)
                .font(WPFont.labelDefault)
                .tracking(WPTracking.standard)
                .lineLimit(1)
            Image("IconCaretDown")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
        }
        .foregroundStyle(WPColor.Text.onInverse)
        .padding(.horizontal, WPSpacing.space400)
        .frame(height: WPSize.touchTargetMin)
        .background(WPColor.Surface.inverse, in: Capsule())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Location, \(vendorsModel.placeLabel)")
        .onTapGesture {
            Task { await vendorsModel.startLocating() }
        }
    }

    private var vendorList: some View {
        VStack(alignment: .leading, spacing: WPSpacing.space600) {
            Text("Popular vendors near you")
                .font(WPFont.sectionHeading)
                .foregroundStyle(WPColor.Text.primary)
                .tracking(WPTracking.standard)

            VStack(spacing: WPSpacing.space200) {
                ForEach(vendorsModel.vendors) { vendor in
                    VendorResultRow(
                        name: vendor.name,
                        address: vendor.address,
                        distance: vendor.distance
                    )
                }
            }
        }
    }

    private var footer: some View {
        PrimaryButton(title: "Add a custom vendor", fillsWidth: true) {}
            .frame(maxWidth: .infinity)
            .padding(.horizontal, WPSpacing.space600)
            .padding(.bottom, WPSpacing.space600)
    }
}
