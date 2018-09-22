//
//  Utils.swift
//  FutureInSkies
//
//  Created by mac on 22/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import MBProgressHUD

class Utils: NSObject {
    class func convertToFormattedDate(dateString: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        let date = dateFormater.date(from: dateString)
        if let properDate = date {
            return getFormatedDateTimeString(date: properDate)
        }
        return  ""
    }
    
    class func getFormatedDateTimeString(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MMM-yyyy @ hh:mm a"
        return dateFormater.string(from: date)
    }
    
    class func showHUD(view: UIView) {
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading..."
    }
    
    class func hideHUD(view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    class func isValidForUrl(urlString: String) -> Bool {
        if (urlString.hasPrefix("http") || urlString.hasPrefix("https")) {
            return true
        }
        return false
    }
    
    class func openUrl(url: String?) {
        if var urlString = url, !urlString.isEmpty {
            if !isValidForUrl(urlString: urlString) {
                urlString = "http://\(urlString)"
            }
            
            let url = URL(string: urlString)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
