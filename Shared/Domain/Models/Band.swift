import Foundation

struct Band {
    let name: String
    let members: [Artist]
    let albums: [Album]
}

extension Band: Identifiable {
    var id: String {
        name
    }
}

extension Band {
    init(dto: BandDTO) {
        self.name = dto.name
        var membersList: [Artist] = []
        var albumsList: [Album] = []
        
        dto.members.forEach { currentArtistDto in
            membersList.append(Artist(dto: currentArtistDto))
        }
        self.members = membersList
        
        dto.albums.forEach { currentAbumDTO in
            albumsList.append(Album(dto: currentAbumDTO))
        }
        
        self.albums = albumsList
        
    }
}

extension Band {
    func bandName() -> String {
        name
    }
    
    func bandMembers() -> String {
        let membersNames = members.map { currentMember in
            currentMember.name
        }
        
        let formattedMembersNames = membersNames.joined(separator: ", ")
        return formattedMembersNames
    }
    
    func albumsNames() -> String {
        let albumsNames = albums.map { currentAlbum in
            currentAlbum.name
        }
        
        let formattedAlbumsNames = albumsNames.joined(separator: ", ")
        return formattedAlbumsNames
    }
}

