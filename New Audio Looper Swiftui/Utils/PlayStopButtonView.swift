import SwiftUI

struct PlayStopButtonView: View {
    
    @Binding var isPlaying: Bool
    
    public init(isPlaying: Binding<Bool>) {
        _isPlaying = isPlaying
    }
    
    var body: some View {
        Button {
            isPlaying.toggle()
        } label: {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.title2)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
        .background(isPlaying ? .orange : .red)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
    }
}

#Preview {
    PlayStopButtonView(isPlaying: .constant(false))
}
