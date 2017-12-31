//
//  PresentPopUp.swift
//  NewsApi
//
//  Created by Özcan AKKOCA on 27.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

import UIKit

extension PopUpPresentable where Self: UIViewController {
    /// EKrana uyarı mesajı çıkartır.
	func presentPopUp() {
		let networkUnavailableAlert = UIAlertController(title: "Network Unavailable",
		                                                message: "Your network connection seems to be offline.",
		                                                preferredStyle: .alert)
		
		let dismissAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		networkUnavailableAlert.addAction(dismissAction)
		
		let settingsAction = UIAlertAction(title: "Settings", style: .default) { action in
			guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else { return }
			
			if UIApplication.shared.canOpenURL(settingsURL) {
				UIApplication.shared.open(settingsURL, options: [:]) { completed in
					print("Settings opened.")
				}
			}
		}
		networkUnavailableAlert.addAction(settingsAction)
		
		present(networkUnavailableAlert, animated: true, completion: nil)
	}
}
