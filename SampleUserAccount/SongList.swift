//
//  ContentView.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/20/24.
//

import SwiftUI
import Observation

struct SongList: View {
	@State private var songModel = SongModel()
	@State private var modal: ModalType?

    var body: some View {
        NavigationStack {
			List {
				ForEach(songModel.songs) { song in
					Button {
						modal = .update(song)
					} label: {
						Text(song.title)
							.font(.title3)
							.foregroundStyle(Color(.label))
					}
				}.onDelete(perform: songModel.delete)
			}
			.toolbar {
				Button {
					modal = .add
				} label: {
					Label("Add Song", systemImage: "plus.circle.fill")
				}

			}
			.navigationTitle("Songs")
        }
		.sheet(item: $modal) {
			Task {
				do {
					try await songModel.fetchSongs()
				} catch {
					// error
				}
			}
		} content: { modal in
			switch modal {
				case .add:
					AddUpdateSong(currentSong: nil)
				case .update(let song):
					AddUpdateSong(currentSong: song)
			}
		}
		.onAppear {
			Task {
				do {
					try await songModel.fetchSongs()
				} catch {
					print("Error thrown")
				}
			}
		}
        .padding()
    }
}

#Preview {
    SongList()
}

