
#
#  app_delegate.rb
#  Customer Register Demo App
#  This applicaiton will store the customer infomation to Cloud based on www.Parse.com
#  Created by Minh Tran on 11/02/12.
#  Copyright (c) 2012 Minh Tran. All rights reserved.
#    

class AppDelegate
  attr_accessor :ggdata
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #MinhTest application Id/clientKey were genarated on wwww.Parse.com
    Parse.setApplicationId("la9O8ECPS9cIrWZ3nI81Sr7koA0tH0paBe7ghJrD", clientKey:"sORzCMDAEr52qhb79vEEMzncQguFVx28nNzV5GMJ")
    application.registerForRemoteNotificationTypes(UIRemoteNotificationTypeBadge)    
    setup_initial_view
    true
  end

  def setGData(data)
    ggdata = data
  end


  def setup_initial_view
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    first_tab = FirstTabController.alloc.init
    second_tab = SecondTabController.alloc.init
    @tabbar = UITabBarController.alloc.init
    @tabbar.viewControllers = [first_tab, second_tab] 
    
    @tabbar.wantsFullScreenLayout = true
    @window.addSubview @tabbar.view
  end
end
