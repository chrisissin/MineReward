//
//  ContentView.swift
//  MineReward
//
//  Created by Chris Ho on 2025-05-19.
//
import SwiftUI

//@main
//struct GateApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

struct ContentView: View {
    @StateObject private var questionFetcher = QuestionFetcher()
    @State private var showTimer = false
    @State private var answerCorrect = false

    var body: some View {
        if showTimer {
            TimerView {
                AppLauncher.openApp(scheme: "youtube://")
            }
        } else {
            QuestionView(questionFetcher: questionFetcher, onCorrectAnswer: {
                showTimer = true
            })
        }
    }
}

struct QuestionView: View {
    @ObservedObject var questionFetcher: QuestionFetcher
    @State private var userAnswer = ""
    var onCorrectAnswer: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text(questionFetcher.question)
                .font(.title)
                .padding()

            TextField("Type your answer...", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                if userAnswer.lowercased() == questionFetcher.correctAnswer.lowercased() {
                    onCorrectAnswer()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            questionFetcher.fetchQuestion()
        }
        .padding()
    }
}

struct TimerView: View {
    @State private var timeRemaining = 15
    var onFinish: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Text("Take a breath…")
                .font(.title)
            Text("\(timeRemaining)")
                .font(.system(size: 72, weight: .bold))
                .onAppear(perform: startCountdown)
        }
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                onFinish()
            }
        }
    }
}

struct AppLauncher {
    static func openApp(scheme: String) {
        if let url = URL(string: scheme), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("App not installed or URL scheme unavailable.")
        }
    }
}

//class QuestionFetcher: ObservableObject {
//    @Published var question: String = "What's 2 + 2?"
//    @Published var correctAnswer: String = "4"
//
//    func fetchQuestion() {
//        // In a real implementation, you'd use Firebase SDK here
//        // Example placeholder:
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.question = "What's 5 + 3?"
//            self.correctAnswer = "8"
//        }
//    }
//}
