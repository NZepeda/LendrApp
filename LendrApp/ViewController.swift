import UIKit
import AWSCore
import AWSS3

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Configure AWS Cognito Credentials
        let myIdentityPoolId = "us-east-1:5c5d23b1-154b-48b5-9ecc-0d553acc3065"
        
        let credentialsProvider:AWSCognitoCredentialsProvider = AWSCognitoCredentialsProvider(regionType:AWSRegionType.usEast2, identityPoolId: myIdentityPoolId)
        
        let configuration = AWSServiceConfiguration(region:AWSRegionType.usEast2, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        // Set up AWS Transfer Manager Request
        let S3BucketName = "lendr-post-images"
        let ext = "jpeg"
        let localFileName = "playlist-interface" // local file name here
        let remoteName = localFileName + "." + ext
        //let fileName = NSUUID().UUIDString + "." + ext
        let imageURL = Bundle.main.url(forResource: localFileName, withExtension: ext)!
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = imageURL
        uploadRequest?.key = remoteName
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentType = "image/" + ext
        
        let transferManager = AWSS3TransferManager.default()
        
        // Perform file upload
        transferManager?.upload(uploadRequest).continue({ (task:AWSTask) -> Any? in
            
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
            }
            
            if let exception = task.exception {
                print("Upload failed with exception (\(exception))")
            }
            
            if task.result != nil {
                
                let s3URL = URL(string: "https://s3.amazonaws.com/\(S3BucketName)/\(uploadRequest!.key!)")!
                print("Uploaded to:\n\(s3URL)")
                
                // Read uploaded image and display in a view
                let imageData = NSData(contentsOf: s3URL as URL)
                
                if let downloadedImageData = imageData
                {
                    DispatchQueue.main.async {
                        let image = UIImage(data: downloadedImageData as Data)
                        let myImageView:UIImageView = UIImageView()
                        myImageView.frame = CGRect(x:10, y:100, width:25, height:25)
                        myImageView.image = image
                        myImageView.contentMode = UIViewContentMode.scaleAspectFit
                        
                        self.view.addSubview(myImageView)
                    }
                }
            }
            else {
                print("Unexpected empty result.")
            }
            return nil
        })
        
    }
}
