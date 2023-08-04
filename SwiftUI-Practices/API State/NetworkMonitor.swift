//
//  NetworkMonitor.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 22/06/2023.
//

import Foundation
import Network

class NetworkMonitor : ObservableObject {
    
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    let queue   = DispatchQueue(label: "NetworkMonitor")
    
    //@Published var selectedLang = bageStorage.selectedLang
    
    @Published var isConnected = false
    @Published var showToast   = false
    
    init() {
        monitor.pathUpdateHandler =  { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
                self?.showToast = !self!.isConnected
            }
        }
        monitor.start(queue: queue)
    }
}
