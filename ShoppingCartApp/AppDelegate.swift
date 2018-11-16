import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        do {
            try CartFileReader.saveCartContent(at: Constants.FileConstants.cartFileName)
        } catch {
            print(error.localizedDescription)
        }
        do {
            try ProductsFileReader.saveProductContent(at: Constants.FileConstants.productsFileName)
        } catch {
            print(error.localizedDescription)
        }
        
        return true
    }


}

