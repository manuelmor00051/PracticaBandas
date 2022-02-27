import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var viewModel = BandsViewModel()
    
    private let membersNames =  ["Mark Knopfler", "Jose Muñoz", "Mick Jagger", "Freddy Mercury", "Jose Muñoz"]
    
    private let bandsNames = ["Dire Straits", "The Rolling Stones", "Queen", "Estopa"]
    
    private let albumsNames = ["Alchemhy live", "Destrangis", "Bohemian Rhapsody", "Out of our heads"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.bands) { band in
                    NavigationLink {
                        Text("Artístas: \(band.bandMembers())")
                        Spacer()
                        Text("Albums: \(band.albumsNames())")
                        Spacer()
                    } label: {
                        Text(band.bandName())
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Bandas")
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSavedBands()
        }
        Button("Borrar Bandas") {
            viewModel.removeAllBands()
        }
        .font(.system(.title2))
        .foregroundColor(.red)
    }
    
    private func addItem() {
        withAnimation {
            let nameIndex = Int.random(in: 0..<4)
            let memberOneIndex = Int.random(in: 0..<5)
            let memberTwoIndex = Int.random(in: 0..<5)
            
            let albumOneIndex = Int.random(in: 0..<4)
            let albumTwoIndex = Int.random(in: 0..<4)
            
            let members = [Artist(name: "\(membersNames[memberOneIndex])", birthDay: Date()),
                           Artist(name: "\(membersNames[memberTwoIndex])", birthDay: Date())]
            
            let albums = [Album(name: "\(albumsNames[albumOneIndex])", image: "album 1"), Album(name: albumsNames[albumTwoIndex], image: "album2")]
            
            
            let newBand = Band(name: bandsNames[nameIndex], members: members, albums: albums) //borrar album
            viewModel.saveBand(band: newBand)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let bandsToRemove = offsets.map {
                viewModel.bands[$0].id
            }
            
            viewModel.deleteBands(bandIds: bandsToRemove)
        }
        
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    /*
     struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
     ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
     }
     }
     }
     */
    
}
