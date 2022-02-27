import Foundation
import UIKit

struct AlbumDTO {
    let name: String
    let image: String
}

extension AlbumDTO {
    init(domain: Album) {
        self.name = domain.name
        self.image = domain.image
    }
}

extension AlbumDTO {
    init(cd: CDAlbum) {
        self.name = cd.name!
        self.image = cd.image!
    }
}
