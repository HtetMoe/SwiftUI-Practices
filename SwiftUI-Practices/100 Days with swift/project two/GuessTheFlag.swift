//
//  GuessTheFlag.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/06/2023.
//

import SwiftUI

struct GuessTheFlag: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle   = ""
    
    //score
    @State private var score         = 0
    @State private var isCorrect     = false
    @State private var selectedFlag  = ""
    @State private var questionCount = 0
    
    var body: some View {
        
        ZStack {
            //LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing : 15){
                    
                    //demand
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                           
                    }
                    
                    //showing 3 flags
                    ForEach(0..<3) { number in
                        Button {
                            questionCount += 1
                            selectedFlag = countries[number]
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth : .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Spacer()
                Spacer()
                
                Text("Score : \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            
            let title = questionCount < 8 ? "Continue" : "Restart?"
            Button(title, action: questionCount < 8 ? askQuestion : restart)
        } message: {
            let msg = questionCount < 8 ? (isCorrect ? "Your score is \(score)" : "Wrong! That’s the flag of \(selectedFlag)") : "Restart the game."
            Text(msg)
        }
    }
    
    //check answer
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            isCorrect = true
        } else {
            scoreTitle = "Wrong"
            isCorrect  = false
        }
        showingScore = true
    }
    
    //ask question
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart(){
        score = 0
        questionCount = 0
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}
