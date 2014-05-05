class ShopController < UIViewController
  attr_accessor :shops
  extend IB
  outlet :go_shop, UIButton

  def viewDidLoad
    super

    @index = 0
    @shops = shops
    @shop = shops[@index]

    _displayShop

    @left_swipe = view.when_swiped do
      _pushShop
    end
    @left_swipe.direction = UISwipeGestureRecognizerDirectionLeft

    @right_swipe = view.when_swiped do
      _pullShop
    end
    @right_swipe.direction = UISwipeGestureRecognizerDirectionRight

#    @down_swipe = view.when_swiped do
#            self.reload
#    end
#    @down_swipe.direction = UISwipeGestureRecognizerDirectionDown
  end

  def _displayShop
    @title = UITextView.alloc.initWithFrame(CGRectMake(40, 40, 240, 30))
    @title.font = UIFont.boldSystemFontOfSize(10)
    @title.textAlignment = UITextAlignmentCenter
    @title.opaque = false
    @title.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.0)
    @title.text = @shop.name
    @title.editable = false
    view.addSubview(@title)

    @category = UITextView.alloc.initWithFrame(CGRectMake(40, 60, 240, 30))
    @category.font = UIFont.boldSystemFontOfSize(9)
    @category.textAlignment = UITextAlignmentCenter
    @category.opaque = false
    @category.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.0)
    @category.text = @shop.category + " / " + @shop.access[0]['station']
    @category.editable = false
    view.addSubview(@category)

    @opentime = UITextView.alloc.initWithFrame(CGRectMake(40, 80, 240, 30))
    @opentime.font = UIFont.boldSystemFontOfSize(9)
    @opentime.textAlignment = UITextAlignmentLeft
    @opentime.opaque = false
    @opentime.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.0)
    @opentime.text = "営業時間:" + @shop.opentime
    @opentime.editable = false
    view.addSubview(@opentime)

    @holiday = UITextView.alloc.initWithFrame(CGRectMake(40, 100, 240, 30))
    @holiday.font = UIFont.boldSystemFontOfSize(9)
    @holiday.textAlignment = UITextAlignmentLeft
    @holiday.opaque = false
    @holiday.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.0)
    @holiday.text = "休日:" + @shop.holiday
    @holiday.editable = false
    view.addSubview(@holiday)

    @budget = UITextView.alloc.initWithFrame(CGRectMake(40, 120, 240, 30))
    @budget.font = UIFont.boldSystemFontOfSize(9)
    @budget.textAlignment = UITextAlignmentLeft
    @budget.opaque = false
    @budget.backgroundColor = UIColor.colorWithWhite(1.0, alpha:0.0)
    @budget.text = "予算:" + @shop.budget + "円"
    @budget.editable = false
    view.addSubview(@budget)

    image_data = NSData.dataWithContentsOfURL(NSURL.URLWithString(@shop.image_url))
    @image = UIImageView.alloc.initWithImage(UIImage.imageWithData(image_data))
    @image.center = CGPointMake(view.frame.size.width / 2, 140)
    view.addSubview @image
  end

  def _removeShop
    @title.removeFromSuperview
    @category.removeFromSuperview
    @opentime.removeFromSuperview
    @holiday.removeFromSuperview
    @budget.removeFromSuperview
    @image.removeFromSuperview
  end

  def _pushShop
    if @index < @shops.count - 1
      @index = @index + 1
      @shop = shops[@index]
      _removeShop
      _displayShop
    else
      _show_no_shop
    end
  end

  def _pullShop
    if @index > 0
      @index = @index - 1
      @shop = shops[@index]
      _removeShop
      _displayShop
    else
      _show_no_shop
    end
  end

  def _show_no_shop
    alert = UIAlertView.new
    alert.message = "あなたにおすすめするお店は\nもうありません"
    alert.delegate = self
    alert.addButtonWithTitle "了解"
    alert.show
  end

  def changeShop

    _pushShop
  end
end
