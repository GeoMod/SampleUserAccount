//
//  AddUpdateSongModel.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/22/24.
//

import Foundation
import Observation


@Observable final class AddUpdateSongModel {
	var songTitle = ""

	var songID: UUID?
	
	var isUpdating: Bool {
		songID != nil
	}
	#warning("doesn't pass in the song id because of the way Observable is setup")
	/// therefore editing doesn't work
	/// this can be worked with and fixed though.

	var buttonTitle: String {
		songID != nil ? "Update Song" : "Add Song"
	}

	init() {}

	init(currentSong: Song) {
		self.songTitle = currentSong.title
		self.songID = currentSong.id
	}

	func addSong() async throws {
		let urlString = Constants.baseURL + Endpoints.songs
		guard let url = URL(string: urlString) else {
			throw HTTPError.badURL
		}

		let song = Song(id: nil, title: songTitle)

		try await HTTPClient.shared.sendData(to: url, object: song, httpMethod: HTTPMethods.POST.rawValue)
	}

	func addUpdateAction(completion: @escaping () -> Void) {
		Task {
			do {
				if isUpdating {
					 try await updateSong()
				} else {
					try await addSong()
				}
			} catch {
				// error
			}

			completion()
		}
	}

	func updateSong() async throws {
		let urlString = Constants.baseURL + Endpoints.songs
		guard let url = URL(string: urlString) else {
			throw HTTPError.badURL
		}

		let songToUpdate = Song(id: songID, title: songTitle)

		try await HTTPClient.shared.sendData(to: url, object: songToUpdate, httpMethod: HTTPMethods.PUT.rawValue)
	}
}
