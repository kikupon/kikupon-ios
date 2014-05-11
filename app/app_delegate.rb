class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'


    #ApplicationUser.sharedUser.load
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    storyboard = UIStoryboard.storyboardWithName('Main', bundle: nil)

    @window.rootViewController = storyboard.instantiateInitialViewController
    @window.makeKeyAndVisible

    true
  end
end
