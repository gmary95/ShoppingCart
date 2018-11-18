import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK:- if you have more elements in JSON file, you application will load very long time.
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

