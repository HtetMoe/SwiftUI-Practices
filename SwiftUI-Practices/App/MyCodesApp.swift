//
//  MyCodesApp.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 19/01/2023.
//

import SwiftUI
import UIKit

@main
struct MyCodesApp: App {
    @StateObject var viewModel = DeepLinkViewModel()
    @StateObject var dataController = DataController()
    @StateObject private var idataController = iDataController()
    
    //db migrator
    let migrator = Migrator()
    
    //push noti
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //user notification
            NotificationView()
            
            //unit test
            //CalculatorView()
            //ImageUrlView()
            //            LoadImageView()
            
            //            CoreImage()
            //            ImagePickerView()
            
            //            CoreDataConstraint()
            //            Filtering()
            //            DynamicallyFiltering()
            //            OneToManyRelationship()
            //                .environment(\.managedObjectContext, idataController.container.viewContext)
            
            //            BookStore()
            //                .environment(\.managedObjectContext, idataController.container.viewContext)
            
            //            CoreDataSample()
            //                .environment(\.managedObjectContext, dataController.container.viewContext)
            
            //            CombineCoreData()
            //                .environment(\.managedObjectContext, idataController.container.viewContext)
            
            //            CupCakeCorner()
            //            BlendingExample()
            //            ColorCyclingCircleExample()
            //            CGAffineTransformExample()
            //            ShapeAndPathExample()
            //            TrianglePathExample()
            //            MoonShot()
            //            ScrollingGridView()
            //            DecodingJsonString()
            //            iExpense()
            //            AppStorageExample()
            //            DeleteListItem()
            //            CustomTransactionWithModifier()// like paper slide
            //            ShowHideTransactionAnimation()
            //            AnimatedTextGesture()
            //            FloatingAnimation()
            //            WordScramble()
            //            BetterRest()
            //            TestView()
            //            GuessTheFlag()
            //            CalculatorProject()
            //            SnackBarExample()
            //            APIStatusDemo()
            //            ToggleExample()
            //print realm storage directory
            //            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            
            //            WeSplit()
            //            TemperatureConverter()
            
            //            ErrorHandlingFunctionDemo()
            //            AuthorListView()
            //            SongPlayerView()
            //            AudioMessageItem(audioName: "hello")
            //            LanguageDemo()
            //one to many rs Realm
            //            TabView {
            //                CountryListView()
            //                    .tabItem {
            //                        Label("Countries", systemImage: "list.dash")
            //                    }
            //                AllCityListView()
            //                    .tabItem {
            //                        Label("Cities", systemImage: "list.dash")
            //                    }
            //            }
            
            //            StudentLists()
            //            RealmDemo()
            //            CombineCleanAlamofireDemo()
            //            AlamofireRequestCombine()
            //            UserActionCombine1()
            //            AlamofireWithCombineSample()
            //            AlamofireSample()
            
            //            FileDownloadDemo()
            //            FilePreviewDemo()
            //            GenericFunctionExample()
            //            AuthCombineView()
            //            ContentView()
            //            NetworkRequestCombine()
            //            ReactiveProgrammingDemo()
            //            DeepLinkMain()
            //                .environmentObject(viewModel)
            //                .onOpenURL { url in
            //                    if viewModel.checkDeepLink(url: url){
            //                        print("DeepLink url : \(url)")
            //                    }
            //                    else{//print("Fail Deep link!")
            //                        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            //                        if let hostValue = components?.host{
            //                            if viewModel.checkInternalLinks(host: hostValue){
            //                                print("DeepLink url : \(url)")
            //                            }
            //                        }
            //                    }
            //                }
        }
    }
}


/*
 DeepLink >> App >> Target >> Info >> add url scheme here
 */


class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission for user notifications granted.")
            } else {
                print("Permission for user notifications denied.")
            }
        }
        application.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //after registered for remote notifications
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("Device Token:", token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications:", error.localizedDescription)
    }
    
    // Handle the received remote notification when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    // Handle user interactions with the notification when the app is in the background or not running
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the actions based on the notification response here
        completionHandler()
    }
}
