//
//  AppStorageExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 07/07/2023.
//

import SwiftUI

/*
 set      >> UserDefaults.standard.set(self.tapCount, forKey: "Tap")
 retrieve >> @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
 */

struct AppStorageExample: View {
    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
        }
        .buttonStyle(.borderedProminent)
    }
}

struct AppStorageExample_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageExample()
    }
}
