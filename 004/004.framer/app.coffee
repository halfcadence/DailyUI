# Import file "004"
sketch = Framer.Importer.load("imported/004@1x")
{TextLayer} = require 'TextLayer'
{NoHz, NoNoteName, Hz, NoteName, Dongle, Box, GreenDongle, GreenBox, GreyBox, HappyCircle} = sketch

Box.opacity = 0
Hz = Hz.convertToTextLayer()
Hz.text = "0.3"
Hz.y = 359
Hz.opacity = 0
NoteName.opacity = 0
Dongle.opacity = 0
Dongle.originY = 1
GreenDongle.opacity = 0
GreenDongle.originY = 1
GreenDongle.rotationZ = 10
GreenBox.opacity = 0
NoHz.opacity = 0
NoNoteName.opacity = 0

Layer::fadeIn = (time = 1.5) ->
  this.animate
    properties: 
      opacity: 1
      scale: 1
    curve: 'ease-out'
    time: time

Layer::fadeOut = (time = 1.5) ->
  this.animate
    properties: 
      opacity: 0
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
		curve: 'spring(100, 15, 10)'
		time: time

Layer::fadeUp = (time = 1.5) ->
	this.fadeIn(time)
	this.y = this.y + 50
	this.slide("up", time)
Layer::fadeLeft = (time = 1.5) ->
	this.fadeIn()
	this.x = this.x + 50
	this.slide("left", time)
Layer::fadeRight = (time = 1.5) ->
	this.fadeIn()
	this.x = this.x - 50
	this.slide("right", time)
Layer::fadeDown = (time = 1.5) ->
	this.fadeIn()
	this.y = this.y - 50
	this.slide("down", time)	

Utils.delay .5, ->
	Utils.delay .1, ->
		NoNoteName.fadeUp()
		NoHz.fadeUp()
		Utils.delay 1, ->
			GreyBox.fadeOut(.2)
			Box.fadeIn(.2)
			Dongle.fadeIn(.2)
			NoteName.fadeIn(.2)
			NoNoteName.fadeOut(.2)
			Hz.fadeIn(.2)
			NoHz.fadeOut(.2)
			Dongle.rotationZ = -90
			rotate = new Animation Dongle,
				rotationZ: 10
				options:
					curve: 'spring(100, 15, 10)'
			rotate.start()
			Utils.delay 1, ->
				rotate = new Animation Dongle,
				rotationZ: 0
				options:
					curve: 'spring(100, 15, 10)'
				rotate2 = new Animation GreenDongle,
				rotationZ: 0
				options:
					curve: 'spring(100, 15, 10)'
				rotate.start()
				rotate2.start()
				Hz.text = "0.0"
				Box.fadeOut(.2)
				GreenBox.fadeIn(.2)
				GreenDongle.fadeIn(.2)
				Dongle.fadeOut(.2)

			