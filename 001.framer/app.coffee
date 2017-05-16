# Import file "Daily UI 001"
sketch = Framer.Importer.load("imported/Daily UI 001@1x")
{Popup, Email, EmailText, Password, PasswordText, Login1, LoginBox, Notification, X} = sketch

notificationYInitial = Notification.y - Notification.height
Notification.y = notificationYInitial
Popup.opacity = 0
Popup.scale = .95
Email.opacity = 0
Email.scale =  .9
Password.opacity = 0
Password.scale =  .9
Login1.opacity = 0
Login1.scale = .85
EmailText.opacity = 0
PasswordText.opacity = 0
# save Y Positions and move down
emailY = Email.y
emailX = Email.x
Email.y = Email.y + 15
passwordY = Password.y
passwordX = Password.x
Password.y = Password.y + 30
login1X = Login1.x
login1Y = Login1.y
Login1.y = Login1.y + 10
popupX = Popup.x
# Fades
Layer::fadeIn = ->
  this.animate
    properties: 
      opacity: 1
      scale: 1
    curve: 'ease-in-out'
    time: .2
Layer::disappear = ->
  this.animate
    properties: 
      opacity: 0
    curve: 'ease-in-out'
    time: .3
Layer::emailFade = ->
  this.animate
    properties: 
      opacity: 1
      scale : 1
      y: emailY
    curve: 'spring(150, 15, 10)'
    time: .5
    delay: .25
Layer::passwordFade = ->
  this.animate
    properties: 
      opacity: 1
      scale : 1
      y: passwordY
    curve: 'spring(100, 15, 10)'
    time: .4
    delay: .3
Layer::loginFade = ->
  this.animate
    properties: 
      opacity: 1
      scale : 1
      y: login1Y
    curve: 'spring(100, 20, 10)'
    time: .4
    delay: .35
Layer::notificationFade = ->
  this.y = notificationYInitial
  this.opacity = 0
  this.animate
    properties: 
      opacity: 1
      y: this.y + Notification.height
    curve: 'spring(100, 20, 10)'
    time: .4
    delay: .35
    
animA = new Animation Login1, 
		scale: 1.2
		options:
			time: 0.1
			curve: 'spring(200, 10, 20)'
	
animB = new Animation Login1,
	scale: 1
	options:
		time: .6
		curve: 'spring(200, 15, 10)'
		
# fade in
Popup.fadeIn()
Email.emailFade()
Password.passwordFade()
Login1.loginFade()

LoginBox.onMouseOver ->
	animA.start()
LoginBox.onMouseOut ->
	animB.start()
	
Email.onClick ->
	EmailText.fadeIn()
Password.onClick ->
	PasswordText.fadeIn()
	
LoginBox.onClick ->
	Notification.notificationFade()
	# shake password, email, login1
	shakePassA = new Animation Password, 
		x: passwordX + 12
		options:
			time: 0.1
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakePassB = new Animation Password,
		x: passwordX - 8
		options:
			time: 0.1
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakePassA.on Events.AnimationEnd, -> shakePassB.start()
	shakePassB.on Events.AnimationEnd, -> shakePassA.start()
	
    # shake email
	shakeEmailA = new Animation Email, 
		x: emailX + 8
		options:
			time: 0.11
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakeEmailB = new Animation Email,
		x: emailX - 12
		options:
			time: 0.09
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakeEmailA.on Events.AnimationEnd, -> shakeEmailB.start()
	shakeEmailB.on Events.AnimationEnd, -> shakeEmailA.start()
	
	# shake login
	shakePopupA = new Animation Popup, 
		x: popupX + 10
		options:
			time: 0.1
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakePopupB = new Animation Popup,
		x: popupX - 10
		options:
			time: 0.05
			curve: 'bezier-curve(.36,.07,.19,.97) '
	shakePopupA.on Events.AnimationEnd, -> shakePopupB.start()
	shakePopupB.on Events.AnimationEnd, -> shakePopupA.start()
	
	shakePassA.start()
	shakeEmailA.start()
	shakePopupA.start()
	Utils.delay .6, ->
		Password.animate
			properties:
				x: passwordX
			time: .2
			curve: 'spring(200, 15, 10)'
		Email.animate
			properties:
				x: emailX
			time: .2
			curve: 'spring(200, 15, 10)'
	Utils.delay .3, ->
		PasswordText.disappear()
		Popup.animate
			properties:
				x: popupX
			time: .4
			curve: 'spring(200, 15, 10)'
			
X.onClick ->
	Notification.animate
		properties:
			y: notificationYInitial
			opacity: 0
		time: .2
		curve: 'spring(200, 15, 10)'
			
# Framer.Loop.delta = 1 / 600