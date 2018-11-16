import UIKit

class ProductsManager {
    private static var instance: ProductsManager?
    var productArray: Array<ProductModel> = []
    
    static let shared: ProductsManager = ProductsManager()
    
    private init() {}
    
    func addProduct(product: ProductModel) {
        productArray.append(product)
    }
    
    func removeProduct(product: ProductModel) -> Bool {
        if let index = productArray.index(of: product) {
            productArray.remove(at: index)
            return true
        }
        
        return false
    }
    
    func numberOfProducts() -> Int {
        return productArray.count
    }
    
    func product(at indexPath: IndexPath) -> ProductModel? {
        if indexPath.row < productArray.count {
            return productArray[indexPath.row]
        } else {
            return nil
        }
    }
}
