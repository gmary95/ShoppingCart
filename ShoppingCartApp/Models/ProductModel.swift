import Foundation

class ProductModel {
    var id: Int64!
    var title: String!
    var price: Float64!
    var oldPrice: Float64?
    var image: String!
    
    init(id: Int64!, title: String!, price: String!, oldPrice: String?, image: String?) {
        self.id = id
        self.title = title
        self.price = Float64(price!)
        if let oldPrice = oldPrice {
            self.oldPrice = Float64(oldPrice)
        } else {
            self.oldPrice = nil
        }
        self.image = image ?? ""
    }
}

extension ProductModel: Equatable {
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool{
        return lhs.id == rhs.id
    }
}
