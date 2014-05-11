class LoginViewController < UIViewController
  extend IB
  outlet :fb_login_button, UIButton

  attr_accessor :delegate

  def viewDidLoad
    super
  end

  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFavorites, tag: 1)
    self
  end
  # type :twitter or :facebook
  def getSocialInfo(type)
    if type == :twitter
      service_type = SLServiceTypeTwitter
      options = nil
    elsif type == :facebook
      service_type = SLServiceTypeFacebook
      options = {ACFacebookAppIdKey       => '502871253164373',
                 ACFacebookPermissionsKey => ['email'],
                }
    else
      raise "undefined type"
    end
    if !SLComposeViewController.isAvailableForServiceType service_type
      controller = SLComposeViewController.composeViewControllerForServiceType(service_type)
      controller.view.hidden = TRUE
      self.presentViewController(controller, animated:FALSE, completion:nil)
    else
      connectSocial type, options
    end
  end
  def getTwitterInfo
    getSocialInfo :twitter
  end
  def getFacebookInfo
    getSocialInfo :facebook
  end
  def connectSocial(type, options)
    if type == :twitter
      account_type = ACAccountTypeIdentifierTwitter
    elsif type == :facebook
      account_type = ACAccountTypeIdentifierFacebook
    else
      raise "undefined type"
    end
    @account_store = ACAccountStore.new
    @account_type = @account_store.accountTypeWithAccountTypeIdentifier(account_type);
    user_id = ""
    user_name = ""
    completion = lambda do |granted, error|
      if granted
        accounts = @account_store.accountsWithAccountType(@account_type)
        anAccount = accounts.lastObject
        user_id = anAccount.valueForKeyPath("properties.uid")
        NSLog("#{user_id}")
        user_name = anAccount.username
        NSLog("#{user_name}")
        user = ApplicationUser.sharedUser
        user.twitter_user_id = user_id
        user.user_name = user_name
        user.save
        NSLog("login success")
        proceedNextPage
      else
        NSLog("error: #{error.description}")
      end
    end
    @account_store.requestAccessToAccountsWithType(@account_type, options: options, completion: completion)
  end
  def proceedNextPage
    delegate.dismissViewControllerAnimated(false, completion: nil)
  end
  def viewWillDisappear(animated)
    delegate.load
  end
end
