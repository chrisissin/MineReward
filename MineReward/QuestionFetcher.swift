import Foundation
import FirebaseFirestore
import Combine

class QuestionFetcher: ObservableObject {
    @Published var question: String = "Loading question..."
    @Published var correctAnswer: String = ""

    private var db = Firestore.firestore()

    func fetchQuestion() {
        // Fetch one random question document
        db.collection("questions").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching question: \(error)")
                self.question = "Failed to load"
                return
            }

            guard let documents = snapshot?.documents, !documents.isEmpty else {
                            self.question = "What's 5 + 3?"
                            self.correctAnswer = "8"
                return
            }

            // Pick a random document
            let randomDoc = documents.randomElement()!
            self.question = randomDoc["text"] as? String ?? "Missing question"
            self.correctAnswer = randomDoc["answer"] as? String ?? ""
        }
    }
}
