//
//  GameView.swift
//  IOS_25B_HW1&2
//
//  Created by Student21 on 21/05/2025.
//


import SwiftUI
import AVFoundation

struct GameView: View {
    @AppStorage("userName") var userName: String = "Player"
    @Environment(\.dismiss) var dismiss

    @StateObject private var locationManager = LocationManager()
    @State private var userSide: String = "Loading..."
    @State private var isWaitingForLocation = true

    @State private var playerScore = 0
    @State private var pcScore = 0
    @State private var currentRound = -1
    @State private var playerCardName = "back"
    @State private var pcCardName = "back"
    @State private var playerCardValue = 0
    @State private var pcCardValue = 0
    @State private var timerValue = 5
    @State private var isFirstRound = true
    @State private var countdownTimer: Timer?
    @State private var highlightWinner: String? = nil
    @State private var showVictoryScreen = false

    let cardValues = Array(2...14)
    let maxRounds = 10
    let centerLongitude = 34.817546

    var body: some View {
        VStack {
            if isWaitingForLocation {
                Text("Detecting your side...")
                    .foregroundColor(.orange)
                    .font(.subheadline)
            } else {
                Text("You are on the \(userSide) Side")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            HStack {
                playerColumn(name: userName, score: playerScore, highlight: highlightWinner == "player")
                Spacer()
                playerColumn(name: "PC", score: pcScore, highlight: highlightWinner == "pc")
            }
            .padding(.horizontal, 30)
            .padding(.top)

            Spacer()

            HStack {
                cardView(cardName: playerCardName)
                Spacer()
                cardView(cardName: pcCardName)
            }
            .padding(.horizontal, 40)

            Spacer()

            VStack(spacing: 8) {
                Image(systemName: "timer")
                Text("\(timerValue)")
                    .font(.title)

                if currentRound >= 0 {
                    Text("ROUND \(min(currentRound + 1, maxRounds))/\(maxRounds)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            SoundManager.shared.playBackgroundMusic()
            startCountdown()
        }
        .onDisappear {
            SoundManager.shared.stopBackgroundMusic()
        }
        .onReceive(locationManager.$userLongitude.compactMap { $0 }) { longitude in
            userSide = longitude > centerLongitude ? "East" : "West"
            isWaitingForLocation = false
            print("✅ userSide = \(userSide) | long: \(longitude)")
        }
        .fullScreenCover(isPresented: $showVictoryScreen) {
            VictoryView(
                winnerName: getWinnerName(),
                winnerScore: max(playerScore, pcScore),
                onPlayAgain: { resetGame() },
                onBackToMenu: { dismiss() }
            )
        }
    }

    func playerColumn(name: String, score: Int, highlight: Bool) -> some View {
        VStack {
            Text(name)
            Text("\(score)")
                .font(.title)
                .bold()
                .scaleEffect(highlight ? 1.3 : 1.0)
                .animation(.easeInOut, value: highlight)
        }
    }

    func cardView(cardName: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(radius: 4)

            Image(cardName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
        }
        .frame(width: 120, height: 180)
    }

    func startCountdown() {
        timerValue = isFirstRound ? 5 : 3
        countdownTimer?.invalidate()

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timerValue > 0 {
                timerValue -= 1
            } else {
                timer.invalidate()
                showNextRound()
            }
        }
    }

    func showNextRound() {
        if (currentRound + 1) >= maxRounds {
            endGame()
            return
        }

        SoundManager.shared.playSound(named: "game_flip_card_sound")

        let playerValue = cardValues.randomElement() ?? 2
        let pcValue = cardValues.randomElement() ?? 2

        playerCardValue = playerValue
        pcCardValue = pcValue
        playerCardName = "card\(playerValue)"
        pcCardName = "card\(pcValue)"
        highlightWinner = nil

        currentRound += 1
        isFirstRound = false
        startCountdown()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeIn(duration: 0.4)) {
                if playerValue > pcValue {
                    playerScore += 1
                    highlightWinner = "player"
                } else if pcValue > playerValue {
                    pcScore += 1
                    highlightWinner = "pc"
                }
            }
        }
    }

    func endGame() {
        countdownTimer?.invalidate()
        SoundManager.shared.stopBackgroundMusic()

        if playerScore > pcScore {
            SoundManager.shared.playSound(named: "game_won_sound")
        } else if pcScore > playerScore {
            SoundManager.shared.playSound(named: "game_lost_sound")
        } else {
            SoundManager.shared.playSound(named: "game_over_sound")
        }

        showVictoryScreen = true
    }

    func resetGame() {
        playerScore = 0
        pcScore = 0
        currentRound = -1
        isFirstRound = true
        playerCardName = "back"
        pcCardName = "back"
        highlightWinner = nil
        showVictoryScreen = false
        isWaitingForLocation = true
        startCountdown()
        SoundManager.shared.playBackgroundMusic()
    }

    func getWinnerName() -> String {
        if playerScore > pcScore {
            return userName
        } else if pcScore > playerScore {
            return "PC"
        } else {
            return "Tie"
        }
    }
}
