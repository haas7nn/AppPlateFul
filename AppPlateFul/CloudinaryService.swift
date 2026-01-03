import UIKit
import Cloudinary

final class CloudinaryService {
    static let shared = CloudinaryService()

    private let cloudinary: CLDCloudinary
    private let uploadPreset = "ios_donation_upload" // your preset name

    private init() {
        let config = CLDConfiguration(
            cloudName: "YOUR_CLOUD_NAME", // <- replace
            secure: true
        )
        self.cloudinary = CLDCloudinary(configuration: config)
    }

    /// Uploads a UIImage and returns the remote URL string, or error.
    func upload(image: UIImage,
                completion: @escaping (Result<String, Error>) -> Void) {

        guard let data = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "CloudinaryService",
                                        code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }

        let params = CLDUploadRequestParams()
            .setFolder("donations")  // optional: keep images in 'donations/' folder

        cloudinary.createUploader().upload(
            data: data,
            uploadPreset: uploadPreset,
            params: params,
            progress: nil
        ) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Check Cloudinary docs for exact property name if needed.
            if let secureUrl = result?.secureUrl {
                completion(.success(secureUrl))
            } else if let url = result?.url {
                completion(.success(url))
            } else {
                let err = NSError(domain: "CloudinaryService",
                                  code: -2,
                                  userInfo: [NSLocalizedDescriptionKey: "No URL returned from Cloudinary"])
                completion(.failure(err))
            }
        }
    }
}
