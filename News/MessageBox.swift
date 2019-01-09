 import Foundation
import UIKit
import MessageUI

class MessageBox{
    
    public static func Show(message: String, title: String, view: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let dismisAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(dismisAction)
        view.present(alertController, animated: true, completion: nil)
    }
}
