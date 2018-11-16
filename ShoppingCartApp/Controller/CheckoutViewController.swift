import UIKit

class CheckoutViewController: UIViewController {
    @IBOutlet weak var checkoutListLabel: UILabel!
    
    var checkoutListString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkoutListLabel.text = Constants.CartConstants.order + (checkoutListString ?? "")
    }

}
