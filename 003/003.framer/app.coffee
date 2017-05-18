# Import file "003"
sketch = Framer.Importer.load("imported/003@1x")

{SSM, ServiceTime, About, Ministries, Contact, AboutLine, MinistriesLine, ContactLine, SmallBox, LargeBox} = sketch

SSM.opacity = 0
SSM.rotationZ = 180
ServiceTime.opacity = 0
About.opacity = 0
Ministries.opacity = 0
MinistriesLine.rotationZ = 180
Contact.opacity = 0

SmallBox.opacity = 0

Layer::fadeIn = (time = 1.5) ->
  this.animate
    properties: 
      opacity: 1
      scale: 1
    curve: 'ease-out'
    time: time
    
Layer::slide = (direction, time = .5) ->
	deltaX = 0
	deltaY = 0
	switch direction
		when "left", null then deltaX = -50
		when "right" then deltaX = 50
		when "up" then deltaY = -50
		when "down" then deltaY = 50
		else print "invalid slide direction"
	this.animate
		properties:
			x: this.x + deltaX
			y: this.y + deltaY
		curve: 'ease-in-out'
		time: time

Layer::fadeUp = ->
	this.fadeIn()
	this.y = this.y + 50
	this.slide("up")
Layer::fadeLeft = ->
	this.fadeIn()
	this.x = this.x + 50
	this.slide("left")
Layer::fadeRight = ->
	this.fadeIn()
	this.x = this.x - 50
	this.slide("right")
Layer::fadeDown = ->
	this.fadeIn()
	this.y = this.y - 50
	this.slide("down")	
Layer::spin = ->
	endRotation = 0
	if (this.rotationZ == 0)
		endRotation = 180
	this.animate
		properties: 
			rotationZ: endRotation
		curve: 'spring(100, 20, 15)'
		delay: .2
Utils.delay .5, ->	
	SmallBox.fadeIn()
	SSM.fadeIn()
	
	Utils.delay .25, ->	
		ServiceTime.fadeLeft()
		Utils.delay 1, ->
			About.fadeDown()
			Ministries.fadeRight()
			Contact.fadeUp()
			AboutLine.spin()
			MinistriesLine.spin()
			ContactLine.spin()
			SSM.spin()
				
