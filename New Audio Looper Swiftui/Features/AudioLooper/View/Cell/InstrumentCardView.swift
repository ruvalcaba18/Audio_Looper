import SwiftUI

struct InstrumentCardView: View {
    
    @ObservedObject private var viewModel: AudioLooperViewModel
    @State private var volume: Double
    @State private var rate: Double
    @State private var isPlaying: Bool
    
    private let instrument: InstrumentsModel
    
    init(
        instrument: InstrumentsModel,
        viewModel: AudioLooperViewModel
    ) {
        self.instrument = instrument
        self.viewModel = viewModel
        
        _volume = State(initialValue: viewModel.volume(for: instrument))
        _rate = State(initialValue: viewModel.rate(for: instrument))
        _isPlaying = State(initialValue: viewModel.isPlaying(instrument))
    }
    
    var body: some View {
        VStack(spacing: 12) {
            titleLabel
            instrumentImage
            knobsRow
            Divider()
            playStopButton
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(cardBackground)
        .onChange(of: volume) { _, newValue in
            viewModel.updateVolume(Float(newValue), for: instrument)
        }
        .onChange(of: rate) { _, newValue in
            viewModel.updateRate(Float(newValue), for: instrument)
        }
        .onChange(of: isPlaying) { _, playing in
            playing
                ? viewModel.playInstrument(instrument)
                : viewModel.stopInstrument(instrument)
        }
        .onChange(of: viewModel.soundPlayerState) { _, newState in
            if (newState == .stopped || newState == .interrupted) && isPlaying {
                isPlaying = false
            }
        }
    }
}

private extension InstrumentCardView {
    
    var titleLabel: some View {
        Text(instrument.displayName)
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var instrumentImage: some View {
        Image(instrument.instrumentImage)
            .resizable()
            .scaledToFit()
            .frame(height: 110)
    }
    
    var knobsRow: some View {
        HStack(spacing: 24) {
            VStack(spacing: 4) {
                ControlKnob(
                    value: $volume,
                    minimumValue: .constant(0.0),
                    maximumValue: .constant(1.0),
                    defaultValue: .constant(1.0),
                    indicatorColor: .orange
                )
                .frame(width: 44, height: 44)
                
                Text("Vol")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            VStack(spacing: 4) {
                ControlKnob(
                    value: $rate,
                    minimumValue: .constant(0.5),
                    maximumValue: .constant(2.0),
                    defaultValue: .constant(1.0),
                    indicatorColor: .greenLightIndicatorColor
                )
                .frame(width: 44, height: 44)
                
                Text("Rate")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .fill(Color(.systemBackground))
            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
    }
    
    var playStopButton: some View {
        PlayStopButtonView(isPlaying: $isPlaying)
    }
}

#if targetEnvironment(simulator)
#Preview {
    InstrumentCardView(
        instrument: .clasicGuitar,
        viewModel: AudioLooperViewModel(choosedCelebration: .septiembre16)
    )
    .padding()
}
#endif
