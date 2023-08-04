//
//  RelativeTimeView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import SwiftUI

struct RelativeTimeView: View {
    let post    = POST(timeAgo: 24, time: .second)
    let manager = TimeManager()
    
    var body: some View {
        Text(manager.displayTimeAgo(forPost: post))
    }
}

struct RelativeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        RelativeTimeView()
    }
}

//MARK: - Post
class POST{
    var timeAgo : Int // count
    var time : Time   // in hr/min/secs/week/mth/year
    
    init(timeAgo : Int, time : Time){
        self.timeAgo = timeAgo
        self.time    = time
    }
}

//MARK: - social media post timestamp
enum Time : String{
    case second = "second"
    case minute = "minute"
    case hour   = "hour"
    case day    = "day"
    case week   = "week"
    case month  = "month"
    case year   = "year"
    
}

//MARK: - Time Manager
class TimeManager{
    //display post time stamp
    func displayTimeAgo(forPost post : POST) -> String{
        let timeAgo = post.timeAgo
        let appendingMessage = "s ago"
        return String(timeAgo) + " " + post.time.rawValue + appendingMessage
    }
}
