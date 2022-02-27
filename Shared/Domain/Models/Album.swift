import Foundation
import SwiftUI

struct Album {
    let name: String
    let image: String
}

extension Album {
    init(dto: AlbumDTO) {
        self.name = dto.name
        self.image = dto.image
    }
}

