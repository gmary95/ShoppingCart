import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var quantityLabel: UILabel!
    
    weak var delegate: CartTableViewCellDelegate?
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let value = Int64(sender.value)
        
        setItemQuantity(value)
    }
    
    func setItemQuantity(_ quantity: Int64) {
        quantityLabel.text = quantity.description
        
        quantityStepper.value = Double(quantity)
        
        if (delegate != nil) {
            delegate?.cartTableViewCellSetQuantity(self, quantity: quantity)
        }
        
    }
}
