#
#  second_tab_controller.rb
#  Customer Register Demo App
#
#  Created by Minh Tran on 11/02/12.
#  Copyright (c) 2012 Minh Tran. All rights reserved.

class SecondTabController < UIViewController
  attr_accessor :data
  def init
    if super 
    self.data = []
    self.data = getPeopleOnCloud
    self.title = "List People"
    self.tabBarItem.image = UIImage.imageNamed('SecondTab.png')
    end
    self
  end 
  def viewDidLoad
    super
    view.backgroundColor = UIColor.whiteColor
    @listPeople = UITableView.alloc.initWithFrame(view.bounds, style:UITableViewStylePlain)
    @listPeople.dataSource = self
    @listPeople.delegate = self
    @listPeople.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight

    @refresh_button = UIButton.buttonWithType(UIButtonTypeRoundedRect) 
    @refresh_button.frame = [[210,370],[100,37]]
    @refresh_button.setTitle("Refresh", forState:UIControlStateNormal)
    @refresh_button.setTitle("Refresh", forState:UIControlStateHighlighted)
    @refresh_button.addTarget(self, action:'refreshData', forControlEvents:UIControlEventTouchDown)   
 
    view.addSubview(@listPeople)
    view.addSubview(@refresh_button)
  end

  # Refresh data when user click.
  def refreshData 
    self.data = []
    self.data = getPeopleOnCloud
    @listPeople.reloadData
  end

  def viewDidUnload
    @listPeople = nil
  end

  # Required for TableView datasource protocol
  # Sets the number of sections for the tableView
  def numberOfSectionsInTableView(tableView)
    result = 0
    if (tableView == @listPeople)
        result = self.data.size
    end
    result
  end

  # responding to user interaction
  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    aitem = self.data[indexPath.section]
    fullName = aitem.objectForKey('fullName')
    phoneNumber = aitem.objectForKey('phoneNumber') 
    personInfo = "Name: #{fullName} \n Phone: #{phoneNumber}"
    viewMessage(personInfo)
  end

  # Sets the number of rows in each section
  def tableView(tableView, numberOfRowsInSection:section)
    result = 1
    result
  end

  # Modifies each cell
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    result = nil
    if(tableView == @listPeople)
      tableViewCellIdentifier = "CellInfo"
      result = tableView.dequeueReusableCellWithIdentifier(tableViewCellIdentifier)
      if(result == nil)
        result = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:tableViewCellIdentifier)
      end
    aitem = self.data[indexPath.section]
    fullName = aitem.objectForKey('fullName')
    phoneNumber = aitem.objectForKey('phoneNumber') 
    result.textLabel.text = "#{fullName}-#{phoneNumber}"
    end
    result
  end

  # Get people from Parse cloud
  def getPeopleOnCloud
    query = PFQuery.queryWithClassName('Person')
    data = query.findObjects
    result = data
    result
  end

  # Display the message to user
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

