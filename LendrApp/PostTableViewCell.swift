import UIKit

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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
