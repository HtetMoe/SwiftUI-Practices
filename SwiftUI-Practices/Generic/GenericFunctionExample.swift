//
//  GenericFunctionExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 15/02/2023.
//

import SwiftUI

struct GenericFunctionExample : View {
    let array1 = [1, 2, 3, 4, 5]
    let array2 = [3, 4, 5, 6, 7]
    
    @State var result = ""
    
    var body: some View {
        VStack{
            Text("Array 1 : [1, 2, 3, 4, 5]")
            Text("Array 2 : [3, 4, 5, 6, 7]")
            
            Button("Common") {
                self.result = "Common values : \(commonElements(array1: array1, array2: array2))"
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            Text(result)
        }
        .padding(30)
    }
    
}

struct GenericFunctionExample_Previews: PreviewProvider {
    static var previews: some View {
        GenericFunctionExample()
    }
}

extension GenericFunctionExample{
    
    //generic func
    func commonElements<T: Equatable>(array1: [T], array2: [T] ) -> [T] {
        var result: [T] = []
       
        for element in array1 {
            if array2.contains(element) {
                result.append(element)
            }
        }
        return result
    }
}
