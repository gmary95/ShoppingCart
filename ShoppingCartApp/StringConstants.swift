struct Constants {
    struct FileConstants {
        static let fileType = "json"
        static let cartFileName = "cart"
        static let productsFileName = "products"
    }
    
    struct ErrorConstants {
        static let notFoundQuantity = "Not found quantity."
        static let incorectProduct = "Product model incorrect."
        static let notFoundProducts = "Not found products."
        static let incorrectJSON = "JSON doesn't have array of products."
        static let openError = "Couldn't open file."
    }
    
    struct CartConstants {
        static let order = "Your order:\n"
        static let orderSeparator = ",\n"
        static let alertCartTitle = "Your cart is empty"
        static let alertCartMessage = "Please add an item in your cart before you checkout."
        static let alertProductTitle = "Product list is empty"
        static let alertProductMessage = "Sorry, not found any products."
        static let alertCancelButton = "Cancel"
        static let emptyViewMessage = "Yor cart is empty :("
        static let totalPriceString  = " Total price: "
    }
    
    struct ImageNameConstants {
        static let defaultImageName = "default_photo"
    }
    
    struct FontNameConstants {
        static let defaultFontName = "TrebuchetMS"
    }
    
    struct CellIdConstants {
        static let cartCellId = "ItemTableViewCell"
    }
    
    struct LocaleConstants {
        static let ukraineLocale = "uk_UA"
    }
    
    struct SegueConstants {
        static let cartToOrderSegue = "show_order_screen"
    }
    
    struct CartJSONConstants {
        static let product = "product"
        static let quantity = "quantity"
    }
    
    struct ProductJSONConstants {
        static let id = "id"
        static let title = "title"
        static let price = "price"
        static let oldPrice = "old_price"
        static let image = "image"
    }
}
