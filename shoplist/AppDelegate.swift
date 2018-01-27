import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ListsViewController()
        let navigationViewController = UINavigationController(rootViewController:viewController)
        window!.rootViewController = navigationViewController
        window!.makeKeyAndVisible()
        
        return true
    }
}

