//
//  NotificationView.swift
//  SwiftUI-Practices
//
//  Created by Htet Moe Phyu on 28/07/2023.
//

import SwiftUI
import UserNotifications
import UIKit

struct NotificationView: View {
    let id = "LocalNotificationExample"
    
    var body: some View {
        VStack{
            Button("show notification") {
                showNotification(message: "Today is Saturday.")
            }
            
            //remove single schedule notification
            Button("Remove single noti") {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
            }
            
            //remove all pending notification
            Button("Remove all pending noti") {
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
        }
        .onAppear{
            //clear badge count
            setBadgeNumber(0)
            
            //request permission
            requestNotificationAuthorization()
        }
    }
    
    
    private func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge,.sound]) { granted, error in
            if granted {
                print("GRANTED.")
            } else {
                print("DENIED!")
            }
        }
    }
    
    private func showNotification(message: String) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        //Customise the content
        let content   = UNMutableNotificationContent()
        content.title = "You Know"
        content.subtitle = "This is subtitle."
        content.body  = message
        content.sound = .default
        content.badge = 1
        
        // Create the request
        //let id = UUID().uuidString
        let request = UNNotificationRequest(identifier : id,
                                            content    : content,
                                            trigger    : trigger)
        UNUserNotificationCenter.current().add(request){ error in
            if let error = error {
                print("Error displaying notification: \(error.localizedDescription)")
            } else{
                print("Notification scheduled successfully.")
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

//MARK: notification badge
func setBadgeNumber(_ number: Int) {
    UIApplication.shared.applicationIconBadgeNumber = number
}

//import UserNotificationsUI
//class NotificationManager : UNNotificationContentExtension {
//    func didReceive(_ notification: UNNotification) {
//        //data setup
//    }
//
//    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
//        //handle user interactions
//    }
//}
