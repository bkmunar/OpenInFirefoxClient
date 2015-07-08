/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class OpenInFirefoxControllerSwift: NSObject {
    let firefoxScheme: NSString = "firefox:"
    let basicURL: NSURL = NSURL(string: "firefox://")!

    //input your custom URI scheme to provide callback to your app
    let myAppScheme: NSURL = NSURL(string: "firefoxopeninfirefoxclient://")!
    let app = UIApplication.sharedApplication()

    func encodeByAddingPercentEscapes(input: NSString) -> NSString {
        var encodedValue: NSString = CFURLCreateStringByAddingPercentEscapes(
        kCFAllocatorDefault,
        input as CFStringRef,
        nil,
        "!*'();:@&=+$,/?%#[]" as CFStringRef,
        kCFStringEncodingASCII)
        return encodedValue
    }

    func isFirefoxInstalled() -> Bool {
        return app.canOpenURL(basicURL)
    }

    func openInFirefox(url: NSURL?) ->  Bool {
        return openInFirefox(url, callbackScheme: myAppScheme)
    }

    func openInFirefox(url: NSURL?, callbackScheme: NSURL?) -> Bool {
        if app.canOpenURL(basicURL) {
            if let url = url {
                var scheme: NSString = url.scheme!
                if scheme == "http" || scheme == "https" {
                    if let callback = callbackScheme {
                        if let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") as? NSString {
                            var firefoxURLWithCallbackString: NSMutableString = NSMutableString(format: "%@//x-callback-url/open/?x-source=%@&url=%@&x-source-name=%@", firefoxScheme, callback, encodeByAddingPercentEscapes(url.absoluteString!), encodeByAddingPercentEscapes(appName))
                            let firefoxURL = NSURL(string: firefoxURLWithCallbackString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String)
                            return app.openURL(firefoxURL!)
                        }
                    } else {
                        var firefoxURLString: NSMutableString = NSMutableString(format: "%@//open-url?url=%@", firefoxScheme, encodeByAddingPercentEscapes(url.absoluteString!))
                        let firefoxURL = NSURL(string: firefoxURLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())! as String)
                        return app.openURL(firefoxURL!)
                    }
                }
            }
        }
        return false
    }
}
