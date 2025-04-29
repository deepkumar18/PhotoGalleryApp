import UIKit

class PhotoCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let loader = UIActivityIndicatorView(style: .medium)
    private var currentImageURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(loader)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        loader.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        loader.stopAnimating()
        currentImageURL = nil
    }

    func configure(with photo: PicsumPhoto) {
        guard let url = URL(string: photo.download_url ?? "") else { return }


        currentImageURL = url

        if let cachedImage = ImageCacheManager.shared.image(for: url as NSURL) {
            imageView.image = cachedImage
            loader.stopAnimating()
            return
        }

        imageView.image = nil
        loader.startAnimating()

        // Perform background download and decoding
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self, let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.loader.stopAnimating()
                }
                return
            }

            // Decode image off the main thread
            DispatchQueue.global(qos: .userInitiated).async {
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.loader.stopAnimating()
                    }
                    return
                }

                ImageCacheManager.shared.setImage(image, for: url as NSURL)

                // Return to main thread for UI update
                DispatchQueue.main.async {
                    // Make sure the cell hasn't been reused
                    if self.currentImageURL == url {
                        self.imageView.image = image
                    }
                    self.loader.stopAnimating()
                }
            }
        }.resume()
    }
}
