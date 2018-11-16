import UIKit

class CartManager {
    private static var instance: CartManager?
    var itemArray: Array<CartModel> = []
    
   static let shared: CartManager = CartManager()
    
    private init() {}
    
    func addItem(item: CartModel) {
        if let index = itemArray.index(of: item) {
            itemArray[index].quantity += 1
        } else {
            itemArray.append(item)
        }
    }
    
    func removeProduct(item: CartModel) -> Bool {
        if let index = itemArray.index(of: item) {
                itemArray.remove(at: index)
                return true
            }
        
        return false
    }
    
    func clearCart() {
        itemArray.removeAll(keepingCapacity: false)
    }
    
    func numberOfItemsInCart() -> Int {
        return itemArray.count
    }
    
    func totalPriceInCart() -> Double {
        var totalPrice: Double = 0
        for item in itemArray {
            totalPrice += (item.product.price * Double(item.quantity))
        }
        return totalPrice
    }
    
    func item(at indexPath: IndexPath) -> CartModel? {
        if indexPath.row < itemArray.count {
            return itemArray[indexPath.row]
        } else {
            return nil
        }
    }
    
    func updateItemQuantity(at indexPath: IndexPath, quantity: Int64) {
        itemArray[indexPath.row].quantity = quantity
    }
    
    func itemArrayToString() -> String {
        let str = itemArray.map { (item) -> String in
            return item.product.title
            }.joined(separator: Constants.CartConstants.orderSeparator)
        return str
    }
}
