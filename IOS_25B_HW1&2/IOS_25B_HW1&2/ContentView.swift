//
//  ContentView.swift
//  IOS_25B_HW1&2
//
//  Created by Student21 on 20/05/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userName") var userName: String = ""
    @State private var showNameInput = false
    @State private var navigateToGame = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 40)

                Button("Insert name") {
                    showNameInput = true
                }
                .foregroundColor(.blue)
                .underline()

                Spacer().frame(height: 10)

                Text("Hi \(userName.isEmpty ? "Guest" : userName)")
                    .font(.title)

                Text("Tap START to determine your side")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer().frame(height: 30)

                HStack {
                    VStack {
                        Image("earth_left")
                            .resizable()
                            .frame(width: 120, height: 120)
                        Text("West Side")
                    }

                    Spacer()

                    VStack {
                        Image("earth_right")
                            .resizable()
                            .frame(width: 120, height: 120)
                        Text("East Side")
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                Button("START") {
                    navigateToGame = true
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)

                Spacer()
            }
            .padding()
            .sheet(isPresented: $showNameInput) {
                NameInputView(name: $userName)
            }
            .navigationDestination(isPresented: $navigateToGame) {
                GameView()
            }
        }
    }
}

struct NameInputView: View {
    @Binding var name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your name")
                .font(.headline)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save") {
                dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 150, height: 40)
            .background(Color.green)
            .cornerRadius(10)
        }
        .padding()
    }
}
