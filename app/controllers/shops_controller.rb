class ShopsController < UIViewController
  attr_accessor :shops
  extend IB

  def viewDidLoad
    super

    self.load
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
