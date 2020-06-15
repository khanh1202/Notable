//
//  ClassifierManager.swift
//  Notable
//
//  Created by Khanh Dinh on 6/10/20.
//  Copyright © 2020 Khanh Dinh. All rights reserved.
//

import Foundation
import CoreML
struct ClassifierManager {
    static func predictSentiment(of text: String) {
        do {
            let classifier = SentimentClassifier()
            let classifierInput = SentimentClassifierInput(text: text)
            let predictedSentiment = try classifier.prediction(input: classifierInput)
            print("Predicted sentiment: \(predictedSentiment.label)")
        } catch {
            print("problem predicting sentiment. Error: \(error)")
        }
    }
}
