import SwiftUI

struct JuckeboxTabView: View {
    
    @State private var selectedCelebration: CelebrationModel = .septiembre16
    
    var body: some View {
        TabView(selection: $selectedCelebration) {
            septemberTab
            octoberTab
            novemberTab
            decemberTab
        }
        .tint(selectedTabTint)
    }
}

private extension JuckeboxTabView {
    
    var septemberTab: some TabContent<CelebrationModel> {
        Tab(
            CelebrationModel.septiembre16.title,
            systemImage: "guitars.fill",
            value: .septiembre16
        ) {
            CelebrationBoardView(
                celebrationDisplay: .septiembre16
            )
        }
    }
    
    var octoberTab: some TabContent<CelebrationModel> {
        Tab(
            CelebrationModel.octubre31.title,
            systemImage: "moon.stars.fill",
            value: .octubre31
        ) {
            CelebrationBoardView(
                celebrationDisplay: .octubre31
            )
        }
    }
    
    var novemberTab: some TabContent<CelebrationModel> {
        Tab(
            CelebrationModel.noviembre20.title,
            systemImage: "flag.2.crossed.fill",
            value: .noviembre20
        ) {
            CelebrationBoardView(
                celebrationDisplay: .noviembre20
            )
        }
    }
    
    var decemberTab: some TabContent<CelebrationModel> {
        Tab(
            CelebrationModel.diciembre25.title,
            systemImage: "snowflake",
            value: .diciembre25
        ) {
            CelebrationBoardView(
                celebrationDisplay: .diciembre25
            )
        }
    }
    
    var selectedTabTint: Color {
        switch selectedCelebration {
        case .septiembre16: return .green
        case .octubre31: return .orange
        case .noviembre20: return .brown
        case .diciembre25: return .red
        }
    }
}

#if targetEnvironment(simulator)
#Preview {
    JuckeboxTabView()
}
#endif
