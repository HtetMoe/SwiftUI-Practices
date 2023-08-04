//
//  FilteredList.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/07/2023.
//

import SwiftUI
import CoreData

//convert to generic filter
struct FilteredList<T: NSManagedObject, Content : View>: View {
    
    @FetchRequest var fetchRequest : FetchedResults<T>
    let content : (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content : @escaping (T) -> Content) {
        _fetchRequest =  FetchRequest<T>(sortDescriptors: [], predicate : NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content  = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
