import Foundation
import Capacitor
import Firebase

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(FirebaseDynamicLink)
public class FirebaseDynamicLink: CAPPlugin {
    
    public override func load() {
        if (FirebaseApp.app() == nil) {
            FirebaseApp.configure()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUniversalLink(notification:)), name: Notification.Name(CAPNotifications.UniversalLinkOpen.name()), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUrlOpened(notification:)), name: NSNotification.Name(CAPNotifications.URLOpen.name()), object: nil)
    }

    @objc func handleUrlOpened(notification: NSNotification) {
        
        guard let object = notification.object as? [String:Any?] else {
            return
        }
        
        if DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: object["url"] as! URL) != nil {
            self.notifyListeners("deepLinkOpen", data: makeUrlOpenObject(object), retainUntilConsumed: true)
        }
        
    }
    
    @objc func handleUniversalLink(notification: NSNotification) {
        
        guard let object = notification.object as? [String:Any?] else {
            return
        }
        
        DynamicLinks.dynamicLinks().handleUniversalLink(object["url"] as! URL) { (dynamiclink, error) in
          
            let url = dynamiclink?.url?.absoluteString ?? ""
            
            self.notifyListeners("deepLinkOpen", data: ["url": url], retainUntilConsumed: true)
            
        }
    }
    
    func makeUrlOpenObject (_ object: [String: Any?]) -> [String:Any] {
        guard let url = object["url"] as? URL else {
            return [:]
        }
        
        return [
            "url": url.absoluteString
        ]
    }
}
