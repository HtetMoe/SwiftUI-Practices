//
//  BookRatingView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 12/07/2023.
//

import SwiftUI

struct BookRatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor  = Color.yellow
    
    var body: some View {
        
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct BookRatingView_Previews: PreviewProvider {
    static var previews: some View {
        BookRatingView(rating: .constant(4))
    }
}
