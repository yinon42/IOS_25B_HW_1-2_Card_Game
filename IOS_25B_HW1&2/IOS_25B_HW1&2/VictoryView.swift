//
//  VictoryView.swift
//  IOS_25B_HW1&2
//
//  Created by Student21 on 20/05/2025.
//

import SwiftUI

struct VictoryView: View {
    let winnerName: String
    let winnerScore: Int
    let onPlayAgain: () -> Void
    let onBackToMenu: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("Winner: \(winnerName)")
                .font(.largeTitle)
                .bold()

            Text("Score: \(winnerScore)")
                .font(.title2)

            Spacer()

            // כפתור: שחק שוב
            Button(action: {
                onPlayAgain()
            }) {
                Text("PLAY AGAIN")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.green)
                    .cornerRadius(10)
            }

            // כפתור: חזרה לתפריט
            Button(action: {
                onBackToMenu()
            }) {
                Text("BACK TO MENU")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView(
            winnerName: "Gabi",
            winnerScore: 10,
            onPlayAgain: {},
            onBackToMenu: {}
        )
    }
}


