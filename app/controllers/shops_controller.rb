class ShopsController < UIViewController
  attr_accessor :shops
  extend IB

  def viewDidAppear(animated)
    super(animated)

    user = ApplicationUser.sharedUser
    if !user.is_logined
        self.show_login_view
    end
  end

  def show_login_view
    storyboard = UIStoryboard.storyboardWithName("Account", bundle: nil)
    vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewController")
    vc.setModalPresentationStyle(UIModalPresentationFullScreen)
    vc.delegate = self
    self.presentViewController(vc,  animated: true, completion: nil)
  end

  def viewDidLoad
    super

    user = ApplicationUser.sharedUser
    if user.is_logined
        NSLog(user.user_id)
        self.load
    end
  end

  def load
    @user_id = '1234'
    BW::Location.get_once do |location|
      @lat = location.coordinate.latitude
      @lng = location.coordinate.longitude
      KikuponAPI::Client.fetch_recommended_shops(@user_id, @lat, @lng) do |shops, error_message|
        if error_message.nil?
          @shops = shops
          performSegueWithIdentifier('to_shop', sender:self)
        else
          p error_message
        end
      end
    end
  end

  def prepareForSegue(segue, sender:sender)

    shopController = segue.destinationViewController
    shopController.shops = @shops
  end
end
