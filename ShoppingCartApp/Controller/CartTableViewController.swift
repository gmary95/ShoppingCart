import UIKit

class CartTableViewController: UITableViewController {
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let cartManager = CartManager.shared
    let productManager = ProductsManager.shared
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    lazy var itemPriceFormatter: NumberFormatter = {
        let itemPriceFormatter = NumberFormatter()
        itemPriceFormatter.usesGroupingSeparator = true
        itemPriceFormatter.numberStyle = .currency
        itemPriceFormatter.locale = Locale(identifier: Constants.LocaleConstants.ukraineLocale)
        return itemPriceFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(CartTableViewController.handleRefresh(_:)),
                                 for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        
        updateTotalPrice()
    }
    
    @IBAction func addRandomProduct(_ sender: UIBarButtonItem) {
        if productManager.numberOfProducts() > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(productManager.numberOfProducts())))
            let indexPath = IndexPath(row: randomIndex, section: 0)
            cartManager.addItem(item: CartModel(product:productManager.product(at: indexPath)))
            updateTotalPrice()
            tableView.reloadData()
        } else {
            let alert = UIAlertController.init(title: Constants.CartConstants.alertProductTitle, message: Constants.CartConstants.alertProductMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: Constants.CartConstants.alertCancelButton, style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func checkout(_ sender: UIBarButtonItem) {
        if cartManager.numberOfItemsInCart() == 0 {
            let alert = UIAlertController.init(title: Constants.CartConstants.alertCartTitle, message: Constants.CartConstants.alertCartMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: Constants.CartConstants.alertCancelButton, style: .cancel))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: Constants.SegueConstants.cartToOrderSegue, sender: sender)
            if let checkoutController = self.navigationController?.topViewController as? CheckoutViewController {
                checkoutController.checkoutListString = cartManager.itemArrayToString()
            }
        }
    }
    
    func updateTotalPrice() {
        let totalPriceString = itemPriceFormatter.string(from: cartManager.totalPriceInCart() as NSNumber)
        totalPriceLabel.text = Constants.CartConstants.totalPriceString + totalPriceString!
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        do {
            try CartFileReader.saveCartContent(at: Constants.FileConstants.cartFileName)
        } catch {
            print(error.localizedDescription)
        }
        
        refreshControl.endRefreshing()
        
        UIView.transition(with: tableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
}

extension CartTableViewController: CartTableViewCellDelegate {
    func cartTableViewCellSetQuantity(_ cell: CartTableViewCell, quantity: Int64) {
        let indexPath = IndexPath(row: cell.tag, section: 0)
        cartManager.updateItemQuantity(at: indexPath, quantity: quantity)
        updateTotalPrice()
    }
    
}

extension CartTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartManager.numberOfItemsInCart() == 0 {
            tableView.setEmptyMessage(Constants.CartConstants.emptyViewMessage)
            totalPriceLabel.isHidden = true
        } else {
            tableView.restore()
            totalPriceLabel.isHidden = false
        }
        return cartManager.numberOfItemsInCart()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdConstants.cartCellId, for: indexPath) as! CartTableViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        
        let item = cartManager.item(at: indexPath)
        let product = item?.product
        
        cell.titleLabel.text = product?.title ?? ""
        if let oldPrice = product?.oldPrice {
            cell.oldPriceLabel.isHidden = false
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: itemPriceFormatter.string(from: oldPrice as NSNumber) ?? "")
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.oldPriceLabel.attributedText = attributeString
        } else {
            cell.oldPriceLabel.isHidden = true
        }
        if let price = product?.price  {
            cell.priceLabel.text = itemPriceFormatter.string(from: NSNumber(value: price))
        } else {
            cell.priceLabel.text = ""
        }
        cell.itemImageView.downloaded(from: product?.image ?? "",tag: indexPath.row) {
            image, tag in
            if cell.tag == tag {
                cell.itemImageView.image = image
            }
        }
        cell.quantityStepper.value = Double(item?.quantity ?? 1)
        cell.quantityLabel.text = Int(cell.quantityStepper.value).description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let productAtIndex = cartManager.item(at:  indexPath)
            if let product = productAtIndex  {
                let successful = cartManager.removeProduct(item: product)
                
                if successful == true {
                    tableView.beginUpdates()
                    tableView.deleteRows(at: [indexPath], with: .right)
                    tableView.endUpdates()
                    updateTotalPrice()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 70.0
    }
}
