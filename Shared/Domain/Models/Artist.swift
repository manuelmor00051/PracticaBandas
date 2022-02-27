import Foundation

struct Artist {
    let name: String
    let birthDay: Date
}

extension Artist {
    init(dto: ArtistDTO) {
        self.name = dto.name
        self.birthDay = dto.birthDay
    }
}
