import SwiftUI

// MARK: - Root

struct ContentView: View {
    @State private var drawnCharacter: Character? = nil

    var body: some View {
        ZStack {
            if let character = drawnCharacter {
                CardView(character: character) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        drawnCharacter = nil
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal:   .move(edge: .leading).combined(with: .opacity)
                ))
            } else {
                HomeView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        drawnCharacter = Character.all.randomElement()
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal:   .move(edge: .trailing).combined(with: .opacity)
                ))
            }
        }
    }
}

// MARK: - Home Screen

struct HomeView: View {
    let onDraw: () -> Void

    var body: some View {
        ZStack {
            Color.boardNavy.ignoresSafeArea()

            // Decorative scattered question marks
            GeometryReader { geo in
                ForEach(0..<20, id: \.self) { i in
                    Text("?")
                        .font(.system(size: CGFloat.random(in: 28...72), weight: .black))
                        .foregroundColor(.white.opacity(0.06))
                        .position(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: CGFloat.random(in: 0...geo.size.height)
                        )
                }
            }
            .allowsHitTesting(false)

            VStack(spacing: 48) {
                VStack(spacing: 4) {
                    Text("Guess")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(.cardYellow)
                    Text("Who?")
                        .font(.system(size: 64, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                }

                Button(action: onDraw) {
                    HStack(spacing: 12) {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Draw Card")
                    }
                    .font(.title2.bold())
                    .foregroundColor(.boardNavy)
                    .frame(width: 240, height: 64)
                    .background(Color.cardYellow)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .cardYellow.opacity(0.45), radius: 16, x: 0, y: 8)
                }
            }
        }
    }
}

// MARK: - Card Screen

struct CardView: View {
    let character: Character
    let onConfirmedDone: () -> Void

    @State private var showConfirmation = false

    var body: some View {
        ZStack {
            Color.boardNavy.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Character card
                VStack(spacing: 0) {
                    Image(character.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.cardYellow, lineWidth: 9)
                )
                .padding(.horizontal, 44)
                .shadow(color: .black.opacity(0.4), radius: 24, x: 0, y: 12)

                Spacer()

                // Done button
                Button(action: { showConfirmation = true }) {
                    Text("Done")
                        .font(.title2.bold())
                        .foregroundColor(.boardNavy)
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color.cardYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 48)
            }
        }
        .confirmationDialog("Are you sure?", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Yes, I'm done") {
                onConfirmedDone()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will return you to the home screen.")
        }
    }
}

// MARK: - Color Palette

extension Color {
    static let boardNavy  = Color(red: 0.10, green: 0.10, blue: 0.27)
    static let cardYellow = Color(red: 0.98, green: 0.80, blue: 0.10)
    static let nameRed    = Color(red: 0.75, green: 0.10, blue: 0.12)
}

// MARK: - Preview

#Preview {
    ContentView()
}
