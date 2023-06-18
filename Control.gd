extends Control

const VU_COUNT:int = 32
const FREQ_MAX:float = 3000.0
const MIN_DB:float = 80.0

var analyzer:AudioEffectSpectrumAnalyzerInstance = null
var gradient : GradientTexture 
var grd : Gradient 
var arr = [0.1,0.20,0.90,0.5,0.5,0.20]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gradient = GradientTexture.new()
	grd = Gradient.new()
	gradient.gradient = grd
	self.analyzer = AudioServer.get_bus_effect_instance( 0, 0 )
	
	pass # Replace with function boddy.


	
var custom_time : float = 0.0


func _process(delta: float) -> void:
	custom_time = wrapf(custom_time+delta,0.0,360.0)
	$MeshInstance2D2.material.set_shader_param("custom_time",custom_time)
	grd = Gradient.new()

	var prev_hz:float = 0.0

	for i in range( VU_COUNT ):
		var hz:float = ( i + 1 ) * FREQ_MAX / VU_COUNT
		var mag:float = self.analyzer.get_magnitude_for_frequency_range( prev_hz, hz ).length()
		var color = Color.white
		color.v = clamp( ( linear2db( mag ) + MIN_DB ) / MIN_DB, 0.0, 1.0 )
		grd.add_point(range_lerp(i,0,VU_COUNT-1,0.0,1.0),color)

	gradient.gradient = grd
#
#	$MeshInstance2D2.material.set_shader_param("color_s",gradient)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
