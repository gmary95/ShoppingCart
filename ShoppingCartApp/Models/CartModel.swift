import Foundation

class CartModel {
    var product: ProductModel!
    var quantity: Int64!
    
    init(product: ProductModel!, quantity: Int64 = 1) {
        self.product = product
        self.quantity = quantity
    }
}

extension CartModel: Equatable {
    static func == (lhs: CartModel, rhs: CartModel) -> Bool{
        return lhs.product == rhs.product
    }
}
