//
//  UserActionCombine.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 09/02/2023.
//

import SwiftUI
import Combine

struct UserActionCombine: View {
    @State private var tapCount = 0
    var tapPublisher = PassthroughSubject<Void, Never>()
    /*PassthroughSubject is a type of Subject that allows you to send values to subscribers*/
    
    var body: some View {
        Button("Tap Count : \(tapCount)") {
            tapPublisher.send()
        }
        .buttonStyle(.borderedProminent)
        .onReceive(tapPublisher.eraseToAnyPublisher()) { _ in
            tapCount += 1
        }
    }
}

struct UserActionCombinePreviews: PreviewProvider {
    static var previews: some View {
        UserActionCombine()
    }
}
