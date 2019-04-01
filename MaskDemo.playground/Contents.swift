import UIKit
import PlaygroundSupport

// As per https://stackoverflow.com/questions/36758946/reverse-layer-mask-for-label

class InvertedMaskLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        CGContext.saveGState(context)
        UIColor.white.setFill()
        UIRectFill(rect) // fill bounds w/opaque color
        context.setBlendMode(.clear)
        super.drawText(in: rect) // draw text using clear blend mode, ie: set *all* channels to 0
        CGContext.restoreGState(context)
    }
}

class TestView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        let image = UIImage(named: "tr")
        let imageView = UIImageView(image: image)
        addSubview(imageView)
        
        let label = InvertedMaskLabel()
        label.text = "Teddy"
        label.frame = imageView.bounds
        label.font = UIFont.systemFont(ofSize: 30)
        imageView.mask = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let testView = TestView()
testView.frame = CGRect(x: 0, y: 0, width: 400, height: 500)
PlaygroundPage.current.liveView = testView
