import Foundation

struct BandDTO {
    let id: String
    let name: String
    let members: [ArtistDTO]
    let albums: [AlbumDTO]
}

extension BandDTO {
    init(domain: Band) {
        self.id = domain.id
        self.name = domain.name
        self.members = domain.members.map { currentArtist in
            ArtistDTO(domain: currentArtist)
            }
        self.albums = domain.albums.map { currentAlbum in
            AlbumDTO(domain: currentAlbum)
        }
    }
}

extension BandDTO {
    init(cd: CDBand) {
        self.id = cd.id ?? ""
        self.name = cd.name ?? ""
        let retrieveArray = cd.members?.allObjects ?? []
        let retrieveAlbum = cd.albums?.allObjects ?? []
        
        let cdArtistArray = retrieveArray.compactMap { currentAny in
            currentAny as? CDArtist
        }
        
        let cdAlbumArray = retrieveAlbum.compactMap { currentAny in
            currentAny as? CDAlbum
        }
        
        self.members = cdArtistArray.map { currentCDArtist in
            ArtistDTO(cd: currentCDArtist)
        }
        
        self.albums = cdAlbumArray.map { currentCDAlbum in
            AlbumDTO(cd: currentCDAlbum)
        }
        
    }
}
