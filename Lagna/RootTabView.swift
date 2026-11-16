import SwiftUI

enum AppTab: Hashable {
    case home, finances, tasks, guests, profile
}

struct RootTabView: View {
    @State private var selection: AppTab = .finances

    var body: some View {
        TabView(selection: $selection) {
            Tab(value: .home) {
                StubTabView(title: "Home")
            } label: {
                tabLabel("Home", for: .home)
            }
            Tab(value: .finances) {
                FinancesHomeView()
            } label: {
                tabLabel("Finances", for: .finances)
            }
            Tab(value: .tasks) {
                StubTabView(title: "Tasks")
            } label: {
                tabLabel("Tasks", for: .tasks)
            }
            Tab(value: .guests) {
                StubTabView(title: "Guests")
            } label: {
                tabLabel("Guests", for: .guests)
            }
            Tab(value: .profile) {
                StubTabView(title: "Profile")
            } label: {
                tabLabel("Profile", for: .profile)
            }
        }
        .tint(WPColor.Surface.accent)
    }

    private func tabLabel(_ title: String, for tab: AppTab) -> some View {
        Label {
            Text(title)
        } icon: {
            Image(tabImage(for: tab))
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: WPSize.iconLG, height: WPSize.iconLG)
        }
    }

    private func tabImage(for tab: AppTab) -> String {
        let selected = selection == tab
        switch tab {
        case .home: return selected ? "TabHomeFill" : "TabHome"
        case .finances: return selected ? "TabFinances" : "TabFinancesRegular"
        case .tasks: return selected ? "TabTasksFill" : "TabTasks"
        case .guests: return selected ? "TabGuestsFill" : "TabGuests"
        case .profile: return selected ? "TabProfileFill" : "TabProfile"
        }
    }
}

struct StubTabView: View {
    var title: String

    var body: some View {
        ContentUnavailableView(title, systemImage: "rectangle.dashed")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Rectangle()
                    .fill(WPColor.Surface.page)
                    .ignoresSafeArea()
            }
    }
}
