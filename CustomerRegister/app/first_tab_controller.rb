#
#  first_tab_controller.rb
#  Customer Register Demo App
#
#  Created by Minh Tran on 11/02/12.
#  Copyright (c) 2012 Minh Tran. All rights reserved.

class FirstTabController < UIViewController
  def init
    if super 
      self.title = "Add Person"
      self.tabBarItem.image = UIImage.imageNamed('FirstTab.png')
    end
    self
  end 
  def textFieldShouldReturn textField
    textField.resignFirstResponder
   'YES'
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    @labelName = UILabel.new
    @labelName.text = 'Name:'
    @labelName.frame = [[10,50],[250,30]]
    @labelPhone = UILabel.new
    @labelPhone.text = 'Phone:'
    @labelPhone.frame = [[10,120],[250,30]]
   

    labelCounterFrame = @labelName.frame
    labelCounterFrame.origin.y += labelCounterFrame.size.height + 10
    @textName = UITextField.alloc.initWithFrame(labelCounterFrame)
    @textName.borderStyle = UITextBorderStyleRoundedRect
    @textName.textAlignment = UITextAlignmentLeft
    @textName.text = ""
    @textName.delegate = self 
    labelCounterFrame1 = @labelPhone.frame
    labelCounterFrame1.origin.y += labelCounterFrame1.size.height + 10
    @textPhone = UITextField.alloc.initWithFrame(labelCounterFrame1)
    @textPhone.borderStyle = UITextBorderStyleRoundedRect
    @textPhone.textAlignment = UITextAlignmentLeft
    @textPhone.text = ""
    @textPhone.autocorrectionType = UITextAutocorrectionTypeNo
      
    @add_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @add_button.frame = [[100,200],[120,37]]
    @add_button.setTitle("Add To Cloud", forState:UIControlStateNormal)
    @add_button.setTitle("Add To Cloud", forState:UIControlStateHighlighted)


    @textName.autocorrectionType = UITextAutocorrectionTypeNo
    @textPhone.delegate = self  
    @textPhone.returnKeyType = UIReturnKeyDone

    view.addSubview(@labelPhone)
    view.addSubview(@labelName)
    view.addSubview(@textName)
    view.addSubview(@textPhone)
    view.addSubview(@add_button)
    @add_button.addTarget(self, action:'addDataToCloud', forControlEvents:UIControlEventTouchDown)    
  
  end

  def addDataToCloud  
    if @textPhone.text.length == 0 or @textName.text.length == 0
      viewMessage("Please input the Customer Infomation!")

    elsif checkExistPerson(@textPhone.text) == true
      viewMessage("This person already exists on Cloud!")
    else
      addPersonToCloud(@textName.text,@textPhone.text)
    end
  end
  def addPersonToCloud(name, phone)    
    person = PFObject.objectWithClassName('Person')
    person.setObject(name, forKey:'fullName')
    person.setObject(phone, forKey:'phoneNumber')
    person.save  
    viewMessage('This persons has been saved to cloud!')    
  end

  # Check the person existed on  Parse Cloud or not
  def checkExistPerson(phone)
    query = PFQuery.queryWithClassName('Person')
    query.whereKey('phoneNumber',equalTo:phone)
    data = query.findObjects
    if data.size == 1
      result = true
      else result = false
    end
    result
  end

  # Display message to user
  def viewMessage(message)
    @alert_box = UIAlertView.alloc.initWithTitle(message,
            message:"",
            delegate: nil,
            cancelButtonTitle: "ok",
            otherButtonTitles:nil)
    # Show it to the user
    @alert_box.show
  end

end 
