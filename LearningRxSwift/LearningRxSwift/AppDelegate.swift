import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ModelLayer.shared.initDatabase()

        SimpleRx.shared.variables()
        SimpleRx.shared.subjects()

        return true
    }
}

