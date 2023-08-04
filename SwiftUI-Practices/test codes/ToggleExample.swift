//
//  ToggleExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/06/2023.
//

import SwiftUI

struct ToggleExample: View {
    @State private var toggleValue = false
    
    var body: some View {
        VStack{
            Toggle("On or Off", isOn: $toggleValue)
            .onChange(of: toggleValue) { newValue in
                if newValue {
                    // Call your function here and check its return value
//                    let functionReturnValue = process(newValue)
//                    if !functionReturnValue {
//                        toggleValue = false
//                    }
                    toggleValue = process(newValue)
                }
            }
        }
    }
    
    func process(_ newValue : Bool) -> Bool{
        return true//!newValue
    }
}

struct ToggleExample_Previews: PreviewProvider {
    static var previews: some View {
        ToggleExample()
    }
}
