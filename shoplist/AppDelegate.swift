import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let datasource = MockDatasource()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)


        datasource.getLists { lists in
            let viewController = ListViewController(list: lists.first!)
            let navigationController = UINavigationController(rootViewController:viewController)
            navigationController.interactivePopGestureRecognizer?.isEnabled = false

            window!.rootViewController = navigationController
            window!.makeKeyAndVisible()

        }

        return true
    }
}

