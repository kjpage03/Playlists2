//
//  SongList.swift
//  PlaylistsProjectlaylists
//
//  Created by Kaleb Page on 2/11/21.
//

import SwiftUI

struct SongList: View {
    
    @EnvironmentObject var playlistController: PlaylistController
    @EnvironmentObject var controller: MusicController
    @EnvironmentObject var themeController: ThemeController
    @State var specialID = String()
    @State var selection: String? = nil
    @Environment(\.presentationMode) var presentationMode


    var playlist: Playlist
    
    init(playlist: Playlist) {
        self.playlist = playlist
        UITableView.appearance().backgroundColor = playlist.theme.bgColor.uiColor
    }
    
    var body: some View {
        
        List {
                ForEach(playlist.songs!) { song in
                    
                    ZStack {
                        
                        SongRow(specialID: $specialID, showsButton: false, textColor: Color(playlist.theme.acColor.uiColor), song: song)
                            .padding(5)
                            .onTapGesture {
                                self.controller.items.removeAll()
                                self.controller.items.insert(song, at: 0)
                                self.controller.play()
                                self.selection = song.id
//                                presentationMode.wrappedValue.dismiss()
                            }

                        
//                        NavigationLink(destination: PlayView(), tag: song.id,selection: $selection) {
//                            //SongRow(song: song)
//                            //.padding(5)
//                            EmptyView()
//                        }
//                        .opacity(0)
//                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    
                }
                .onDelete(perform: { indexSet in
                    
                    for (index, item) in playlistController.items.enumerated() {
                        if self.playlist.id == item.id {
                            playlistController.items[index].songs?.remove(atOffsets: indexSet)
                        }
                    }
                    
                })
                .listRowBackground(Color(playlist.theme.bgColor.uiColor))
                
            }
    }
}

//struct SongList_Previews: PreviewProvider {
//    static var previews: some View {
//        SongList(playlist: Playlist.testPlaylist)
//    }
//}
