import Foundation

struct ArtistDTO {
    let name: String
    let birthDay: Date
}

extension ArtistDTO {
    init(domain: Artist) {
        self.name = domain.name
        self.birthDay = domain.birthDay
    }
}

extension ArtistDTO {
    init(cd: CDArtist) {
        self.name = cd.name!
        self.birthDay = cd.birthDate!
    }
}
