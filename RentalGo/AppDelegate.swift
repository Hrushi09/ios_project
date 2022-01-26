import UIKit
@_exported import Firebase
@_exported import FirebaseFirestore
@_exported import SDWebImage
import FirebaseCore



@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var db : Firestore!
    static let shared : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        db = Firestore.firestore()
        let settings = db.settings
        db.settings = settings
        
//        if (UserDefaults.standard.string(forKey: UserDefaults.Keys.isEmail) != nil) {
//            UIApplication.shared.setHome()
//        }
        return true
    }


    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}


