# Import file "002"
psd3 = Framer.Importer.load("imported/002@1x")

{Front, FrontCard, Back, NumberBar, Number, MonthField, Month, YearField, Year, CVCBar, CVC} = psd3

Number.style.mixBlendMode = "screen"
Number.opacity = 0
Month.opacity = 0
Year.opacity = 0
CVC.opacity = 0
frontX = Front.x
frontY = Front.y
Front.center()
Front.opacity = 0

Back.opacity = 0
backX = Back.x
backY = Back.y
Back.x = Front.x + 15
Back.y = Front.y

# Fades
Layer::fadeIn = ->
  this.animate
    properties: 
      opacity: 1
    curve: 'ease-out'
    time: .6
Layer::jump = ->
	this.y = this.y + 20
	this.animate
		properties:
			y: this.y - 20
		curve: 'spring(150, 15, 10)'
		
Utils.delay 1, ->
	Front.fadeIn()
	FrontCard.jump()
shouldSplit = ->
	Number.opacity != 0 && Month.opacity != 0 && Year.opacity != 0

trySplit =  ->
	if !shouldSplit()
		return
	Utils.delay .05, ->
		Back.fadeIn()
		Back.animate
			properties:
				x: backX
				y: backY
			curve: 'spring(150, 15, 10)'
		Front.animate
			properties:
				x: frontX
				y: frontY
			curve: 'spring(140, 15, 8)'
		
NumberBar.onClick ->
	anim = Number.fadeIn()
	anim.onAnimationEnd ->
		trySplit
MonthField.onClick ->
	anim = Month.fadeIn()
	anim.onAnimationEnd ->
		trySplit()
YearField.onClick ->
	anim = Year.fadeIn()
	anim.onAnimationEnd ->
		trySplit()
CVCBar.onClick ->
	CVC.fadeIn()