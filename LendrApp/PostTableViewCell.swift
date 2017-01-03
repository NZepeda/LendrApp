import UIKit
import Alamofire
import AlamofireImage

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImage: CircularImage!    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postRateLabel: UILabel!

    var postImageUrl: String?
    var userImageUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initCell(title:String, rate:String, postImageUrl: String, userImageUrl: String) {
        self.postTitleLabel.text = title;
        self.postRateLabel.text = rate;
        self.postImageUrl = postImageUrl;
        self.userImageUrl = userImageUrl;
        
        setPostImage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPostImage(){
        
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)

            if let image = response.result.value {
                self.postImageView.image = image;
            }
        }
    }

}
