//
//  SongModel.swift
//  SampleUserAccount
//
//  Created by Daniel O'Leary on 3/22/24.
//

import Observation
import Foundation

// SongListViewModel from demo
@Observable final class SongModel {
	var songs = [Song]()

	func fetchSongs() async throws {
		// need the URL to fetch
		let urlString = Constants.baseURL + Endpoints.songs

		guard let url = URL(string: urlString) else {
			throw HTTPError.badURL
		}

		let songResponse: [Song] = try await HTTPClient.shared.fetch(url: url)
		/// example video used DispatchQueue.main.async
		Task {
			self.songs = songResponse
		}
	}

	// detele song
	func delete(at offsets: IndexSet) {
		offsets.forEach { index in
			guard let songID = songs[index].id else {
				return
			}

			guard let url = URL(string: Constants.baseURL + Endpoints.songs + "/\(songID)") else {
				return
			}

			Task {
				do {
					try await HTTPClient.shared.delete(at: songID, url: url)
				} catch {
					// error
				}
			}
		}
	}

}
