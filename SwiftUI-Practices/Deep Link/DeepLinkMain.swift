//
//  DeepLinkMain.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/01/2023.
//

import SwiftUI
struct DeepLinkMain: View {
    @EnvironmentObject var viewModel : DeepLinkViewModel
    
    var body: some View {
        
        TabView(selection: $viewModel.currentTab) {
            
            Text("Home")
                .tag(Tab.home)
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            ProductView()
                .environmentObject(viewModel)
                .tag(Tab.product)
                .tabItem {
                    Image(systemName: "s.circle")
                }
            
            Text("Setting")
                .tag(Tab.setting)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
    }
}

struct DeepLinkMain_Previews: PreviewProvider {
    static var previews: some View {
        DeepLinkMain()
    }
}

//MARK: ProductView
struct ProductView : View {
    @EnvironmentObject var viewModel : DeepLinkViewModel
    
    var body: some View{
        
        NavigationView {
            
            List{
                ForEach(products) { product in
                     NavigationLink(tag : product.id,
                                    selection: $viewModel.currentDetailPage) {
                        DetailView(product: product)
                    } label: {
                        HStack(spacing: 15) {
                            Circle()
                                .background(.clear)
                                .frame(width: 45, height: 45, alignment: .center)
                                .overlay {
                                    Text("\(product.id)")
                                        .foregroundColor(.white)
                                }
                            
                            Text(product.name)
                        }
                    }
                }
            }
            .navigationTitle("Products")
            .toolbar {
                Button("GoTo Nav Link3") {
                    viewModel.currentDetailPage = products[2].id
                    
                }
            }
        }
    }
}

//MARK: Detail View
@ViewBuilder
func DetailView(product : Product) -> some View {
    ScrollView {
        VStack(spacing: 15){
            Text("Hello! Good morning")
            
            Text("This is detail view of \(product.name)")
        }
        
    }
    .navigationTitle(product.name)
    .navigationBarTitleDisplayMode(.inline)
}



//MARK: - tabs
enum Tab : String{
    case home    = "home"
    case product = "product"
    case setting = "setting"
}


//MARK: - view model
class DeepLinkViewModel : ObservableObject{
    @Published var currentTab : Tab = .home
    @Published var currentDetailPage : Int?
    
    func checkDeepLink(url : URL) -> Bool{
        guard let host = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        
        //Updating Tabs
        switch(host){
        case Tab.home.rawValue    : currentTab = .home
        case Tab.product.rawValue : currentTab = .product
        case Tab.setting.rawValue : currentTab = .setting
        default:
            return false
        }
        
        return true
    }
    
    //check for host contains any navLink ids
    func checkInternalLinks(host : String) -> Bool{
        if let index = products.firstIndex(where: { product in
            return product.id == Int(host)
        }){
            currentTab = .product
            currentDetailPage = products[index].id
            return true
        }
        
        return false
    }
}

//MARK: - models
struct Product : Identifiable{
    var id : Int
    var name : String
}

var products = [ // used ids to link when DeepLink call
    Product(id: 1, name: "Product 1"),
    Product(id: 2, name: "Product 2"),
    Product(id: 3, name: "Product 3"),
    Product(id: 4, name: "Product 4"),
    Product(id: 5, name: "Product 5")
]
