//
//  NetworkHandler.swift
//  Task
//
//  Created by John Doe on 2022-06-12.
//

import Foundation

class NetworkHandler {

    static let shared: NetworkHandler = NetworkHandler()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var isConnected: Bool = false {
        didSet {
            print("Network State Changed To: \(isConnected)")
           
        }
    }
    
    
    func trackNetworkStatus() {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                    self.isConnected = true
            } else {
                print("There's no internet connection.")
                    self.isConnected = false
            }
        }
        monitor.start(queue: queue)
    }
}
