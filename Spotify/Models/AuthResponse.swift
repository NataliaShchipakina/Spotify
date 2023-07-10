//
//  AuthResponse.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 05.07.2023.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}

//{
//    "access_token" = "BQBRSKki4a8X7l3_qMCiV-ghogJQ9cyxup36T07TIP80V72XVINVOTPuxOHJSlm5UiMRPfFbkODa51FxfMsezpqu5ik2CU3ZD1XvxwIBxaJb1FrzcuvjdCD3wpKqJQ1tDvDtHVh7DeP43lpi6Xk7BW7emdmuAFrK9W3rXO4-pcBO33mHrpl-41XWRfY8vXbx3rvqsDUkUEy-4K9pc-U";
//    "expires_in" = 3600;
//    "refresh_token" = "AQCl3mufPipH4JbwDhj_EEgRlmaUtH3eVi0HRICgzfw1HNwfQY17vn_8Wdp-zSpYujRQ8iLpZEWw0eIGTOUZk4ElM7nZCQS3fbiU9ZqhEEukcLm7XBBO1SM0uRrAEh9BUjs";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}
