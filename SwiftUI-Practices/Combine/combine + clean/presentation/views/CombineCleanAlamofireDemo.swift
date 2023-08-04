//
//  CombineCleanAlamofireDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import SwiftUI
import Combine
import Alamofire

struct CombineCleanAlamofireDemo: View {
    @StateObject var viewModel = ACAViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts, id : \.id) { post in
                Text(post.title)
            }
        }
    }
}

struct CombineCleanAlamofireDemo_Previews: PreviewProvider {
    static var previews: some View {
        CombineCleanAlamofireDemo()
    }
}
