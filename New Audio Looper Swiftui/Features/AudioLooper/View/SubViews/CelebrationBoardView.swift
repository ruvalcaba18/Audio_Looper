import SwiftUI

struct CelebrationBoardView: View {
    
    @State private var gain = 0.0
    @StateObject private var viewModel: AudioLooperViewModel
    private let celebration: CelebrationModel
    
    private let adaptativeColumn = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]
    
    public init(celebrationDisplay: CelebrationModel) {
        _viewModel = StateObject(
            wrappedValue: AudioLooperViewModel()
        )
        celebration = celebrationDisplay
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundContent
                
                VStack(spacing: 0) {
                    renderInstrumentViewWithKnob
                        .frame(width: geometry.size.width * 0.90)
                }
            }
            .task {
               await  viewModel.configureCelebrationInstruments(choosedCelebration: celebration)
            }
        }
        .onDisappear {
            viewModel.stopAll()
        }
    }
}

private extension CelebrationBoardView {
    
    var backgroundContent: some View {
        Color.white
            .ignoresSafeArea()
    }
    
    var renderInstrumentViewWithKnob: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: adaptativeColumn, alignment: .center, spacing: 24) {
                ForEach(viewModel.choosedCelebration.instruments) { instrument in
                    InstrumentCardView(
                        instrument: instrument,
                        viewModel: viewModel
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
    }
}

#if targetEnvironment(simulator)
#Preview(".audio looper december 25") {
    CelebrationBoardView(celebrationDisplay: .diciembre25)
}

#Preview(".audio looper november 20") {
    CelebrationBoardView(celebrationDisplay: .noviembre20)
}

#Preview(".audio looper october 31") {
    CelebrationBoardView(celebrationDisplay: .octubre31)
}

#Preview(".audio looper september 15") {
    CelebrationBoardView(celebrationDisplay: .septiembre16)
}
#endif
