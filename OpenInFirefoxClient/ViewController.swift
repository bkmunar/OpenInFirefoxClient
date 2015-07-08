/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import WebKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let myWebView:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))

        let swiftButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        swiftButton.frame = CGRectMake(100, 100, 200, 50)
        swiftButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 150)
        swiftButton.backgroundColor = UIColor.orangeColor()
        swiftButton.setTitle("OpenInFirefox with Swift", forState: UIControlState.Normal)
        swiftButton.tintColor = UIColor.whiteColor()
        swiftButton.addTarget(self, action: "buttonActionSwift:", forControlEvents: UIControlEvents.TouchUpInside)

        let objCButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        objCButton.frame = CGRectMake(100, 300, 200, 50)
        objCButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
        objCButton.backgroundColor = UIColor.blueColor()
        objCButton.setTitle("OpenInFirefox with Obj-C", forState: UIControlState.Normal)
        objCButton.tintColor = UIColor.whiteColor()
        objCButton.addTarget(self, action: "buttonActionObjc:", forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(myWebView)
        self.view.addSubview(swiftButton)
        self.view.addSubview(objCButton)
    }

    func buttonActionSwift(sender: UIButton!) {
        if let url = NSURL(string: "https://www.youtube.com/results?search_query=hello+world") {
            var controller = OpenInFirefoxControllerSwift()
            if controller.isFirefoxInstalled() {
                controller.openInFirefox(url)
            }
        }
    }

    func buttonActionObjC(sender: UIButton!) {
        if let url = NSURL(string: "https://www.youtube.com/results?search_query=hello+world") {
            var controller = OpenInFirefoxControllerObjC()
            if controller.isFirefoxInstalled() {
                controller.openInFirefox(url)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

