//
//  MerryChristmasView.swift
//  MerryChristmas
//
//  Created by Monang Champaneri on 25/12/24.
//

import SwiftUI


struct MerryChristmasView: View{
    @State private var snowflakes = [Snowflake]()

    var body: some View {
        ZStack {
            // Background image
            Image("tree_background") // Replace with your image name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            // Snowfall animation
            ForEach(snowflakes) { flake in
                Image(systemName: "snowflake")
                    .resizable()
                    .scaledToFit()
                    .frame(width: flake.size, height: flake.size)
                    .foregroundColor(.white)
                    .position(x: flake.xPosition, y: flake.yPosition)
                    .animation(nil, value: flake) // Avoid default animation
            }
        }.background(Color.gray)
        .onAppear {
            startSnowfall()
        }
    }

    private func startSnowfall() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            withAnimation {
                if snowflakes.count < 100 {
                    let newFlake = Snowflake(
                        id: UUID(),
                        xPosition: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        yPosition: CGFloat.random(in: -50...0),
                        size: CGFloat.random(in: 10...30),
                        speed: Double.random(in: 4...10)
                    )
                    snowflakes.append(newFlake)
                }
            }

            // Move each snowflake downward
            for index in snowflakes.indices {
                snowflakes[index].yPosition += CGFloat(snowflakes[index].speed)
            }

            // Remove snowflakes that fall off the screen
            snowflakes.removeAll { $0.yPosition > UIScreen.main.bounds.height }
        }
    }
}

struct Snowflake: Identifiable, Equatable{
    let id: UUID
    var xPosition: CGFloat
    var yPosition: CGFloat
    var size: CGFloat
    var speed: Double
}

struct MerryChristmasView_Previews: PreviewProvider {
    static var previews: some View {
        MerryChristmasView()
    }
}
