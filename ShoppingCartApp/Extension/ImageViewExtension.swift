import UIKit
import Alamofire
import AlamofireImage

let imageCache = AutoPurgingImageCache()

extension UIImageView {
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, tag: Int, completion: @escaping (UIImage?, Int) -> Void) {
        self.image = nil
        self.contentMode = mode
        if let image = imageCache.image(withIdentifier: link) {
            completion(image, tag)
        } else {
            Alamofire.request(link).responseImage { response in
                var cachedImage = UIImage(named: Constants.ImageNameConstants.defaultImageName)
                if let resultImage = response.result.value {
                    cachedImage = resultImage
                }
                
                if let image = cachedImage {
                    if  let imageData = image.resizeImage(newWidth: self.bounds.width)?.jpegData(compressionQuality: 0.8) {
                        cachedImage = UIImage(data: imageData)
                    }
                    imageCache.add(cachedImage!, withIdentifier: link)
                }
                completion(cachedImage, tag)
                
            }
        }
    }
}
