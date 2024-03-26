//
//  AddUpdateSong.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/22/24.
//

import SwiftUI

struct AddUpdateSong: View {
	@Environment(\.dismiss) var dismiss

	/// Using this model type doesn't allow editing
	/// Setup was done as a refresher to Vapor
	@State private var songModel = AddUpdateSongModel()

	let currentSong: Song?

    var body: some View {
		VStack {
			TextField("Add or Update Song", text: $songModel.songTitle)
				.textFieldStyle(.roundedBorder)
				.scenePadding()

			Button(action: {
				songModel.addUpdateAction {
					dismiss()
				}
			}, label: {
				Text(songModel.buttonTitle)
			})
		}
    }
}

#Preview {
	AddUpdateSong(currentSong: nil)
}
