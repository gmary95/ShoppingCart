import SwiftyJSON

struct CartFileReader {
    static let manager = CartManager.shared
    
    static func saveCartContent(at path: String) throws {
        guard let path = Bundle.main.path(forResource: path, ofType: Constants.FileConstants.fileType) else {
            throw FileReadError(Constants.ErrorConstants.openError)
        }
        guard let jsonData = NSData(contentsOfFile:path) else {
            throw FileReadError(Constants.ErrorConstants.openError)
        }
        let json = JSON(jsonData)
        manager.clearCart()
        guard let itemsArray = json.array else {
            throw FileReadError(Constants.ErrorConstants.incorrectJSON)
        }
        for items in itemsArray {
            guard let item = items[Constants.CartJSONConstants.product].dictionary else {
                throw FileReadError(Constants.ErrorConstants.notFoundProducts)
            }
            guard let id = item[Constants.ProductJSONConstants.id]?.int64, let title = item[Constants.ProductJSONConstants.title]?.string, let price = item[Constants.ProductJSONConstants.price]?.string else {
                throw FileReadError(Constants.ErrorConstants.incorectProduct)
            }
            let product = ProductModel(id: id, title: title, price: price, oldPrice: item[Constants.ProductJSONConstants.oldPrice]?.string, image: item[Constants.ProductJSONConstants.image]?.string)
            guard let quantity = items[Constants.CartJSONConstants.quantity].int64 else {
                throw FileReadError(Constants.ErrorConstants.notFoundQuantity)
            }
            manager.addItem(item: CartModel(product: product, quantity: quantity))
        }
    }
}
