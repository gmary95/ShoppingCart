import SwiftyJSON

struct ProductsFileReader {
    static let manager = ProductsManager.shared
    
    static func saveProductContent(at path: String) throws {
        guard let path = Bundle.main.path(forResource: path, ofType: Constants.FileConstants.fileType) else {
            throw FileReadError(Constants.ErrorConstants.openError)
        }
        guard let jsonData = NSData(contentsOfFile:path) else {
            throw FileReadError(Constants.ErrorConstants.openError)
        }
        let json = JSON(jsonData)
        guard let itemsArray = json.array else {
            throw FileReadError(Constants.ErrorConstants.incorrectJSON)
        }
        for item in itemsArray {
            guard let id = item[Constants.ProductJSONConstants.id].int64, let title = item[Constants.ProductJSONConstants.title].string, let price = item[Constants.ProductJSONConstants.price].string  else {
                throw FileReadError(Constants.ErrorConstants.incorectProduct)
            }
            let product = ProductModel(id: id, title: title, price: price, oldPrice: item[Constants.ProductJSONConstants.oldPrice].string, image: item[Constants.ProductJSONConstants.image].string)
            manager.addProduct(product: product)
            
        }
    }
}
